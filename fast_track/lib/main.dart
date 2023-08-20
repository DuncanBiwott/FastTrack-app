import 'package:fast_track/constants/constants.dart';
import 'package:fast_track/provider/notification_provider.dart';
import 'package:fast_track/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotificationProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (BuildContext context, Widget? child) {
          return Semantics(
            child: child!,
          );
        },
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: Constants().p_button, 
          textTheme: GoogleFonts.robotoCondensedTextTheme(),
        ),
        home: const SplashScreen (),
      ),
    );
  }
}
















