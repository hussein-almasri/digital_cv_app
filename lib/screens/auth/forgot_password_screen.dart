import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/gradient_button.dart';

class ForgotPasswordScreen extends StatefulWidget {

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: const Text("Reset Password")),

      body: Padding(

        padding: const EdgeInsets.all(24),

        child: Column(

          children: [

            CustomTextField(
              hint: "Email",
              controller: emailController,
            ),

            const SizedBox(height: 20),

            GradientButton(

              text: "Send Reset Link",

              onPressed: () async {

                final auth = Provider.of<AuthProvider>(context, listen: false);

                await auth.resetPassword(emailController.text);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Reset email sent")),
                );

              },
            ),

          ],
        ),
      ),
    );
  }
}