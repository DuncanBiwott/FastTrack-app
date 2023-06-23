import 'dart:io';

import 'package:fast_track/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MainPostScreen extends StatefulWidget {
  @override
  _MainPostScreenState createState() => _MainPostScreenState();
}

class _MainPostScreenState extends State<MainPostScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController? _tweetController;
  final List<File> _images = [];
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tweetController = TextEditingController();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tweetController!.dispose();
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
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
                    TextField(
                      autocorrect: true,
                      maxLines: 10,
                      enableSuggestions: true,
                      controller: _tweetController,
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                      cursorColor: Colors.blue,
                      decoration: const InputDecoration(
                        hintText: "What's the Complaint?",
                        border: InputBorder.none,
                      ),
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
                          icon: Icon(Icons.photo_camera),
                          onPressed: () => _pickImage(ImageSource.camera),
                        ),
                        IconButton(
                          icon: Icon(Icons.photo_library),
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
                                margin: EdgeInsets.only(top: 8.0),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
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
                    TextField(
                      autocorrect: true,
                      maxLines: 10,
                      enableSuggestions: true,
                      controller: _tweetController,
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                      cursorColor: Colors.blue,
                      decoration: const InputDecoration(
                        hintText: "Rport What's  happening?",
                        border: InputBorder.none,
                      ),
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
              ],
            )),
          ],
        ),
      ),
    );
  }
}
