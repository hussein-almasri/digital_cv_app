import 'package:digital_cv_app/screens/templatess/template_preview_screen.dart' show TemplatePreviewScreen;
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TemplatesScreen extends StatelessWidget {

  const TemplatesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final templates = [

      {
        "name": "Modern CV",
        "image": "https://picsum.photos/400/600?1"
      },

      {
        "name": "Minimal CV",
        "image": "https://picsum.photos/400/600?2"
      },

      {
        "name": "Professional CV",
        "image": "https://picsum.photos/400/600?3"
      },

      {
        "name": "Creative CV",
        "image": "https://picsum.photos/400/600?4"
      },

];

    return Scaffold(

      appBar: AppBar(
        title: const Text("CV Templates"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: MasonryGridView.count(

          crossAxisCount: 2,

          crossAxisSpacing: 12,

          mainAxisSpacing: 12,

          itemCount: templates.length,

          itemBuilder: (context, index){

            final template = templates[index];

            return Card(

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  ClipRRect(

                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),

                    child: Image.network(
                      template["image"]!,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )

                  ),

                  Padding(

                    padding: const EdgeInsets.all(12),

                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Text(
                          template["name"]!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        ElevatedButton(

                          onPressed: (){

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TemplatePreviewScreen(
                                  templateName: template["name"]!,
                                ),
                              ),
                            );

                          },

                          child: const Text("Preview"),

                        )

                      ],
                    ),
                  )

                ],
              ),
            );

          },

        ),
      ),
    );
  }
}