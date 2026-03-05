import 'package:digital_cv_app/features/cv/presentation/providers/cv_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../../../services/image_upload_service.dart';
import '../../domain/entities/cv_entity.dart';
import '../../domain/entities/skill_entity.dart';
import '../../domain/entities/experience_entity.dart';
import '../../domain/entities/education_entity.dart';

class CreateCvPage extends ConsumerStatefulWidget {
  final CvEntity? cv;

  const CreateCvPage({
    super.key,
    this.cv,
  });

  @override
  ConsumerState<CreateCvPage> createState() => _CreateCvPageState();
}

class _CreateCvPageState extends ConsumerState<CreateCvPage> {

  final usernameController = TextEditingController();
  final bioController = TextEditingController();
  final skillsController = TextEditingController();

  final companyController = TextEditingController();
  final positionController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final descriptionController = TextEditingController();

  final schoolController = TextEditingController();
  final degreeController = TextEditingController();
  final startYearController = TextEditingController();
  final endYearController = TextEditingController();

  bool isLoading = false;

  File? imageFile;
  final picker = ImagePicker();

  String imageUrl = "";

  @override
  void initState() {
    super.initState();

    if (widget.cv != null) {

      usernameController.text = widget.cv!.username;
      bioController.text = widget.cv!.bio;

      skillsController.text =
          widget.cv!.skills.map((e) => e.name).join(", ");

      imageUrl = widget.cv!.profileImage;

      if (widget.cv!.experiences.isNotEmpty) {
        final exp = widget.cv!.experiences.first;

        companyController.text = exp.company;
        positionController.text = exp.position;
        startDateController.text = exp.startDate;
        endDateController.text = exp.endDate;
        descriptionController.text = exp.description;
      }

      if (widget.cv!.education.isNotEmpty) {
        final edu = widget.cv!.education.first;

        schoolController.text = edu.school;
        degreeController.text = edu.degree;
        startYearController.text = edu.startYear;
        endYearController.text = edu.endYear;
      }
    }
  }

  Future<void> pickImage() async {

    final picked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  Future<void> saveCv() async {

    setState(() {
      isLoading = true;
    });

    try {

      final user = FirebaseAuth.instance.currentUser!;

      if (imageFile != null) {
        final uploader = ImageUploadService();
        imageUrl = await uploader.uploadProfileImage(
          imageFile!,
          user.uid,
        );
      }

      final skills = skillsController.text
          .split(',')
          .map((e) => SkillEntity(name: e.trim()))
          .toList();

      final experiences = [
        ExperienceEntity(
          company: companyController.text,
          position: positionController.text,
          startDate: startDateController.text,
          endDate: endDateController.text,
          description: descriptionController.text,
        )
      ];

      final education = [
        EducationEntity(
          school: schoolController.text,
          degree: degreeController.text,
          startYear: startYearController.text,
          endYear: endYearController.text,
        )
      ];

      final cv = CvEntity(
        userId: user.uid,
        username: usernameController.text,
        email: user.email ?? "",
        bio: bioController.text,
        profileImage: imageUrl,
        skills: skills,
        experiences: experiences,
        education: education,
      );

      final saveCvUseCase = ref.read(saveCvUseCaseProvider);

      await saveCvUseCase(cv);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("CV Saved Successfully")),
      );

      Navigator.pop(context);

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

              GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: imageFile != null
                      ? FileImage(imageFile!)
                      : (imageUrl.isNotEmpty
                          ? NetworkImage(imageUrl)
                          : null) as ImageProvider?,
                  child: imageFile == null && imageUrl.isEmpty
                      ? const Icon(Icons.add_a_photo)
                      : null,
                ),
              ),

              const SizedBox(height: 30),

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

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Experience",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: companyController,
                decoration: const InputDecoration(
                  labelText: "Company",
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: positionController,
                decoration: const InputDecoration(
                  labelText: "Position",
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: startDateController,
                decoration: const InputDecoration(
                  labelText: "Start Date",
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: endDateController,
                decoration: const InputDecoration(
                  labelText: "End Date",
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description",
                ),
                maxLines: 3,
              ),

              const SizedBox(height: 30),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Education",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: schoolController,
                decoration: const InputDecoration(
                  labelText: "University / School",
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: degreeController,
                decoration: const InputDecoration(
                  labelText: "Degree",
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: startYearController,
                decoration: const InputDecoration(
                  labelText: "Start Year",
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: endYearController,
                decoration: const InputDecoration(
                  labelText: "End Year",
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