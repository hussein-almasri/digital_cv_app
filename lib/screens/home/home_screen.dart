import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../utils/app_colors.dart';
import '../../widgets/dashboard_card.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(

        child: Padding(

          padding: const EdgeInsets.all(20),

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Row(

                children: [

                  const CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage(
                      "https://i.pravatar.cc/300",
                    ),
                  ),

                  const SizedBox(width: 12),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [

                      Text(
                        "Welcome Back",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      Text(
                        "John Doe",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )

                    ],
                  )

                ],
              ),

              const SizedBox(height: 30),

              Card(

                child: Padding(

                  padding: const EdgeInsets.all(20),

                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [

                      Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: const [

                          Text(
                            "Resume Score",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),

                          SizedBox(height: 8),

                          Text(
                            "85 / 100",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          )

                        ],
                      ),

                      CircularPercentIndicator(

                        radius: 40,
                        lineWidth: 8,
                        percent: 0.85,

                        progressColor: AppColors.primary,

                        center: const Text("85%"),

                      )

                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(

                child: GridView.count(

                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,

                  children: const [

                    DashboardCard(
                      icon: Icons.add,
                      title: "Create Resume",
                    ),

                    DashboardCard(
                      icon: Icons.analytics,
                      title: "Analyze Resume",
                    ),

                    DashboardCard(
                      icon: Icons.edit,
                      title: "Edit Resume",
                    ),

                    DashboardCard(
                      icon: Icons.dashboard,
                      title: "Templates",
                    ),

                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}