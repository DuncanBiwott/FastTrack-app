import 'package:fast_track/constants/constants.dart';
import 'package:fast_track/models/event_response.dart';
import 'package:fast_track/views/education_details.dart';
import 'package:fast_track/views/electricity_page.dart';
import 'package:fast_track/views/emergency.dart';
import 'package:fast_track/views/medical_care.dart';
import 'package:fast_track/views/notification_icon.dart';
import 'package:fast_track/views/post_pages/main_post_screen.dart';
import 'package:fast_track/views/search.dart';
import 'package:fast_track/views/security_details.dart';
import 'package:fast_track/views/transport.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/api/user_request_services/incident_client.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Future<List<EventResponse>>? eventsData;

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri(scheme: "https", host: url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    eventsData =
        IncidentClient().getAllEvents(perpage: 10, page: 1, context: context);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  shareFeedBack(String link, String description, String date) {
    final String text =
        "Title: $description \n Date: $date \n Check More Info Here: $link";
    Share.share(text);
  }

  Widget buildPage(Text message, String image, String date, String? link) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: message,
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(date)),
                  IconButton(
                      onPressed: () {
                        _launchURL(link!);
                      },
                      icon: const Icon(
                        FontAwesomeIcons.twitter,
                        color: Colors.white,
                      )),
                ],
              ),
            )
          ]),
    );
  }

  Widget buildDot(int pageIndex) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      width: pageIndex == _currentPage ? 10.0 : 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        color: pageIndex == _currentPage
            ? Constants().tartiary
            : Constants().paragraph,
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }

void _showOverlay(EventResponse event) {
  final overlay = Overlay.of(context);
  late OverlayEntry overlayEntry;
  DateTime parsedDate = DateTime.parse(event.eventDateTime!);
  String formattedDate =
      DateFormat('EEEE, d MMMM hh:mm a y').format(parsedDate);

  Widget overlayContent = Center(
    child: Container(
      width: 280,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    event.title!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    overlayEntry.remove();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                event.imageUrl!,
                fit: BoxFit.cover,
                height: 150,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                event.title!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                event.description!,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      formattedDate,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: IconButton(
                      icon: const Icon(
                        Icons.copy,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        shareFeedBack(
                            event.imageUrl!, event.description!, formattedDate);
                      },
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: IconButton(
                      icon: const Icon(
                        Icons.remove_red_eye,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        shareFeedBack(
                            event.imageUrl!, event.description!, formattedDate);
                      },
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: IconButton(
                      onPressed: () {
                        shareFeedBack(
                            event.imageUrl!, event.description!, formattedDate);
                      },
                      icon: const Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).size.height / 2 - 250,
      left: MediaQuery.of(context).size.width / 2 - 125,
      child: overlayContent,
    ),
  );

  overlay.insert(overlayEntry);
}



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
          NotificationIcon(),


        ]),
        
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/background.jpg",
                      ),
                      fit: BoxFit.cover,
                      opacity: 0.9),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    
                    Padding(
                      padding: EdgeInsets.only(top: 8.0, left: 32, right: 32),
                      child: Expanded(
                        child: Text(
                          'Instant digital access to over 50 government services, all in one place.',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: const BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text("--Frequently used --"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.car,
                                    size: 32,
                                    color: Color.fromARGB(255, 198, 123, 11),
                                  ),
                                  Text(
                                    "Transport",
                                    style: TextStyle(fontSize: 10),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.security,
                                    color: Color.fromARGB(255, 212, 21, 8),
                                  ),
                                  Text(
                                    "Security",
                                    style: TextStyle(fontSize: 10),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.health_and_safety,
                                    size: 32,
                                    color: Color.fromARGB(255, 65, 3, 76),
                                  ),
                                  Text(
                                    "Health",
                                    style: TextStyle(fontSize: 10),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.cast_for_education,
                                    size: 32,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    "Education",
                                    style: TextStyle(fontSize: 10),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const Text(
                'Trending on',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                height: 250,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              height: 200.0,
                              child: PageView(
                                controller: _pageController,
                                onPageChanged: (index) {
                                  setState(() {
                                    _currentPage = index;
                                  });
                                },
                                children: [
                                  buildPage(
                                      Text(
                                        "Government Announce Free Elecricity",
                                        style: TextStyle(
                                          color: Constants().background,
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      "assets/images/home.png",
                                      DateTime.now().toString(),
                                      "www.twitter.com/KPLC7News"),
                                  buildPage(
                                      Text(
                                        "Get important announcements On Health ",
                                        style: TextStyle(
                                          color: Constants().dot2_text,
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      "assets/images/home.png",
                                      DateTime.now().toString(),
                                      "www.twitter.com/UNICEFwater"),
                                  buildPage(
                                      Text(
                                        "Stay connected and informed about our services.",
                                        style: TextStyle(
                                          color: Constants().dot3_text,
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      "assets/images/home.png",
                                      DateTime.now().toString(),
                                      "www.twitter.com/MOH_Kenya/status/1681979885609205761"),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildDot(0),
                                buildDot(1),
                                buildDot(2),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Upcoming Events',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              FutureBuilder<List<EventResponse>>(
                future: IncidentClient()
                    .getAllEvents(perpage: 10, page: 1, context: context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    List<EventResponse> data = snapshot.data!;
                    return SizedBox(
                      height: 280,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          DateTime parsedDate =
                              DateTime.parse(data[index].eventDateTime!);
                          String formattedDate =
                              DateFormat('EEEE, d MMMM hh:mm a y')
                                  .format(parsedDate);
                          return Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: Image.network(
                                      data[index].imageUrl!,
                                      fit: BoxFit.cover,
                                      height: 140,
                                      width: double.infinity,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      data[index].title!,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            formattedDate,
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.blue),
                                          ),
                                          onPressed: () {
                                            _showOverlay(data[index]);
                                          },
                                          child: const Text(
                                            'View Details',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 8.0),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("All Services",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MedicalCareDetails()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 130,
                          width: 200,
                          decoration: const BoxDecoration(
                              color: Colors.white70,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.health_and_safety_outlined,
                                    size: 32,
                                    color: Colors.blue,
                                  ),
                                  Text("Medical Care",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  Text("Health Improvement")
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EducationDetails()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 130,
                          width: 200,
                          decoration: const BoxDecoration(
                              color: Colors.white70,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.cast_for_education,
                                    size: 32,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    "Education",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("Concerning school")
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecurityDetails()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 130,
                          width: 200,
                          decoration: const BoxDecoration(
                              color: Colors.white70,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.security,
                                    size: 32,
                                    color: Colors.blue,
                                  ),
                                  Text("Security",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  Text("Police Safety")
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TransPort()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 130,
                          width: 200,
                          decoration: const BoxDecoration(
                              color: Colors.white70,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.car_repair_outlined,
                                    size: 32,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    "Transport",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("Traffic Bus Car Complaint")
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EmergencyDetails()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 130,
                          width: 200,
                          decoration: const BoxDecoration(
                              color: Colors.white70,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.emergency,
                                    size: 32,
                                    color: Colors.blue,
                                  ),
                                  Text("Emergency",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  Text("Fire Accident Denger")
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ElectricityDetails()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 130,
                          width: 200,
                          decoration: const BoxDecoration(
                              color: Colors.white70,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.light_outlined,
                                    size: 32,
                                    color: Colors.blue,
                                  ),
                                  Text("Electricity",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  Text("Power problem")
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
            floatingActionButton: FloatingActionButton(
        backgroundColor: Constants().p_button,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MainPostScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      ),
    );
  }
}
