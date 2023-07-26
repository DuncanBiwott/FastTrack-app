import 'package:another_flushbar/flushbar.dart';
import 'package:fast_track/constants/constants.dart';
import 'package:fast_track/models/feedback.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../services/api/user_request_services/complaint_client.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _feedbackController = TextEditingController();

final _formKey = GlobalKey<FormState>();
  String type= 'GENERAL_FEEDBACK';

  var items = ['GENERAL_FEEDBACK',  'BUG_REPORT', 'FEATURE_REQUEST'];


  final ComplaintClient _complaintClient = ComplaintClient();
  bool _isLoading = false;

  Future _showSuccessMessage(String massage, Color color) {
    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: color,
      message: massage,
      duration: const Duration(seconds: 3),
    ).show(context);
  }

 

   void shareFeedBack() {
    final String text = _feedbackController.text;  
    Share.share(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Please provide your feedback',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Feedback Type",
                    style: TextStyle(color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:20.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        elevation: 0,
                        value: type,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: items.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            type = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
                TextFormField(
                  controller: _feedbackController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Enter your feedback',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
               
                const SizedBox(height: 32.0),
                const Text(
                  'Contact Support:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                const Text('Phone: +254 707686954'),
                const Text('Email: danbiwott77@gmail.com'),
                const SizedBox(height: 16.0),
                
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          shareFeedBack();
                          
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Constants().s_button, 
                        ),
                        child: Text(
                          'Email Support',
                          style: TextStyle(color: Constants().s_button_text),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                                      onPressed: () {
                      shareFeedBack();
                      
                                      },
                                      style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Constants().s_button, 
                                      ),
                                      child: Text(
                      'Call Support',
                      style: TextStyle(color: Constants().s_button_text),
                                      ),
                                    ),
                    ),
                  ],
                ),
                Center(
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : Container(),
                ),
                const SizedBox(height: 32.0),
                 Center(
                   child: Container(
                    height: 50,
                    width:MediaQuery.of(context).size.width*0.8,
                     child: ElevatedButton(
                      onPressed: () async {
                                    if (_formKey.currentState!
                                        .validate()) {
                                      setState(() {
                                        _isLoading =
                                            true; 
                                      });
                                    
                                      try {
                                        await _complaintClient.sendFeedBack(
                                          context: context,
                                            feedbackRequest: FeedbackRequest(
                                              feedbackType: type,
                                              description: _feedbackController.text.trim(),
                                              status: 'OPEN',
                                          
                                          submissionDateTime:
                                              DateTime.now().toIso8601String(),
                                        ));
                                        setState(() {
                                          _isLoading =
                                              false; 
                                        });
                                    
                                        _showSuccessMessage(
                                            'FeedBack Submitted Successfully',
                                            Colors.green);
                                      } catch (e) {
                                        setState(() {
                                          _isLoading =
                                              false; // set isLoading to true when submitting data
                                        });
                                        _showSuccessMessage(
                                            'Error in Submitting FeedBack', Colors.red);
                                      }
                                    }
                                  },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).primaryColor, 
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Constants().p_button_text,fontSize: 24,fontWeight: FontWeight.bold),
                      ),
                                   ),
                   ),
                 ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}