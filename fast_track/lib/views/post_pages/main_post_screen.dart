import 'dart:async';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:fast_track/constants/constants.dart';
import 'package:fast_track/models/complaint.dart';
import 'package:fast_track/services/api/user_request_services/complaint_client.dart';
import 'package:fast_track/services/api/user_request_services/incident_client.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class MainPostScreen extends StatefulWidget {
  const MainPostScreen({super.key});

  @override
  _MainPostScreenState createState() => _MainPostScreenState();
}

class _MainPostScreenState extends State<MainPostScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController? _complaintController;
  TextEditingController? _complaintTitleController;
  TextEditingController? _incidentTitleController;
  TextEditingController? _incidentController;
  final _formKeyComplaint = GlobalKey<FormState>();
  final _formKeyIncident = GlobalKey<FormState>();
  final List<File> _images = [];
  TabController? _tabController;
  final ComplaintClient _complaintClient = ComplaintClient();
  final IncidentClient _incidentClient = IncidentClient();
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
  void initState() {
    
    super.initState();
    _complaintController = TextEditingController();
    _complaintTitleController = TextEditingController();
    _incidentTitleController = TextEditingController();
    _incidentController = TextEditingController();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _incidentController!.dispose();
    _incidentTitleController!.dispose();
    _complaintController!.dispose();
    _complaintTitleController!.dispose();
    super.dispose();
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _images.add(File(pickedImage.path));
      });
    }
  }

  //Geting the location

//   String? _currentAddress;
//   Position? _currentPosition;

//   Future<bool> _handleLocationPermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location services are disabled. Please enable the services')));
//       return false;
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Location permissions are denied')));
//         return false;
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location permissions are permanently denied, we cannot request permissions.')));
//       return false;
//     }
//     return true;
//   }

//   Future<void> _getCurrentPosition() async {
//     final hasPermission = await _handleLocationPermission();

//     if (!hasPermission) return;
//     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) {
//       setState(() => _currentPosition = position);
//       _getAddressFromLatLng(_currentPosition!);
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }

