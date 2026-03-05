import 'package:digital_cv_app/features/cv/domain/usecases/cv_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ViewCvPage extends ConsumerStatefulWidget {
  const ViewCvPage({super.key});

  @override
  ConsumerState<ViewCvPage> createState() => _ViewCvPageState();
}

class _ViewCvPageState extends ConsumerState<ViewCvPage> {

  Map<String, dynamic>? cv;

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
      cv = result as Map<String, dynamic>?;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (cv == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final skills = cv!['skills'] as List;

    return Scaffold(

      appBar: AppBar(
        title: const Text("My CV"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              cv!['username'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(cv!['bio']),

            const SizedBox(height: 30),

            const Text(
              "Skills",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              children: skills
                  .map((e) => Chip(label: Text(e)))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}