import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Mapas extends StatefulWidget {
  @override
  _MapasState createState() => _MapasState();
}

class _MapasState extends State<Mapas> {
  GoogleMapController? _controller;
  LatLng _currentLocation = LatLng(37.7749, -122.4194); // Valor inicial (San Francisco)
  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.7749, -122.4194), // Ejemplo: San Francisco
    zoom: 10,
  );
  Set<Marker> _markers = {};
  final String apiKey = "TU_API_KEY"; // Asegúrate de usar tu clave de API
  TextEditingController _searchController = TextEditingController(text: "Ferreterías");

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    try {
      Position position = await _determinePosition();
      _currentLocation = LatLng(position.latitude, position.longitude);

      if (!mounted) return;
      setState(() {
        _markers.add(Marker(
          markerId: MarkerId("currentLocation"),
          position: _currentLocation,
          infoWindow: InfoWindow(title: "Mi ubicación"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ));
      });

      _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _currentLocation, zoom: 14),
        ),
      );

      await _fetchNearbyPlaces();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  Future<Position> _determinePosition() async {
    var status = await Permission.location.request();

    if (status.isGranted) {
      return await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Permiso de Ubicación denegado")));
      throw Exception("Permiso de Ubicación denegado");
    }
  }

  Future<void> _fetchNearbyPlaces() async {
    LatLng tempLocation = _currentLocation;
    final url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${tempLocation.latitude},${tempLocation.longitude}&radius=2000&type=hardware_store&key=$apiKey";
    print("Solicitando lugares cercanos: $url");

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> places = data["results"];

      print("Lugares encontrados: ${places.length}");

      Set<Marker> newMarkers = places.map((place) {
        final location = place["geometry"]["location"];
        return Marker(
          markerId: MarkerId(place["place_id"]),
          position: LatLng(location["lat"], location["lng"]),
          infoWindow: InfoWindow(title: place["name"]),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        );
      }).toSet();

      setState(() {
        _markers.addAll(newMarkers);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error en la solicitud: ${response.body}")));
    }
  }

  // ✅ Agregado: Función para realizar búsqueda según el texto en la barra de búsqueda
  Future<void> _searchPlaces(String query) async {
    LatLng tempLocation = _currentLocation;
    final url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&location=${tempLocation.latitude},${tempLocation.longitude}&radius=2000&key=$apiKey";
    print("Buscando lugares: $url");

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> places = data["results"];

      print("Lugares encontrados: ${places.length}");

      Set<Marker> newMarkers = places.map((place) {
        final location = place["geometry"]["location"];
        return Marker(
          markerId: MarkerId(place["place_id"]),
          position: LatLng(location["lat"], location["lng"]),
          infoWindow: InfoWindow(title: place["name"]),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        );
      }).toSet();

      setState(() {
        _markers.clear(); // ✅ Agregado: Limpiar los marcadores previos antes de agregar nuevos
        _markers.addAll(newMarkers);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error en la solicitud: ${response.body}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mapas")),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: _currentLocation, zoom: 14),
            onMapCreated: (controller) {
              _controller = controller;
              _controller?.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(target: _currentLocation, zoom: 14),
                ),
              );
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: _markers,
          ),
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Buscar Lugares",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
                onSubmitted: (value) {
                  _searchPlaces(value); // ✅ Agregado: Llamada a la función de búsqueda
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
