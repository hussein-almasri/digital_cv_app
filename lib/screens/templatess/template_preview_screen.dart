import 'package:flutter/material.dart';

class TemplatePreviewScreen extends StatelessWidget {

  final String templateName;

  const TemplatePreviewScreen({
    super.key,
    required this.templateName,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(templateName),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            Container(

              height: 500,

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius: BorderRadius.circular(12),

                boxShadow: [

                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black12,
                  )

                ],

              ),

              child: const Center(

                child: Text(
                  "CV Preview",
                  style: TextStyle(fontSize: 24),
                ),

              ),

            ),

            const SizedBox(height: 20),

            ElevatedButton(

              onPressed: (){

                ScaffoldMessenger.of(context).showSnackBar(

                  const SnackBar(
                    content: Text("Template Selected"),
                  ),

                );

              },

              child: const Text("Use Template"),

            )

          ],
        ),
      ),
    );
  }
}