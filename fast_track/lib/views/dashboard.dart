import 'package:fast_track/constants/constants.dart';
import 'package:fast_track/views/chat_screen.dart';
import 'package:fast_track/views/home.dart';
import 'package:fast_track/views/post_pages/main_post_screen.dart';
import 'package:fast_track/views/profile_page.dart';
import 'package:fast_track/views/search.dart';
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
    FeedsScreen(),
    const ChatScreen(),
    FeedsScreen(),
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
      appBar: AppBar(
         automaticallyImplyLeading: false,
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
                icon: Icon(FontAwesomeIcons.house,size: 16,),
                label: "Home",
              ),
              
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.rss,size: 16,
                ),
                label: "Feed",
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.comments,size: 16,
                ),
                label: "Chatbot",
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.clockRotateLeft,size: 16,
                ),
                label: "History",
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.user,size: 16,
                ),
                label: "Profile",
              ),
            ]),
      ),
    );
  }

 
}