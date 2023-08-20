import 'package:fast_track/constants/constants.dart';
import 'package:fast_track/views/login/login_screen.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants().welcomeBg,
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.explore,
              size: 80,
            ),
            const SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'FASTTRACK ',
                style: TextStyle(
                  color: Constants().welcomeText,
                  fontSize: 24,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'APP',
                    style: TextStyle(
                      color: Constants().green,
                      fontSize: 24,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Empowering residents to report incidents, complaints, and suggestions. Interact with FAQs and stay updated on local events.",
              textAlign: TextAlign.center,
              style: TextStyle(
                letterSpacing: 0.5,
                color: Constants().welcomeText,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 100),
            SizedBox(
              height: 50.0,
              width: 300.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const Login()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Constants().p_button),
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    color: Constants().p_button_text,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
