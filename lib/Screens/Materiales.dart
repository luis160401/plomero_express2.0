import 'package:flutter/material.dart';

class MaterialesPage extends StatefulWidget {
  final List<Map<String, dynamic>> materialesSeleccionados;
  final Function(String, int, double, String) onMaterialAdded;
  final Function(int) onMaterialRemoved;
  final Function(int, String, int, double, String) onMaterialEdited;

  MaterialesPage({
    required this.materialesSeleccionados,
    required this.onMaterialAdded,
    required this.onMaterialRemoved,
    required this.onMaterialEdited,
  });

  @override
  _MaterialesPageState createState() => _MaterialesPageState();
}

class _MaterialesPageState extends State<MaterialesPage> {
  String? selectedTrabajo;
  List<String> trabajosDisponibles = ['Trabajo Fitness', 'Trabajo Altisimo', 'Trabajo Calimocho'];

  List<Map<String, dynamic>> materialesDisponibles = [
    {'nombre': 'Tubo PVC 1/2" x 3m', 'seleccionado': false, 'cantidad': 1, 'precio': 3.50},
    {'nombre': 'Tubo PVC 3/4" x 3m', 'seleccionado': false, 'cantidad': 1, 'precio': 5.00},
    {'nombre': 'Tubo PVC 1" x 3m', 'seleccionado': false, 'cantidad': 1, 'precio': 7.00},
    {'nombre': 'Tubo CPVC 1/2" x 3m', 'seleccionado': false, 'cantidad': 1, 'precio': 6.00},
    {'nombre': 'Tubo CPVC 3/4" x 3m', 'seleccionado': false, 'cantidad': 1, 'precio': 8.00},
    {'nombre': 'Tubo galvanizado 1/2" x 3m', 'seleccionado': false, 'cantidad': 1, 'precio': 12.00},
    {'nombre': 'Tubo galvanizado 3/4" x 3m', 'seleccionado': false, 'cantidad': 1, 'precio': 15.00},
    {'nombre': 'Tubo PEX 1/2" x 10m', 'seleccionado': false, 'cantidad': 1, 'precio': 20.00},
    {'nombre': 'Codo PVC 90° 1/2"', 'seleccionado': false, 'cantidad': 1, 'precio': 0.80},
    {'nombre': 'Codo PVC 90° 3/4"', 'seleccionado': false, 'cantidad': 1, 'precio': 1.00},
    {'nombre': 'Codo PVC 45° 1/2"', 'seleccionado': false, 'cantidad': 1, 'precio': 0.90},
    {'nombre': 'Codo CPVC 90° 1/2"', 'seleccionado': false, 'cantidad': 1, 'precio': 1.50},
    {'nombre': 'Tee PVC 1/2"', 'seleccionado': false, 'cantidad': 1, 'precio': 1.20},
    {'nombre': 'Tee PVC 3/4"', 'seleccionado': false, 'cantidad': 1, 'precio': 1.50},
    {'nombre': 'Tee CPVC 1/2"', 'seleccionado': false, 'cantidad': 1, 'precio': 1.80},
    {'nombre': 'Reducción PVC 3/4" a 1/2"', 'seleccionado': false, 'cantidad': 1, 'precio': 1.00},
    {'nombre': 'Reducción PVC 1" a 3/4"', 'seleccionado': false, 'cantidad': 1, 'precio': 1.20},
    {'nombre': 'Adaptador macho PVC 1/2"', 'seleccionado': false, 'cantidad': 1, 'precio': 0.90},
    {'nombre': 'Adaptador hembra PVC 1/2"', 'seleccionado': false, 'cantidad': 1, 'precio': 0.90},
    {'nombre': 'Rosca macho metálica 1/2"', 'seleccionado': false, 'cantidad': 1, 'precio': 2.50},
    {'nombre': 'Rosca hembra metálica 1/2"', 'seleccionado': false, 'cantidad': 1, 'precio': 2.50},
    {'nombre': 'Unión PVC 1/2"', 'seleccionado': false, 'cantidad': 1, 'precio': 1.10},
    {'nombre': 'Unión PVC 3/4"', 'seleccionado': false, 'cantidad': 1, 'precio': 1.40},
    {'nombre': 'Llave de paso PVC 1/2"', 'seleccionado': false, 'cantidad': 1, 'precio': 5.00},
    {'nombre': 'Llave de paso PVC 3/4"', 'seleccionado': false, 'cantidad': 1, 'precio': 7.00},
    {'nombre': 'Llave de paso metálica 1/2"', 'seleccionado': false, 'cantidad': 1, 'precio': 10.00},
    {'nombre': 'Válvula de retención PVC 1/2"', 'seleccionado': false, 'cantidad': 1, 'precio': 8.00},
    {'nombre': 'Válvula de retención PVC 3/4"', 'seleccionado': false, 'cantidad': 1, 'precio': 10.00},
    {'nombre': 'Válvula de esfera 1/2"', 'seleccionado': false, 'cantidad': 1, 'precio': 12.00},
    {'nombre': 'Válvula de compuerta 3/4"', 'seleccionado': false, 'cantidad': 1, 'precio': 15.00},
    {'nombre': 'Cinta teflón 10m', 'seleccionado': false, 'cantidad': 1, 'precio': 1.50},
    {'nombre': 'Sellador de roscas líquido 50ml', 'seleccionado': false, 'cantidad': 1, 'precio': 4.00},
    {'nombre': 'Cemento PVC 250ml', 'seleccionado': false, 'cantidad': 1, 'precio': 3.50},
    {'nombre': 'Cemento CPVC 250ml', 'seleccionado': false, 'cantidad': 1, 'precio': 5.00},
    {'nombre': 'Limpia tuberías 500ml', 'seleccionado': false, 'cantidad': 1, 'precio': 2.50},
    {'nombre': 'Abrazadera metálica 1/2" (paquete de 10)', 'seleccionado': false, 'cantidad': 1, 'precio': 6.00},
    {'nombre': 'Abrazadera metálica 3/4" (paquete de 10)', 'seleccionado': false, 'cantidad': 1, 'precio': 7.00},
    {'nombre': 'Tornillos y tacos (paquete de 20)', 'seleccionado': false, 'cantidad': 1, 'precio': 3.00},
    {'nombre': 'Manguera para lavamanos 1/2" x 40cm', 'seleccionado': false, 'cantidad': 1, 'precio': 3.50},
    {'nombre': 'Manguera para inodoro 1/2" x 50cm', 'seleccionado': false, 'cantidad': 1, 'precio': 4.00},
    {'nombre': 'Manguera flexible para calentador 3/4" x 60cm', 'seleccionado': false, 'cantidad': 1, 'precio': 10.00},
    {'nombre': 'Manguera de jardín 1/2" x 20m', 'seleccionado': false, 'cantidad': 1, 'precio': 25.00},
    {'nombre': 'Llave mezcladora para lavamanos', 'seleccionado': false, 'cantidad': 1, 'precio': 20.00},
    {'nombre': 'Llave mezcladora para fregadero', 'seleccionado': false, 'cantidad': 1, 'precio': 30.00},
    {'nombre': 'Llave de ducha monocomando', 'seleccionado': false, 'cantidad': 1, 'precio': 40.00},
    {'nombre': 'Cabezal de ducha ajustable', 'seleccionado': false, 'cantidad': 1, 'precio': 15.00},
    {'nombre': 'Grifo de pared 1/2"', 'seleccionado': false, 'cantidad': 1, 'precio': 10.00},
    {'nombre': 'Desagüe para lavamanos con tapón automático', 'seleccionado': false, 'cantidad': 1, 'precio': 10.00},
    {'nombre': 'Sifón flexible PVC 1 1/2" para lavamanos', 'seleccionado': false, 'cantidad': 1, 'precio': 7.00},
    {'nombre': 'Sifón flexible PVC 1 1/2" para fregadero', 'seleccionado': false, 'cantidad': 1, 'precio': 9.00},
    {'nombre': 'Tubo de desagüe PVC 2"', 'seleccionado': false, 'cantidad': 1, 'precio': 4.00},
    {'nombre': 'Rejilla de desagüe metálica 4"', 'seleccionado': false, 'cantidad': 1, 'precio': 5.00},
    {'nombre': 'Tanque de agua plástico 100 galones', 'seleccionado': false, 'cantidad': 1, 'precio': 80.00},
    {'nombre': 'Tanque de agua plástico 200 galones', 'seleccionado': false, 'cantidad': 1, 'precio': 150.00},
    {'nombre': 'Flotador para tanque 1/2"', 'seleccionado': false, 'cantidad': 1, 'precio': 8.00},
    {'nombre': 'Válvula de llenado para tanque', 'seleccionado': false, 'cantidad': 1, 'precio': 12.00},
    {'nombre': 'Bomba de agua 1/2 HP', 'seleccionado': false, 'cantidad': 1, 'precio': 120.00},
    {'nombre': 'Bomba de agua 1 HP', 'seleccionado': false, 'cantidad': 1, 'precio': 180.00},
    {'nombre': 'Bomba sumergible para drenaje', 'seleccionado': false, 'cantidad': 1, 'precio': 180.00},
    {'nombre': 'Bomba periférica 1/2 HP', 'seleccionado': false, 'cantidad': 1, 'precio': 100.00},
  ];

