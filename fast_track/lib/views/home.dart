import 'package:fast_track/constants/constants.dart';
import 'package:fast_track/views/chat_screen.dart';
import 'package:flutter/material.dart';

import 'event_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget buildPage(Text message, Color color) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                        Constants().dot1),
                                    buildPage(
                                        Text(
                                          "Get important announcements and stay informed about our services. Unlock the full potential with upcoming events and updates.",
                                          style: TextStyle(
                                            color: Constants().dot2_text,
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Constants().dot2),
                                    buildPage(
                                        Text(
                                          "Stay connected and informed about our services. Industry insights, expert tips, events, and partnerships to keep you ahead",
                                          style: TextStyle(
                                            color: Constants().dot3_text,
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Constants().dot3),
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
                Container(
                  height: 120.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      EventCard(
                        title: 'Event 1',
                        date: 'May 30, 2023',
                      ),
                      EventCard(
                        title: 'Event 2',
                        date: 'June 5, 2023',
                      ),
                      EventCard(
                        title: 'Event 3',
                        date: 'June 10, 2023',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ChatScreen()),
            );
          },
          backgroundColor: Theme.of(context).primaryColor,
          label: Text(
            'Chat',
            style: TextStyle(color: Constants().p_button_text),
          ),
          icon: Icon(
            Icons.send,
            color: Constants().p_button_text,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat);
  }
}