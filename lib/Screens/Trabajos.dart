import 'package:flutter/material.dart';
import 'CrearTrabajo.dart'; // Asegúrate de importar la clase CrearTrabajo

class Trabajos extends StatefulWidget {
  @override
  _TrabajosState createState() => _TrabajosState();
}

class _TrabajosState extends State<Trabajos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trabajos"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navegar a la clase CrearTrabajo
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CrearTrabajo()),
            );
          },
          child: Text("Crear Trabajo"),
        ),
      ),
    );
  }
}
