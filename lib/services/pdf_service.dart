import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfService {

  static Future generateCV({

    required String name,
    required String email,
    required String bio,
    required List skills,

  }) async {

    final pdf = pw.Document();

    pdf.addPage(

      pw.Page(

        build: (pw.Context context) {

          return pw.Padding(

            padding: const pw.EdgeInsets.all(24),

            child: pw.Column(

              crossAxisAlignment: pw.CrossAxisAlignment.start,

              children: [

                pw.Text(
                  name,
                  style: pw.TextStyle(
                    fontSize: 28,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),

                pw.SizedBox(height: 5),

                pw.Text(email),

                pw.SizedBox(height: 20),

                pw.Text(
                  "About Me",
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),

                pw.SizedBox(height: 5),

                pw.Text(bio),

                pw.SizedBox(height: 20),

                pw.Text(
                  "Skills",
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),

                pw.SizedBox(height: 10),

                pw.Wrap(

                  spacing: 10,

                  children: skills.map<pw.Widget>((skill){

                    return pw.Container(

                      padding: const pw.EdgeInsets.all(6),

                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(),
                      ),

                      child: pw.Text(skill),

                    );

                  }).toList(),

                )

              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );

  }

}