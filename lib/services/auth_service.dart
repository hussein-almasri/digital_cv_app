import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register
  Future<User?> register(String email, String password) async {

    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = result.user;

    if (user != null) {

      // استخراج الاسم من الإيميل
      String username = email.split("@")[0];

      // جعل أول حرف Capital
      username = username[0].toUpperCase() + username.substring(1);

      // إنشاء profile تلقائياً في Firestore
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .set({

        "name": username,
        "email": email,
        "bio": "",
        "avatar": ""

      });

    }

    return user;

  }

  // Login
  Future<User?> login(String email, String password) async {

    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return result.user;

  }

  // Logout
  Future<void> logout() async {

    await _auth.signOut();

  }

  // Reset Password
  Future<void> resetPassword(String email) async {

    await _auth.sendPasswordResetEmail(email: email);

  }

  // Current User
  User? get currentUser => _auth.currentUser;

}