import 'dart:async';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:fast_track/constants/constants.dart';
import 'package:fast_track/models/complaint.dart';
import 'package:fast_track/services/api/user_request_services/complaint_client.dart';
import 'package:fast_track/services/api/user_request_services/incident_client.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../provider/notification_provider.dart';

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
  TextEditingController? _locationController;
  final _formKeyComplaint = GlobalKey<FormState>();
  final _formKeyIncident = GlobalKey<FormState>();
  final _formKeyrecommend = GlobalKey<FormState>();
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

  String category = 'HEALTH';

  var categories = ['HEALTH', 'TRANSPORT', 'EDUCATION', 'OTHER'];
  String incident = 'CRITICAL';

  var status = ['CRITICAL', 'DANGER'];

  @override
  void initState() {
    super.initState();
    _complaintController = TextEditingController();
    _complaintTitleController = TextEditingController();
    _incidentTitleController = TextEditingController();
    _incidentController = TextEditingController();
    _locationController = TextEditingController();
    _tabController = TabController(length: 3, vsync: this);
    _handleLocationPermission();
    _getCurrentPosition();
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

  Position? _currentPosition;
  String? _location;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await Geolocator.openLocationSettings();
      if (!serviceEnabled) {
        return false;
      }
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  Future<String?> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return null;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(
        () => _currentPosition = position,
      );

      String currentLocation = await _complaintClient.getLocation(
          latitude: _currentPosition!.latitude,
          longitude: _currentPosition!.longitude);
      setState(() {
        _location = currentLocation;
      });
    }).catchError((e) {
      return e;
    });
    return _location ?? "Loading ...";
  }

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
              isScrollable: true,
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
                Tab(text: 'Recommendation'),
              ],
            ),
            Expanded(
                child: TabBarView(
              controller: _tabController,
              children: [
                Form(
                  key: _formKeyComplaint,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                "Category:",
                                style: TextStyle(color: Colors.black),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  elevation: 0,
                                  value: category,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: categories.map((String item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      category = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          controller: _locationController,
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(
                            hintText:
                                "Enter your location here near $_location",
                            label: Row(
                              children: [
                                const Icon(Icons.location_on),
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black),
                                    children: [
                                      const TextSpan(
                                          text: 'Your Location near '),
                                      TextSpan(
                                        text: '($_location)',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          validator: (value) => value!.isEmpty
                              ? 'Please enter your specific location here!'
                              : null,
                        ),
                        TextFormField(
                          autocorrect: true,
                          enableSuggestions: true,
                          controller: _complaintTitleController,
                          cursorColor: Colors.blue,
                          decoration: const InputDecoration(
                            hintText: "Title Complaint?",
                          ),
                          validator: (value) => value!.isEmpty
                              ? 'Please enter a title for your complaint'
                              : null,
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _complaintController,
                          maxLines: 5,
                          cursorColor: Colors.blue,
                          decoration: const InputDecoration(
                            hintText: "What's the Complaint?",
                          ),
                          validator: (value) => value!.isEmpty
                              ? 'Please enter your complaint'
                              : null,
                        ),
                        _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : const SizedBox(height: 8.0),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Center(
                          child: Container(
                            height: 50.0,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Expanded(
                              child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKeyComplaint.currentState!
                                        .validate()) {
                                      setState(() {
                                        _isLoading = true;
                                      });

                                      try {
                                        await _complaintClient.addComplaint(
                                            context: context,
                                            complaint: Complaint(
                                              title: _complaintTitleController!
                                                  .text
                                                  .trim(),
                                              category: category,
                                              description: _complaintController!
                                                  .text
                                                  .trim(),
                                              location:
                                                  "${_locationController!.text.trim()}($_location) ",
                                              status: 'OPEN',
                                              submissionDateTime: DateTime.now()
                                                  .toIso8601String(),
                                            ));
                                        setState(() {
                                          _isLoading = false;
                                        });

                                        _showSuccessMessage(
                                            'Complaint Posted Successfully',
                                            Colors.green);
                                        final notificationProvider =
                                            Provider.of<NotificationProvider>(
                                                context,
                                                listen: false);
                                        notificationProvider.addNotification(
                                            'Complaint Posted Successfully');
                                      } catch (e) {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        _showSuccessMessage(
                                            'Error Posting Complaint',
                                            Colors.red);
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
                                        borderRadius:
                                            BorderRadius.circular(30.0),
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
                        )
                      ],
                    ),
                  ),
                ),
                Form(
                  key: _formKeyIncident,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "STATUS:",
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton(
                                elevation: 0,
                                value: incident,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: status.map((String item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    incident = newValue!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextFormField(
                        controller: _locationController,
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          hintText: "Enter your location here near $_location",
                          label: Row(
                            children: [
                              const Icon(Icons.location_on),
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black),
                                  children: [
                                    const TextSpan(text: 'Your Location near '),
                                    TextSpan(
                                      text: '($_location)',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter your specific location here!'
                            : null,
                      ),
                      TextFormField(
                        controller: _incidentTitleController,
                        cursorColor: Colors.blue,
                        decoration: const InputDecoration(
                          hintText: "Title",
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
                        cursorColor: Colors.blue,
                        decoration: const InputDecoration(
                          hintText: "Report What's  happening in your area?",
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
                              onPressed: () {}
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
                      _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const SizedBox(height: 8.0),
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
                                    child: const Icon(
                                      Icons.cancel,
                                      color: Colors.black,
                                      size: 32.0,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 50.0,
                          width: MediaQuery.of(context).size.width * 0.5,
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
                                        "${_locationController!.text.trim()}($_location)",
                                        incident,
                                        _images,
                                        context);
                                    _showSuccessMessage(
                                        'Incident Posted Successfully',
                                        Colors.green);
                                        final notificationProvider =
                                            Provider.of<NotificationProvider>(
                                                context,
                                                listen: false);
                                        notificationProvider.addNotification(
                                            'Incident Posted Successfully');
                                    setState(() {
                                      _isLoading =
                                          false; 
                                    });
                                  } catch (e) {
                                    setState(() {
                                      _isLoading =
                                          false; 
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
                    ],
                  ),
                ),
                Form(
                  key: _formKeyrecommend,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "CATEGORY:",
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton(
                                elevation: 0,
                                value: incident,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: status.map((String item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    incident = newValue!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextFormField(
                        controller: _locationController,
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          hintText: "Enter your location here near $_location",
                          label: Row(
                            children: [
                              const Icon(Icons.location_on),
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black),
                                  children: [
                                    const TextSpan(text: 'Your Location near '),
                                    TextSpan(
                                      text: '($_location)',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter your specific location here!'
                            : null,
                      ),
                      TextFormField(
                        controller: _incidentTitleController,
                        cursorColor: Colors.blue,
                        decoration: const InputDecoration(
                          hintText: "Title",
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter a title for your Recommendation'
                            : null,
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        autocorrect: true,
                        maxLines: 5,
                        enableSuggestions: true,
                        controller: _incidentController,
                        cursorColor: Colors.blue,
                        decoration: const InputDecoration(
                          hintText: "Recommend on offered services",
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter a description of the recommendation'
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
                              onPressed: () {} //=> _getCurrentPosition()
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
                      _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const SizedBox(height: 8.0),
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
                                    child: const Icon(
                                      Icons.cancel,
                                      color: Colors.black,
                                      size: 32.0,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 50.0,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_formKeyrecommend.currentState!
                                    .validate()) {
                                  setState(() {
                                    _isLoading =
                                        true; // set isLoading to true when submitting data
                                  });
                                  try {
                                    await _incidentClient.makeRecommendation(
                                        _incidentTitleController!.text.trim(),
                                        _incidentController!.text.trim(),
                                        DateTime.now(),
                                        "${_locationController!.text.trim()}($_location)",
                                        "HEALTH",
                                        _images,
                                        context);
                                    _showSuccessMessage(
                                        'Recommendation Successfully Submitted',
                                        Colors.green);
                                        final notificationProvider =
                                            Provider.of<NotificationProvider>(
                                                context,
                                                listen: false);
                                        notificationProvider.addNotification('Recommendation Successfully Submitted');
                                    setState(() {
                                      _isLoading =
                                          false; // set isLoading to true when submitting data
                                    });
                                  } catch (e) {
                                    setState(() {
                                      _isLoading =
                                          false; // set isLoading to true when submitting data
                                    });
                                    _showSuccessMessage(
                                        'Error Posting recommendation',
                                        Colors.red);
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
