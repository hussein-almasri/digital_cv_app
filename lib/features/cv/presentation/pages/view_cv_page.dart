import 'package:digital_cv_app/features/cv/domain/usecases/cv_provider.dart';
import 'package:digital_cv_app/features/cv/domain/entities/cv_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_plus/share_plus.dart';

import 'create_cv_page.dart';

class ViewCvPage extends ConsumerStatefulWidget {
  const ViewCvPage({super.key});

  @override
  ConsumerState<ViewCvPage> createState() => _ViewCvPageState();
}

class _ViewCvPageState extends ConsumerState<ViewCvPage> {
  CvEntity? cv;

  @override
  void initState() {
    super.initState();
    loadCv();
  }

  Future<void> loadCv() async {
    final user = FirebaseAuth.instance.currentUser!;

    final getCv = ref.read(getCvUseCaseProvider);

    final result = await getCv(user.uid);

    setState(() {
      cv = result;
    });
  }

  void shareCv() {
    final skillsText = cv!.skills
        .map((e) => e.name)
        .join(", ");

    final text = """
${cv!.username}

${cv!.bio}

Skills: $skillsText
""";

    Share.share(text);
  }

  @override
  Widget build(BuildContext context) {
    if (cv == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final skills = cv!.skills;
    final experiences = cv!.experiences;
    final education = cv!.education;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My CV"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            /// Avatar
            CircleAvatar(
              radius: 60,
              backgroundImage: cv!.profileImage.isNotEmpty
                  ? NetworkImage(cv!.profileImage)
                  : null,
              child: cv!.profileImage.isEmpty
                  ? const Icon(Icons.person, size: 40)
                  : null,
            ),

            const SizedBox(height: 20),

            /// Username
            Text(
              cv!.username,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            /// Bio
            Text(
              cv!.bio,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            /// Edit Button
            SizedBox(
              width: 150,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text("Edit CV"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CreateCvPage(
                        cv: cv,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            /// Share Button
            SizedBox(
              width: 150,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.share),
                label: const Text("Share CV"),
                onPressed: shareCv,
              ),
            ),

            const SizedBox(height: 30),

            /// Skills Title
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Skills",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: skills
                  .map((skill) => Chip(
                        label: Text(skill.name),
                      ))
                  .toList(),
            ),

            const SizedBox(height: 40),

            /// Experience Title
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

            const SizedBox(height: 10),

            Column(
              children: experiences.map((exp) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          exp.position,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(exp.company),

                        const SizedBox(height: 4),

                        Text("${exp.startDate} - ${exp.endDate}"),

                        const SizedBox(height: 8),

                        Text(exp.description),

                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 40),

            /// Education Title
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

            const SizedBox(height: 10),

            Column(
              children: education.map((edu) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          edu.degree,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(edu.school),

                        const SizedBox(height: 4),

                        Text("${edu.startYear} - ${edu.endYear}"),

                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}