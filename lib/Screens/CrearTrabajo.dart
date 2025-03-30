import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class CrearTrabajo extends StatefulWidget {
  @override
  _CrearTrabajoState createState() => _CrearTrabajoState();
}

class _CrearTrabajoState extends State<CrearTrabajo> {
  final TextEditingController _NombreCliente = TextEditingController();
  final TextEditingController _TelefonoCliente = TextEditingController();
  final TextEditingController _CorreoElectronico = TextEditingController();
  final TextEditingController _Materiales = TextEditingController();
  final TextEditingController _Provincia = TextEditingController();
  final TextEditingController _Sector = TextEditingController();

  String? trabajoSeleccionado;
  List<String> tiposdeTrabajos = [
    'Proyecto (a todo Costo)',
    'Proyecto (solo mano de obra)',
    'Instalación Particular (a todo costo)',
    'Instalación Particular (solo mano de obra)'
  ];

  String? tipoDeClienteSeleccionado;
  List<String> tiposCliente = [
    'Empresa Grande',
    'Empresa Pequeña',
    'Ingeniero',
    'Cliente particular'
  ];

  String? provinciaSeleccionada;
  List<String> provincias = [
    'Azua', 'Bahoruco', 'Barahona', 'Dajabón', 'Distrito Nacional', 'Duarte',
    'Elías Piña', 'El Seibo', 'Espaillat', 'Hato Mayor', 'Hermanas Mirabal',
    'Independencia', 'La Altagracia', 'La Romana', 'La Vega', 'María Trinidad Sánchez',
    'Monseñor Nouel', 'Monte Cristi', 'Monte Plata', 'Pedernales', 'Peravia',
    'Puerto Plata', 'Samaná', 'San Cristóbal', 'San José de Ocoa', 'San Juan',
    'San Pedro de Macorís', 'Santiago', 'Santiago Rodríguez', 'Santo Domingo', 'Valverde'
  ];

  String? municipioSeleccionado;
  Map<String, List<String>> municipios = {
    'Santo Domingo': ['Santo Domingo Este', 'Santo Domingo Oeste', 'Santo Domingo Norte'],
    'San Cristóbal': ['San Cristóbal', 'Villa Altagracia', 'Bajos de Haina'],
    'Santiago': ['Santiago de los Caballeros', 'Puñal', 'Licey al Medio'],
    'La Vega': ['La Vega', 'Constanza', 'Jarabacoa']
  };

  String? sectorSeleccionado;
  Map<String, List<String>> sectores = {
    'Santo Domingo Este': ['Los Mina', 'La Ureña', 'Rafael María'],
    'Santo Domingo Oeste': ['Los Alcarrizos', 'Pantoja', 'Pedro Brand'],
    'Santiago de los Caballeros': ['El Ensanche Libertad', 'Las Colinas', 'Bella Vista'],
    'La Vega': ['La Vega', 'El Batey', 'Jarabacoa'],
  };

  DateTime? fechadeInicioSeleccionada;
  DateTime? fechadeTerminoSeleccionada;
  File? archivoSeleccionado;

  Future<void> _selectDate(BuildContext context, ValueSetter<DateTime> setDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setDate(picked);
    }
  }

   Future<void> _seleccionarArchivo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any, // Puedes cambiarlo a FileType.image, FileType.video, etc.
    );

    if (result != null) {
      setState(() {
        archivoSeleccionado = File(result.files.single.path!);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crear Trabajo"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Selección de trabajo
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    value: trabajoSeleccionado,
                    hint: Text('Selecciona una opción'),
                    onChanged: (String? newValue) {
                      setState(() {
                        trabajoSeleccionado = newValue;
                      });
                    },
                    items: tiposdeTrabajos.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  ),
                  SizedBox(width: 10),
                  DropdownButton<String>(
                    value: tipoDeClienteSeleccionado,
                    hint: Text('Selecciona una opción'),
                    onChanged: (String? newValue) {
                      setState(() {
                        tipoDeClienteSeleccionado = newValue;
                      });
                    },
                    items: tiposCliente.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            ),

            // Información del cliente
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _NombreCliente,
                      decoration: InputDecoration(labelText: "Nombre del Cliente"),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _TelefonoCliente,
                      decoration: InputDecoration(labelText: "Telefono"),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _CorreoElectronico,
                      decoration: InputDecoration(labelText: "Correo Electronico"),
                    ),
                  ),
                ],
              ),
            ),

            // Selección de fechas
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: TextEditingController(
                        text: fechadeInicioSeleccionada != null
                            ? "${fechadeInicioSeleccionada!.day}/${fechadeInicioSeleccionada!.month}/${fechadeInicioSeleccionada!.year}"
                            : '',
                      ),
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Selecciona una fecha de inicio",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(
                            context,
                            (date) => setState(() {
                              fechadeInicioSeleccionada = date;
                            }),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: TextEditingController(
                        text: fechadeTerminoSeleccionada != null
                            ? "${fechadeTerminoSeleccionada!.day}/${fechadeTerminoSeleccionada!.month}/${fechadeTerminoSeleccionada!.year}"
                            : '',
                      ),
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Selecciona una fecha de término",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(
                            context,
                            (date) => setState(() {
                              fechadeTerminoSeleccionada = date;
                            }),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Selección de provincia
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    value: provinciaSeleccionada,
                    hint: Text('Selecciona una provincia'),
                    onChanged: (String? newValue) {
                      setState(() {
                        provinciaSeleccionada = newValue;
                        municipioSeleccionado = null; // Reseteamos el municipio
                      });
                    },
                    items: provincias.map<DropdownMenuItem<String>>(
                      (String provincia) {
                        return DropdownMenuItem<String>(
                          value: provincia,
                          child: Text(provincia),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            ),
          
          ElevatedButton(
              onPressed: _seleccionarArchivo,
              child: Text("Seleccionar Archivo"),
            ),

            SizedBox(height: 20),

            archivoSeleccionado != null
                ? Text("Archivo: ${archivoSeleccionado!.path.split('/').last}")
                : Text("No se ha seleccionado ningún archivo."),
          ],
        ),
      ),
    );
  }
}
