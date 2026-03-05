import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class DashboardCard extends StatelessWidget {

  final IconData icon;
  final String title;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      child: InkWell(

        borderRadius: BorderRadius.circular(16),

        onTap: () {},

        child: Padding(

          padding: const EdgeInsets.all(20),

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Icon(
                icon,
                size: 36,
                color: AppColors.primary,
              ),

              const SizedBox(height: 12),

              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}