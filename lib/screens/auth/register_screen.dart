import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/gradient_button.dart';

class RegisterScreen extends StatefulWidget {

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(),

      body: Padding(

        padding: const EdgeInsets.all(24),

        child: Column(

          children: [

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

            const SizedBox(height: 30),

            GradientButton(

              text: "Register",

              onPressed: () async {

                final auth = Provider.of<AuthProvider>(context, listen: false);

                await auth.register(
                  emailController.text,
                  passwordController.text,
                );

                Navigator.pop(context);

              },
            ),

          ],
        ),
      ),
    );
  }
}