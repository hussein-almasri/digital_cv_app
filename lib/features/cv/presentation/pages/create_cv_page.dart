import 'package:digital_cv_app/features/cv/presentation/providers/cv_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/cv_entity.dart';
import '../../domain/entities/skill_entity.dart';

class CreateCvPage extends ConsumerStatefulWidget {
  const CreateCvPage({super.key});

  @override
  ConsumerState<CreateCvPage> createState() => _CreateCvPageState();
}

class _CreateCvPageState extends ConsumerState<CreateCvPage> {

  final usernameController = TextEditingController();
  final bioController = TextEditingController();
  final skillsController = TextEditingController();

  bool isLoading = false;

  Future<void> saveCv() async {

    setState(() {
      isLoading = true;
    });

    try {

      final user = FirebaseAuth.instance.currentUser!;

      final skills = skillsController.text
          .split(',')
          .map((e) => SkillEntity(name: e.trim()))
          .toList();

      final cv = CvEntity(
        userId: user.uid,
        username: usernameController.text,
        email: user.email ?? "",
        bio: bioController.text,
        skills: skills,
        experiences: [],
        education: [],
      );

      final saveCvUseCase = ref.read(saveCvUseCaseProvider);

      await saveCvUseCase(cv);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("CV Saved Successfully")),
      );

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );

    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Create CV"),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            children: [

              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: "Username",
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: bioController,
                decoration: const InputDecoration(
                  labelText: "Bio",
                ),
                maxLines: 3,
              ),

              const SizedBox(height: 20),

              TextField(
                controller: skillsController,
                decoration: const InputDecoration(
                  labelText: "Skills (comma separated)",
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : saveCv,
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Save CV"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}