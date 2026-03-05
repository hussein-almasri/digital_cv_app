import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/gradient_button.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';
import '../main_navigation.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(

        child: Padding(

          padding: const EdgeInsets.all(24),

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 40),

              const Text(
                "Welcome Back 👋",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Login to your account",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 40),

              CustomTextField(
                hint: "Email",
                controller: emailController,
              ),

              const SizedBox(height: 16),

              CustomTextField(
                hint: "Password",
                obscure: true,
                controller: passwordController,
              ),

              const SizedBox(height: 16),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(

                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ForgotPasswordScreen(),
                      ),
                    );
                  },

                  child: const Text("Forgot Password?"),
                ),
              ),

              const SizedBox(height: 20),

              GradientButton(

                text: "Login",

                onPressed: () async {

                  final auth = Provider.of<AuthProvider>(context, listen: false);

                  await auth.login(
                    emailController.text,
                    passwordController.text,
                  );

                  if (auth.user != null) {

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MainNavigation(),
                      ),
                    );

                  }

                },
              ),

              const SizedBox(height: 30),

              Row(

                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  const Text("Don't have an account?"),

                  TextButton(

                    onPressed: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                      );
                    },

                    child: const Text("Register"),
                  )

                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}