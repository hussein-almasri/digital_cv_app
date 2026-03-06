import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../utils/app_colors.dart';
import '../../services/pdf_service.dart';

class AnalyticsScreen extends StatelessWidget {

  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final score = 0.85;

    return Scaffold(

      appBar: AppBar(
        title: const Text("Resume Analytics"),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Card(

              child: Padding(

                padding: const EdgeInsets.all(20),

                child: Column(

                  children: [

                    const Text(
                      "Resume Score",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "${(score * 100).toInt()} / 100",
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    LinearPercentIndicator(

                      lineHeight: 12,

                      percent: score,

                      progressColor: AppColors.primary,

                      backgroundColor: Colors.grey.shade200,

                      barRadius: const Radius.circular(10),

                    ),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Section Strength",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            _sectionBar("Skills", 0.9),
            _sectionBar("Experience", 0.8),
            _sectionBar("Education", 0.5),
            _sectionBar("Projects", 0.3),

            const SizedBox(height: 30),

            const Text(
              "Missing Sections",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const ListTile(
              leading: Icon(Icons.warning, color: Colors.orange),
              title: Text("Add Projects to showcase your work"),
            ),

            const ListTile(
              leading: Icon(Icons.warning, color: Colors.orange),
              title: Text("Add Certificates to increase credibility"),
            ),

            const ListTile(
              leading: Icon(Icons.warning, color: Colors.orange),
              title: Text("Add Languages to improve global reach"),
            ),

            const SizedBox(height: 30),

            const Text(
              "Tips to Improve",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Card(

              child: Padding(

                padding: const EdgeInsets.all(16),

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: const [

                    Text("• Use action verbs in experience descriptions"),

                    SizedBox(height: 8),

                    Text("• Add measurable achievements"),

                    SizedBox(height: 8),

                    Text("• Keep your CV under 2 pages"),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(

              onPressed: () {

                PdfService.generateCV(

                  name: "John Doe",

                  email: "john@email.com",

                  bio: "Flutter Developer passionate about building apps.",

                  skills: [
                    "Flutter",
                    "Dart",
                    "Firebase",
                    "UI Design"
                  ],

                );

              },

              child: const Text("Export CV as PDF"),

            ),

          ],
        ),
      ),
    );
  }

  Widget _sectionBar(String title, double percent){

    return Padding(

      padding: const EdgeInsets.only(bottom: 16),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(title),

          const SizedBox(height: 6),

          LinearPercentIndicator(

            lineHeight: 8,

            percent: percent,

            progressColor: Colors.green,

            backgroundColor: Colors.grey.shade200,

            barRadius: const Radius.circular(10),

          ),

        ],
      ),
    );
  }
}