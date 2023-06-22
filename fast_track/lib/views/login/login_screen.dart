import 'package:another_flushbar/flushbar.dart';
import 'package:fast_track/constants/constants.dart';
import 'package:fast_track/views/dashboard.dart';
import 'package:fast_track/views/login/forgot_password.dart';
import 'package:fast_track/views/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/request_token.dart';
import '../../services/api/authenticationService/loginService/login_dio_client.dart';

class Login extends StatefulWidget {
  const Login({
    Key? key,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final LoginDioClient loginDioClient = LoginDioClient();

  bool _obscureText = true;
  bool _isLoading = false;

  Future _showSuccessMessage(String massage, Color color) {
    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: color,
      message: massage,
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  @override
  void dispose() {
    _email.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              height: 500,
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          FontAwesomeIcons.circleChevronUp,
                          size: 60,
                          color: Constants().tartiary,
                        ),
                      
                       const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _email,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            label: Text(
                              "Email Address*",
                            
                            ),
                            hintText: "Enter Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter an email address';
                            } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _passwordcontroller,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            label: Text("Password"),
                            hintText: "Password",
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                          ),
                          obscureText: _obscureText,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                       _isLoading? Center(
                                  child: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: CircularProgressIndicator(
                                        color: Constants().p_button,
                                      ),
                                    ),
                                ): ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, create a UserRequest object with the entered values
                                final userDetails = LoginRequest(
                                    password: _passwordcontroller.text,
                                    username: _email.text.trim());
                                setState(() {
                                  _isLoading =
                                      true; // set isLoading to true when submitting data
                                });
                                try {
                                  // Call the login function with the UserRequest object
                                  await loginDioClient.login(
                                      userDetails: userDetails);

                                  _formKey.currentState!.reset();
                                  _passwordcontroller.clear();
                                  _email.clear();
                                  setState(() {
                                    _isLoading =
                                        false; // set isLoading to true when submitting data
                                  });

                                  _showSuccessMessage(
                                          "Login Successfull", Colors.green)
                                      .then((value) {
                                    // Navigate to the home screen after the flushbar is dismissed
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DashboardScreen(),
                                      ),
                                    );
                                  });
                                  //_showSuccessMessage("Success",
                                  //  "Login Successfully", Colors.green);
                                } catch (e) {
                                  _showSuccessMessage(
                                      "Could Not Login", Colors.red);

                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                 Constants().p_button),
                            ),
                            child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "LOGIN",
                                          style: TextStyle(color: Constants().p_button_text),
                                        ),
                                      
                                      ],
                                    ),
                                  )),
                        const SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: TextButton(
                              onPressed: (() {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordPage()));
                              }),
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(color: Constants().s_button_text),
                              )),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                                onPressed: (() {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SignUp()));
                                }),
                                child: Text(
                                  "Register",
                                  style: TextStyle(color: Constants().s_button_text,decoration: TextDecoration.underline,letterSpacing: 0.5),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
