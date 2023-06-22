

import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:fast_track/constants/constants.dart';
import 'package:fast_track/services/api/authenticationService/registerService/register_client.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final RegisterDioClient registerDioClient = RegisterDioClient();
  final _formKey = GlobalKey<FormState>();
  final _code = TextEditingController();
  bool _isLoading = false;

  Future _showSuccessMessage(String massage, Color color) {
    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: color,
      message: massage,
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  int _countdown = 180;
  dynamic _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_countdown < 1) {
            timer.cancel();
          } else {
            _countdown = _countdown - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _code.dispose();
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
      
          height: 400,
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              FontAwesomeIcons.angleLeft,
                              color: Constants().s_button,
                              size: 24,
                            ),
                            Text(
                              "Back",
                              style: TextStyle(
                                  color:Constants().s_button_text,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Center(
                          child: Text(
                        "Confirm Your Account with Code",
                        style: TextStyle(color: Constants().headline, fontSize: 50),
                      )),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Time remaining: $_countdown seconds",
                        style: TextStyle(letterSpacing: 0.5),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _code,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          label: Text(
                            "Code:",
                            style: TextStyle(color: Constants().s_button_text),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter the Code';
                          } else if (!RegExp(r'^[1-9]\d*(\.\d+)?$')
                              .hasMatch(value)) {
                            return 'Please enter a valid code';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
