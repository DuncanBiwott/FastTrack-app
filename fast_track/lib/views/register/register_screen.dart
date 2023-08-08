import 'package:another_flushbar/flushbar.dart';
import 'package:fast_track/constants/constants.dart';
import 'package:fast_track/views/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/register_request.dart';
import '../../services/api/authenticationService/registerService/register_client.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final RegisterDioClient registerDioClient = RegisterDioClient();
  final _formKey = GlobalKey<FormState>();
  final _fName = TextEditingController();
  final _lName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _cPassword = TextEditingController();

  bool _isLoading = false;
  bool _obscureText = true;

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
    _fName.dispose();
    _lName.dispose();
    _email.dispose();
    _password.dispose();
    _cPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants().welcomeBg,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
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
                          height: 20,
                        ),
                        TextFormField(
                          controller: _fName,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            label: Text(
                              "First Name*"
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _lName,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            label: Text(
                              "Last Name*"
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        
                        TextFormField(
                          controller: _email,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            label: Text(
                              "Email Address*"
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
                          controller: _password,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            label: const Text("Password*"),
                            hintText: "Password",
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
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
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
                          height: 8,
                        ),
                        TextFormField(
                          controller: _cPassword,
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
                            label: const Text("Confirm Password*"),
                            hintText: "Confirm Password",
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                          ),
                          obscureText: _obscureText,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please confirm your password';
                            } else if (value != _password.text) {
                              return 'Passwords do not match';
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
                                ):ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, create a UserRequest object with the entered values
                                final userDetails = UserRequest(
                                    firstName: _fName.text.trim(),
                                    email: _email.text.trim(),
                                    lastName: _lName.text.trim(),
                                    password: _password.text);
                      
                                setState(() {
                                  _isLoading =
                                      true; // set isLoading to true when submitting data
                                });
                                try {
                                  // Call the register function with the UserRequest object
                                  await registerDioClient.register(
                                      userDetails: userDetails);
                                  _showSuccessMessage(
                                          "Account Created Successfully",
                                          Constants().green)
                                      .then((value) {
                                    // Navigate to the home screen after the flushbar is dismissed
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                             const Login()),
                                    );
                                  });
                      
                                  _formKey.currentState!.reset();
                                  _fName.clear();
                                  _lName.clear();
                                  _email.clear();
                                  _password.clear();
                                  _cPassword.clear();
                                   setState(() {
                                  _isLoading =
                                      false; // set isLoading to true when submitting data
                                });
                                } catch (e) {
                                  print(e);
                                  _showSuccessMessage(
                                      e.toString(),
                                      Colors.red);
                      
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
                            child:Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "REGISTER",
                                          style: TextStyle(
                                              color: Constants().p_button_text, letterSpacing: 0.5),
                                        ),
                                      ],
                                    ),
                                  )),
                        const SizedBox(
                          height: 8,
                        ),
                       
                           Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text("Already have an account?"),
                              TextButton(
                                  onPressed: (() {
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                                        builder: (context) => Login()));
                                  }),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Constants().s_button_text, letterSpacing: 0.5),
                                  )),
                            ],
                          ),
                     
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
