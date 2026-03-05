import 'package:digital_cv_app/screens/templatess/templates_screen.dart';
import 'package:flutter/material.dart';

import 'home/home_screen.dart';
import 'builder/resume_builder_screen.dart';
import 'analytics/analytics_screen.dart';
import 'profile/profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {

  int currentIndex = 0;

  final screens = [

    const HomeScreen(),
    const TemplatesScreen(),
    const ResumeBuilderScreen(),
    const AnalyticsScreen(),
    const ProfileScreen(),

  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: currentIndex,

        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },

        type: BottomNavigationBarType.fixed,

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Templates",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.edit_document),
            label: "Builder",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: "Analytics",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),

        ],
      ),
    );
  }
}