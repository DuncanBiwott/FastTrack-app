import 'package:fast_track/constants/constants.dart';
import 'package:fast_track/views/complaint_card.dart';
import 'package:fast_track/views/incidents_list.dart';
import 'package:fast_track/views/notification_icon.dart';
import 'package:fast_track/views/post_pages/main_post_screen.dart';
import 'package:flutter/material.dart';

class FeedsScreen extends StatefulWidget {
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
    _tabController = TabController(length: 3, vsync: this);

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
        elevation: 0,
        backgroundColor: Constants().p_button
        ,
        title:           Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Constants().p_button),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  NotificationIcon(),
                ],
              ),
            ),
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          controller: _tabController,
          indicatorColor: Colors.blue,
          tabs: const [
            Tab(text: 'Complaints'),
            Tab(
              text: 'Incidents',
              icon: Icon(Icons.verified, color: Colors.blue),
            ),
            Tab(text: 'My Reports'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ComplaintCard(),
          IncidentsList(),
          ComplaintCard(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle floating action button click
          // Navigate to the create feed page
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