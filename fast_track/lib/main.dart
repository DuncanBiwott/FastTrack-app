import 'package:fast_track/constants/constants.dart';
import 'package:fast_track/views/feeds_screen.dart';
import 'package:fast_track/views/home.dart';
import 'package:fast_track/views/profile_page.dart';
import 'package:fast_track/views/search.dart';
import 'package:fast_track/views/send_feedback.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(DashboardApp());
}

class DashboardApp extends StatelessWidget {
  @override
  Constants constants = Constants();
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      builder: (BuildContext context, Widget? child) {
        return Semantics(
          child: child!,
        );
      },
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: constants.p_button,
          elevation: 0,
        ),
        primaryColor: constants.p_button, 
        textTheme: TextTheme(
          headline6: TextStyle(
            color: constants.headline,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          bodyText2: TextStyle(
            color: constants.paragraph,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: constants.background,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: constants.s_button),
      ),
      home: DashboardScreen(),
    );
  }
}

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
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
          
            },
          ),
        ],
      ),
      
      body: _pages()[_selectedIndex],
      bottomNavigationBar: Container(
      
        child: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.blue,
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














