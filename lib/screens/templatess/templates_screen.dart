import 'package:digital_cv_app/screens/template_preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TemplatesScreen extends StatelessWidget {

  const TemplatesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final templates = [

      {
        "name": "Modern CV",
        "image":
        "https://cdn.dribbble.com/users/1787323/screenshots/15302357/media/6dfc5a0d7e3e2392d6f4858cc5b64cf2.png"
      },

      {
        "name": "Minimal CV",
        "image":
        "https://cdn.dribbble.com/users/239910/screenshots/14510294/media/7c4f7cbdeb18f0bc33bd583a14bcbb0d.png"
      },

      {
        "name": "Professional CV",
        "image":
        "https://cdn.dribbble.com/users/1218630/screenshots/16593444/media/15e79b3e4eab0e8625995fe9ad49fdb4.png"
      },

      {
        "name": "Creative CV",
        "image":
        "https://cdn.dribbble.com/users/1787323/screenshots/15295867/media/b4dff78eaefdd8f2fa14a3cd59cab949.png"
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
                      fit: BoxFit.cover,
                    ),

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