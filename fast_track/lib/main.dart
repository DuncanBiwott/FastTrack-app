import 'package:fast_track/constants/constants.dart';
import 'package:fast_track/views/dashboard.dart';
import 'package:fast_track/views/welcome_page.dart';
import 'package:fast_track/widgets/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Constants constants = Constants();
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      builder: (BuildContext context, Widget? child) {
        return Semantics(
          child: child!,
        );
      },
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          color: constants.p_button,
          elevation: 0,
        ),
        primaryColor: constants.p_button, 
        textTheme: TextTheme(
          headline6: TextStyle(
            color: constants.headline,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          bodyText2: TextStyle(
            color: constants.paragraph,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: constants.background,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: constants.s_button),
      ),
      home:const  SplashScreen(),
    );
  }
}
















