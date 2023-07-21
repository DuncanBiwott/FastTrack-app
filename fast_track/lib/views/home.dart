import 'package:fast_track/constants/constants.dart';
import 'package:fast_track/models/event_response.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/api/user_request_services/incident_client.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
Future<List<EventResponse>>? eventsData;

  @override
  void initState() {
    super.initState();
    eventsData=IncidentClient().getAllEvents(perpage: 10,page: 1, context: context);

  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

   
  Widget buildPage(Text message, String image) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: NetworkImage(image),
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
            ))
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
    String formattedDate = DateFormat('EEEE, d MMMM hh:mm a y').format(parsedDate);

    Widget overlayContent = Container(
      alignment: Alignment.center,
      height: 500,
      width: 500,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: 250,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      onPressed: () {
                        overlayEntry.remove(); // Remove the overlay when the button is pressed
                      },
                      child: const Text(
                        'Close',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 100, 
        left: 50,
        child: overlayContent,
      ),
    );

    overlay.insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white70,
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search...",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Latest News',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
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
                                          "Stay updated on our services with news and events. Discover features, offers, and enhancements for an enhanced experience",
                                          style: TextStyle(
                                            color: Constants().background,
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        "https://img.freepik.com/free-vector/abstract-classic-blue-screensaver_23-2148421853.jpg?size=626&ext=jpg",),
                                    buildPage(
                                        Text(
                                          "Get important announcements and stay informed about our services. Unlock the full potential with upcoming events and updates.",
                                          style: TextStyle(
                                            color: Constants().dot2_text,
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        "https://img.freepik.com/free-vector/realistic-neon-lights-background_23-2148907367.jpg?size=626&ext=jpg"),
                                    buildPage(
                                        Text(
                                          "Stay connected and informed about our services. Industry insights, expert tips, events, and partnerships to keep you ahead",
                                          style: TextStyle(
                                            color: Constants().dot3_text,
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        "https://img.freepik.com/free-vector/halftone-background-with-circles_23-2148907689.jpg?size=626&ext=jpg"),
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
                const SizedBox(height: 16.0),
                const Text(
                  'Upcoming Events',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                FutureBuilder<List<EventResponse>>(
  future: IncidentClient().getAllEvents(perpage: 10, page: 1, context: context),
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
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          itemBuilder: (context, index) {
            DateTime parsedDate = DateTime.parse(data[index].eventDateTime!);
             String formattedDate = DateFormat('EEEE, d MMMM hh:mm a y').format(parsedDate);
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: 250,
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
                        height: 150,
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
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.blue),
                            ),
                            onPressed: () {
                              _showOverlay(data[index]);
                            },
                            child: const Text(
                              'View Details',
                              style: TextStyle(color: Colors.white),
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

                const SizedBox(height: 16.0),
              ],
            ),
          ),
        )

    );
      
  }
}