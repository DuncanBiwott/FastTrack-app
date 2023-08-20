import 'package:fast_track/views/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/welcome_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();

  
}

class _SplashScreenState extends State<SplashScreen> {
  
  
  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) => {
      checkToken(context)
    });
  }
void checkToken(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('fast_token');
     // Token exists, navigate to Dashboard

    if (token != null && token.isNotEmpty) {
     
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => DashboardScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => WelcomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
        backgroundColor: Colors.white,
        body:Center(
          child: Icon(FontAwesomeIcons.spinner,size: 40,color: Colors.grey,)
          ),
          
          );
    
    
  }
}
