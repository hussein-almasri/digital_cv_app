import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'utils/app_theme.dart';
import 'providers/auth_provider.dart';
import 'providers/resume_provider.dart';
import 'screens/auth/login_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(

      providers: [

        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => ResumeProvider(),
        ),

      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Smart Digital CV',
        theme: AppTheme.lightTheme,
        home: LoginScreen(),
      ),
    );
  }
}