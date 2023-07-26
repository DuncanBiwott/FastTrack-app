import 'package:fast_track/constants/constants.dart';
import 'package:fast_track/widgets/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget? child) {
        return Semantics(
          child: child!,
        );
      },
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Constants().p_button, 
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: Constants().headline,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            color: Constants().paragraph,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Constants().background,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: Constants().s_button),
      ),
      home: const SplashScreen (),
    );
  }
}
















