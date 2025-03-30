import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class FacturacionPage extends StatelessWidget {
  final List<Map<String, dynamic>> materialesSeleccionados;

  FacturacionPage({required this.materialesSeleccionados});

  double get subtotal {
    return materialesSeleccionados.fold(
      0.0,
      (sum, item) => sum + (item['cantidad'] * item['precio']),
    );
  }

  double get itbis {
    return subtotal * 0.18;
  }

  double get totalFinal {
    return subtotal + itbis;
  }

  Future<void> _generatePDF(BuildContext context) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Text('Factura - Plomero Express',
                style: pw.TextStyle(fontSize: 24)),
            pw.SizedBox(height: 20),
            pw.Table.fromTextArray(
              headers: ['Trabajo', 'Material', 'Cantidad', 'Precio', 'Subtotal'],
              data: materialesSeleccionados.map((m) {
                return [
                  m['trabajo'],
                  m['material'],
                  m['cantidad'].toString(),
                  '\$${m['precio'].toStringAsFixed(2)}',
                  '\$${(m['cantidad'] * m['precio']).toStringAsFixed(2)}',
                ];
              }).toList(),
            ),
            pw.SizedBox(height: 20),
            pw.Text('Subtotal: \$${subtotal.toStringAsFixed(2)}',
                style: pw.TextStyle(fontSize: 18)),
            pw.Text('ITBIS (18%): \$${itbis.toStringAsFixed(2)}',
                style: pw.TextStyle(fontSize: 18)),
            pw.Text('Total: \$${totalFinal.toStringAsFixed(2)}',
                style: pw.TextStyle(fontSize: 18)),
          ];
        },
      ),
    );
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Encabezado de la factura
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.receipt_long, color: Colors.blue, size: 20),
                      SizedBox(width: 10),
                      Text(
                        "Factura de Materiales",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Lista de materiales en la factura
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
                            "Lista de Materiales",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      materialesSeleccionados.isEmpty
                          ? Center(
                              child: Text(
                                "No hay materiales en la factura",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: materialesSeleccionados.length,
                              itemBuilder: (context, index) {
                                final material = materialesSeleccionados[index];
                                return Card(
                                  elevation: 2,
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
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
                                      "Cant: ${material['cantidad']} - Precio: \$${material['precio'].toStringAsFixed(2)} - Subtotal: \$${(material['cantidad'] * material['precio']).toStringAsFixed(2)}",
                                      style: TextStyle(
                                          color: Colors.grey[600], fontSize: 10),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Resumen de la factura
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.blue[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.attach_money, color: Colors.blue, size: 20),
                          SizedBox(width: 10),
                          Text(
                            "Resumen de Factura",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Subtotal:",
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[800]),
                          ),
                          Text(
                            "\$${subtotal.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "ITBIS (18%):",
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[800]),
                          ),
                          Text(
                            "\$${itbis.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Divider(height: 20, thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total:",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800]),
                          ),
                          Text(
                            "\$${totalFinal.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () => _generatePDF(context),
                  icon: Icon(Icons.picture_as_pdf),
                  label: Text("Generar PDF", style: TextStyle(fontSize: 12)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    textStyle: TextStyle(fontSize: 12),
                    elevation: 5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
