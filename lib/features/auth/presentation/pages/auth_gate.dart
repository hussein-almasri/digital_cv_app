import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../cv/presentation/pages/view_cv_page.dart';
import 'login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),

      builder: (context, snapshot) {

        /// Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        /// Logged In
        if (snapshot.hasData) {
          return const ViewCvPage();
        }

        /// Not Logged
        return const LoginPage();
      },
    );
  }
}