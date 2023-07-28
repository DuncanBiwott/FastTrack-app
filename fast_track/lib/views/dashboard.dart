import 'package:fast_track/constants/constants.dart';
import 'package:fast_track/views/chat_screen.dart';
import 'package:fast_track/views/home.dart';
import 'package:fast_track/views/post_pages/main_post_screen.dart';
import 'package:fast_track/views/profile_page.dart';
import 'package:fast_track/views/send_feedback.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'feeds_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  List<Widget> _pages() => <Widget>[
        HomeScreen(),
        FeedsScreen(),
        const ChatScreen(),
        FeedsScreen(),
        FeedbackPage(),
        const Profile(),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages()[_selectedIndex],
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
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
            selectedItemColor: Colors.black,
            showUnselectedLabels: false,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.house,
                  size: 16,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.rss,
                  size: 16,
                ),
                label: "Feed",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.comments,
                  size: 16,
                ),
                label: "Chatbot",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.clockRotateLeft,
                  size: 16,
                ),
                label: "History",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.comment,
                  size: 16,
                ),
                label: "Feedback",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.user,
                  size: 16,
                ),
                label: "Profile",
              ),
            ]),
      ),
    );
  }
}
