import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/resume_provider.dart';
import '../../providers/auth_provider.dart';
import 'add_experience_screen.dart';

class ResumeBuilderScreen extends StatefulWidget {

  const ResumeBuilderScreen({super.key});

  @override
  State<ResumeBuilderScreen> createState() => _ResumeBuilderScreenState();
}

class _ResumeBuilderScreenState extends State<ResumeBuilderScreen> {

  final skillController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final resumeProvider = Provider.of<ResumeProvider>(context);
    final auth = Provider.of<AuthProvider>(context);

    final userId = auth.user?.uid ?? "";

    return Scaffold(

      appBar: AppBar(
        title: const Text("Resume Builder"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            Row(

              children: [

                Expanded(

                  child: TextField(
                    controller: skillController,
                    decoration: const InputDecoration(
                      hintText: "Add Skill",
                    ),
                  ),

                ),

                IconButton(

                  icon: const Icon(Icons.add),

                  onPressed: () {

                    resumeProvider.addSkill(
                      userId,
                      skillController.text,
                    );

                    skillController.clear();

                  },

                )

              ],
            ),

            const SizedBox(height: 20),

            ElevatedButton(

              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddExperienceScreen(),
                  ),
                );

              },

              child: const Text("Add Experience"),

            ),

            const SizedBox(height: 20),

            Expanded(

              child: StreamBuilder(

                stream: resumeProvider.getSkills(userId),

                builder: (context, snapshot) {

                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final docs = snapshot.data!.docs;

                  return Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: docs.map<Widget>((doc) {

                      return Chip(

                        label: Text(doc['skillName']),

                        backgroundColor: Colors.blue.shade50,

                        deleteIcon: const Icon(Icons.close),

                        onDeleted: () {
                          resumeProvider.deleteSkill(doc.id);
                        },

                      );

                    }).toList(),
                  );

                },

              ),

            )

          ],
        ),
      ),
    );
  }
}