  void _showEditDialog(BuildContext context, int index) {
    final material = widget.materialesSeleccionados[index];
    String nombre = material['material'];
    int cantidad = material['cantidad'];
    double precio = material['precio'];
    String trabajo = material['trabajo'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(
            'Editar Material',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setStateDialog) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.build),
                        labelStyle: TextStyle(fontSize: 12),
                      ),
                      controller: TextEditingController(text: nombre),
                      onChanged: (value) => nombre = value,
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Cantidad',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.format_list_numbered),
                        labelStyle: TextStyle(fontSize: 12),
                      ),
                      keyboardType: TextInputType.number,
                      controller: TextEditingController(text: cantidad.toString()),
                      onChanged: (value) =>
                          cantidad = int.tryParse(value) ?? cantidad,
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Precio',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.attach_money),
                        labelStyle: TextStyle(fontSize: 12),
                      ),
                      keyboardType: TextInputType.number,
                      controller: TextEditingController(text: precio.toString()),
                      onChanged: (value) =>
                          precio = double.tryParse(value) ?? precio,
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: trabajo,
                      decoration: InputDecoration(
                        labelText: 'Trabajo',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.work),
                        labelStyle: TextStyle(fontSize: 12),
                      ),
                      isExpanded: true,
                      onChanged: (String? newValue) {
                        setStateDialog(() {
                          if (newValue != null) {
                            trabajo = newValue;
                          }
                        });
                      },
                      items: trabajosDisponibles
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: TextStyle(fontSize: 12)));
                      }).toList(),
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar',
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
            ),
            ElevatedButton(
              onPressed: () {
                widget.onMaterialEdited(index, nombre, cantidad, precio, trabajo);
                Navigator.pop(context);
              },
              child: Text('Guardar', style: TextStyle(fontSize: 12)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _agregarMaterialesSeleccionados() {
    if (selectedTrabajo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, selecciona un trabajo primero.',
              style: TextStyle(fontSize: 12)),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    for (var material in materialesDisponibles) {
      if (material['seleccionado'] && material['cantidad'] > 0) {
        widget.onMaterialAdded(
          material['nombre'],
          material['cantidad'],
          material['precio'],
          selectedTrabajo!,
        );
        setState(() {
          material['seleccionado'] = false;
          material['cantidad'] = 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Alturas dinámicas basadas en el tamaño de pantalla.
    final screenHeight = MediaQuery.of(context).size.height;
    final availableHeight = screenHeight -
        kToolbarHeight -
        kBottomNavigationBarHeight -
        100;
    final materialesDisponiblesHeight = availableHeight * 0.4;
    final materialesAgregadosHeight = availableHeight * 0.3;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Selección de Trabajo
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.work, color: Colors.blue, size: 20),
                          SizedBox(width: 10),
                          Text(
                            "Selecciona un Trabajo",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: selectedTrabajo,
                        hint: Text("Selecciona un trabajo",
                            style: TextStyle(fontSize: 12)),
                        isExpanded: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedTrabajo = newValue;
                          });
                        },
                        items: trabajosDisponibles
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: TextStyle(fontSize: 12)));
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Selección de Materiales
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.build, color: Colors.blue, size: 20),
                          SizedBox(width: 10),
                          Text(
                            "Selecciona Materiales",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: materialesDisponiblesHeight,
                        child: ListView.builder(
                          itemCount: materialesDisponibles.length,
                          itemBuilder: (context, index) {
                            final material = materialesDisponibles[index];
                            return Card(
                              elevation: 2,
                              margin: EdgeInsets.symmetric(vertical: 5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: material['seleccionado'],
                                      onChanged: (bool? value) {
                                        setState(() {
                                          material['seleccionado'] =
                                              value ?? false;
                                        });
                                      },
                                      activeColor: Colors.blue,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        material['nombre'],
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          labelText: 'Precio',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          labelStyle: TextStyle(fontSize: 10),
                                        ),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          material['precio'] =
                                              double.tryParse(value) ??
                                                  material['precio'];
                                        },
                                        controller: TextEditingController(
                                            text: material['precio']
                                                .toString()),
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          labelText: 'Cantidad',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          labelStyle: TextStyle(fontSize: 10),
                                        ),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          material['cantidad'] =
                                              int.tryParse(value) ??
                                                  material['cantidad'];
                                        },
                                        controller: TextEditingController(
                                            text: material['cantidad']
                                                .toString()),
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Materiales Agregados
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.list_alt, color: Colors.blue, size: 20),
                          SizedBox(width: 10),
                          Text(
                            "Materiales Agregados",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: materialesAgregadosHeight,
                        child: widget.materialesSeleccionados.isEmpty
                            ? Center(
                                child: Text(
                                  "No hay materiales agregados",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              )
                            : ListView.builder(
                                itemCount:
                                    widget.materialesSeleccionados.length,
                                itemBuilder: (context, index) {
                                  final material =
                                      widget.materialesSeleccionados[index];
                                  return Card(
                                    elevation: 2,
                                    margin:
                                        EdgeInsets.symmetric(vertical: 5),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ListTile(
                                      leading: Icon(Icons.build_circle,
                                          color: Colors.blue),
                                      title: Text(
                                        "${material['trabajo']} - ${material['material']}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        "Cant: ${material['cantidad']} - Precio: \$${material['precio'].toStringAsFixed(2)}",
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 10),
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.edit,
                                                color: Colors.blue),
                                            onPressed: () =>
                                                _showEditDialog(context, index),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: () =>
                                                widget.onMaterialRemoved(index),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _agregarMaterialesSeleccionados,
        label: Text("Agregar Materiales", style: TextStyle(fontSize: 12)),
        icon: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
