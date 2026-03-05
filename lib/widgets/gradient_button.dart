import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class GradientButton extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: onPressed,

      child: Container(

        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),

        decoration: BoxDecoration(

          gradient: const LinearGradient(
            colors: [
              AppColors.primary,
              Color(0xFF1D4ED8),
            ],
          ),

          borderRadius: BorderRadius.circular(14),

          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            )
          ],
        ),

        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}