//   Future<void> _getAddressFromLatLng(Position position) async {
//   try {
//     List<Placemark> placemarks = await placemarkFromCoordinates(
//       _currentPosition!.latitude,
//       _currentPosition!.longitude,
//     );
//     if (placemarks !=null &&placemarks.isNotEmpty) {
//       Placemark place = placemarks[0];
//       setState(() {
//         _currentAddress =
//             '${place.street}';
//       });
//     }
//     print(_currentAddress);
//   } catch (e) {
//     debugPrint(e.toString());
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            TabBar(
              indicatorWeight: 1.0,
              controller: _tabController,
              unselectedLabelColor: Constants().headline,
              labelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Constants().tartiary, Colors.orangeAccent]),
                  borderRadius: BorderRadius.circular(50),
                  color: Constants().tartiary),
              tabs: const [
                Tab(text: 'Complaint'),
                Tab(text: 'Incident'),
              ],
            ),
            Expanded(
                child: TabBarView(
              controller: _tabController,
              children: [
                Form(
                  key: _formKeyComplaint,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_formKeyComplaint.currentState!
                                    .validate()) {
                                  setState(() {
                                    _isLoading =
                                        true; // set isLoading to true when submitting data
                                  });

                                  try {
                                    await _complaintClient.addComplaint(
                                        complaint: Complaint(
                                      title: _complaintTitleController!.text
                                          .trim(),
                                      category: 'HEALTH',
                                      description:
                                          _complaintController!.text.trim(),
                                      location: 'ELDORET',
                                      status: 'OPEN',
                                      submissionDateTime:
                                          DateTime.now().toIso8601String(),
                                    ));
                                    setState(() {
                                      _isLoading =
                                          false; // set isLoading to true when submitting data
                                    });

                                    _showSuccessMessage(
                                        'Complaint Posted Successfully',
                                        Colors.green);
                                  } catch (e) {
                                    setState(() {
                                      _isLoading =
                                          false; // set isLoading to true when submitting data
                                    });
                                    _showSuccessMessage(
                                        'Error Posting Complaint', Colors.red);
                                  }
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Constants().p_button,
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                              child: Text(
                                'SUBMIT',
                                style: TextStyle(
                                  color: Constants().p_button_text,
                                  fontSize: 16.0,
                                ),
                              )),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        autocorrect: true,
                        enableSuggestions: true,
                        controller: _complaintTitleController,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                        cursorColor: Colors.blue,
                        decoration: const InputDecoration(
                          hintText: "Title Complaint?",
                          border: InputBorder.none,
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter a title for your complaint'
                            : null,
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        autocorrect: true,
                        maxLines: 5,
                        enableSuggestions: true,
                        controller: _complaintController,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                        cursorColor: Colors.blue,
                        decoration: const InputDecoration(
                          hintText: "What's the Complaint?",
                          border: InputBorder.none,
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter your complaint'
                            : null,
                      ),
                      const SizedBox(height: 16.0),
                    
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Attach Image:',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                              icon: const Icon(
                                Icons.location_on,
                                size: 32.0,
                              ),
                              onPressed: (){}// => _getCurrentPosition()
                              ),
                          IconButton(
                            icon: const Icon(Icons.photo_camera),
                            onPressed: () => _pickImage(ImageSource.camera),
                          ),
                          IconButton(
                            icon: const Icon(Icons.photo_library),
                            onPressed: () => _pickImage(ImageSource.gallery),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _images.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 8.0),
                                  height: 200.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: FileImage(_images[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 8.0,
                                  right: 8.0,
                                  child: GestureDetector(
                                    onTap: () => _removeImage(index),
                                    child: Icon(
                                      Icons.cancel,
                                      color: Constants().tartiary,
                                      size: 32.0,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _formKeyIncident,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_formKeyIncident.currentState!.validate()) {
                                  setState(() {
                                    _isLoading =
                                        true; // set isLoading to true when submitting data
                                  });
                                  try {
                                    await _incidentClient.reportIncident(
                                        _incidentTitleController!.text.trim(),
                                        _incidentController!.text.trim(),
                                        DateTime.now(),
                                        "Mombasa",
                                        "CRITICAL",
                                        _images);
                                    _showSuccessMessage(
                                        'Incident Posted Successfully',
                                        Colors.green);
                                    setState(() {
                                      _isLoading =
                                          true; // set isLoading to true when submitting data
                                    });
                                  } catch (e) {
                                    setState(() {
                                      _isLoading =
                                          false; // set isLoading to true when submitting data
                                    });
                                    _showSuccessMessage(
                                        'Error Posting Incident', Colors.red);
                                  }
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Constants().p_button,
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                              child: Text(
                                'SUBMIT',
                                style: TextStyle(
                                  color: Constants().p_button_text,
                                  fontSize: 16.0,
                                ),
                              )),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        autocorrect: true,
                        enableSuggestions: true,
                        controller: _incidentTitleController,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                        cursorColor: Colors.blue,
                        decoration: const InputDecoration(
                          hintText: "Incident Title",
                          border: InputBorder.none,
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter a title for your incident'
                            : null,
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        autocorrect: true,
                        maxLines: 5,
                        enableSuggestions: true,
                        controller: _incidentController,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                        cursorColor: Colors.blue,
                        decoration: const InputDecoration(
                          hintText: "Report What's  happening in your area?",
                          border: InputBorder.none,
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter a description of the incident'
                            : null,
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Attach Image:',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                              icon: const Icon(
                                Icons.location_on,
                                size: 32.0,
                              ),
                              onPressed: () {}//=> _getCurrentPosition()
                              ),
                          IconButton(
                            icon: const Icon(Icons.photo_camera),
                            onPressed: () => _pickImage(ImageSource.camera),
                          ),
                          IconButton(
                            icon: const Icon(Icons.photo_library),
                            onPressed: () => _pickImage(ImageSource.gallery),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _images.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 8.0),
                                  height: 200.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: FileImage(_images[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 8.0,
                                  right: 8.0,
                                  child: GestureDetector(
                                    onTap: () => _removeImage(index),
                                    child: Icon(
                                      Icons.cancel,
                                      color: Constants().tartiary,
                                      size: 32.0,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
