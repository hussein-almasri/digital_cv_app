import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {

  final AuthService _authService = AuthService();

  User? user;

  bool loading = false;

  // Login
  Future<void> login(String email, String password) async {

    loading = true;
    notifyListeners();

    user = await _authService.login(email, password);

    loading = false;
    notifyListeners();
  }

  // Register
  Future<void> register(String email, String password) async {

    loading = true;
    notifyListeners();

    user = await _authService.register(email, password);

    loading = false;
    notifyListeners();
  }

  // Logout
  Future<void> logout() async {

    await _authService.logout();

    user = null;

    notifyListeners();
  }

  // Reset Password
  Future<void> resetPassword(String email) async {

    await _authService.resetPassword(email);

  }

}