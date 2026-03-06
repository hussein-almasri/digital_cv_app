import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../services/firestore_service.dart';
import '../../utils/app_colors.dart';
import '../../widgets/dashboard_card.dart';
import '../auth/login_screen.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthProvider>(context);
    final userId = auth.user?.uid ?? "";

    final firestore = FirestoreService();

    return Scaffold(

      body: SafeArea(

        child: StreamBuilder(

          stream: firestore.getUser(userId),

          builder: (context, snapshot){

            String name = "User";
            String? avatar;

            if(snapshot.hasData && snapshot.data!.exists){

              final data = snapshot.data!.data()
                  as Map<String,dynamic>?;

              name = data?["name"] ?? "User";
              avatar = data?["avatar"];

            }

            return Padding(

              padding: const EdgeInsets.all(20),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Row(

                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                    children: [

                      Row(

                        children: [

                          CircleAvatar(
                            radius: 26,
                            backgroundColor: Colors.grey.shade300,

                            backgroundImage: avatar != null
                                ? NetworkImage(avatar)
                                : null,

                            child: avatar == null
                                ? const Icon(
                                    Icons.person,
                                    size: 30,
                                    color: Colors.white,
                                  )
                                : null,
                          ),

                          const SizedBox(width: 12),

                          Column(

                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [

                              const Text(
                                "Welcome Back",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),

                              Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              )

                            ],
                          )

                        ],
                      ),

                      IconButton(

                        icon: const Icon(Icons.logout),

                        onPressed: () async {

                          await auth.logout();

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              const LoginScreen(),
                            ),
                            (route) => false,
                          );

                        },

                      )

                    ],
                  ),

                  const SizedBox(height: 30),

                  Card(

                    child: Padding(

                      padding: const EdgeInsets.all(20),

                      child: Row(

                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                        children: [

                          Column(

                            crossAxisAlignment:
                            CrossAxisAlignment.start,

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
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              )

                            ],
                          ),

                          CircularPercentIndicator(

                            radius: 40,
                            lineWidth: 8,
                            percent: 0.85,

                            progressColor:
                            AppColors.primary,

                            center:
                            const Text("85%"),

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
            );

          },

        ),

      ),
    );
  }
}