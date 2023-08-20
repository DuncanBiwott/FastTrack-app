import 'package:fast_track/constants/constants.dart';
import 'package:fast_track/views/complaint_card.dart';
import 'package:fast_track/views/incidents_list.dart';
import 'package:fast_track/views/notification_icon.dart';
import 'package:fast_track/views/post_pages/main_post_screen.dart';
import 'package:fast_track/views/recommendation_card.dart';
import 'package:fast_track/views/search.dart';
import 'package:fast_track/views/user_reports.dart';
import 'package:flutter/material.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants().p_button,
        automaticallyImplyLeading: false,
        elevation: 0,
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
              icon: const Icon(Icons.search,color: Colors.white,),
            ),
            NotificationIcon(),
        ],
        bottom: TabBar(
          isScrollable: true,
          unselectedLabelColor: Colors.white,
          controller: _tabController,
          indicatorColor: Colors.blue,
          tabs: const [
            Tab(text: 'Complaints'),
            Tab(
              text: 'Incidents',
            ),
            Tab(text: 'My Reports'),
            Tab(text: 'Recommendations'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ComplaintCard(),
          IncidentsList(),
          UserReports(),
          RecommendationCard()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MainPostScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Constants().p_button,
      ),
    );
  }
}