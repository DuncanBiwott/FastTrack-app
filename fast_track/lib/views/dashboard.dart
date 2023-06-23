import 'package:fast_track/constants/constants.dart';
import 'package:fast_track/views/home.dart';
import 'package:fast_track/views/post_pages/main_post_screen.dart';
import 'package:fast_track/views/profile_page.dart';
import 'package:fast_track/views/search.dart';
import 'package:fast_track/views/send_feedback.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/api/authenticationService/loginService/login_dio_client.dart';
import 'feeds_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

    int _selectedIndex = 0;

  List<Widget> _pages ()=><Widget> [
    HomeScreen(),
    FeedbackPage(),
    FeedsScreen(),
    const ProfileManagementPage(),
   
    
    
  ];

  void _onItemTapped(int index) {
    
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         automaticallyImplyLeading: false,
        title: const Row(
          children: [
            CircleAvatar(
              radius: 16.0,
              backgroundImage: NetworkImage(
                  'https://static.vecteezy.com/system/resources/previews/005/544/718/original/profile-icon-design-free-vector.jpg'),
            ),
            SizedBox(width: 8.0),
            Text('Dan'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(),
                ),
              );
            },
          ),
         const  SizedBox(width: 8.0),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
          
            },
          ),
          const  SizedBox(width: 8.0),
    PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem(
            value: 'logout',
            child: Icon(Icons.logout),
          ),
        ];
      },
      onSelected: (value) {
        if (value == 'logout') {
           LoginDioClient().logout(context);
         
          
        }
      },
    ),
  
        ],
      ),
      
      body: _pages()[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants().p_button,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainPostScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Container(
      
        child: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            selectedItemColor: Colors.black,
            unselectedItemColor: Constants().p_button,
            showUnselectedLabels: true,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.house),
                label: "Dashboard",
              ),
              
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.rss
                ),
                label: "Feedback",
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.commentDots
                ),
                label: "Feeds",
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.user
                ),
                label: "Profile",
              ),
            ]),
      ),
    );
  }

 
}