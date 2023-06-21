import 'package:fast_track/constants/constants.dart';
import 'package:fast_track/models/feed.dart';
import 'package:fast_track/views/create_feed.dart';
import 'package:fast_track/views/feedstab_view.dart';
import 'package:flutter/material.dart';

class FeedsScreen extends StatefulWidget {
  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blue,
          tabs: const [
            Tab(text: 'Public'),
            Tab(
              text: 'Official',
              icon: Icon(Icons.verified, color: Colors.blue),
            ),
            Tab(text: 'My Reports'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FeedsTabView(
            feeds: [
              FeedModel(
                avatarUrl:
                    'https://i.pinimg.com/736x/d9/56/9b/d9569bbed4393e2ceb1af7ba64fdf86a.jpg',
                name: 'John Doe',
                timePosted: '2 hours ago',
                status: 'Waiting',
                title: 'Feed Title 1',
                description:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                voteCount: 10,
              ),
              FeedModel(
                avatarUrl:
                    'https://i.pinimg.com/736x/d9/56/9b/d9569bbed4393e2ceb1af7ba64fdf86a.jpg',
                name: 'John Doe',
                timePosted: '2 hours ago',
                status: 'Waiting',
                title: 'Feed Title 1',
                description:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                voteCount: 10,
              ),
              FeedModel(
                avatarUrl:
                    'https://i.pinimg.com/736x/d9/56/9b/d9569bbed4393e2ceb1af7ba64fdf86a.jpg',
                name: 'John Doe',
                timePosted: '2 hours ago',
                status: 'Waiting',
                title: 'Feed Title 1',
                description:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                voteCount: 10,
              ),
              FeedModel(
                avatarUrl:
                    'https://i.pinimg.com/736x/d9/56/9b/d9569bbed4393e2ceb1af7ba64fdf86a.jpg',
                name: 'John Doe',
                timePosted: '2 hours ago',
                status: 'Waiting',
                title: 'Feed Title 1',
                description:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                voteCount: 10,
              ),
              // Add more feeds for the "Public" tab
            ],
          ),
          FeedsTabView(
            feeds: [
              FeedModel(
                avatarUrl:
                    'https://i.pinimg.com/736x/d9/56/9b/d9569bbed4393e2ceb1af7ba64fdf86a.jpg',
                name: 'Jane Smith',
                timePosted: '5 hours ago',
                status: 'Handled',
                title: 'Feed Title 2',
                description:
                    'Nulla facilisi. Sed aliquam nibh auctor mauris tincidunt, et mattis velit commodo.',
                voteCount: 15,
              ),
              FeedModel(
                avatarUrl:
                    'https://i.pinimg.com/736x/d9/56/9b/d9569bbed4393e2ceb1af7ba64fdf86a.jpg',
                name: 'Jane Smith',
                timePosted: '5 hours ago',
                status: 'Handled',
                title: 'Feed Title 2',
                description:
                    'Nulla facilisi. Sed aliquam nibh auctor mauris tincidunt, et mattis velit commodo.',
                voteCount: 15,
              ),
              FeedModel(
                avatarUrl:
                    'https://i.pinimg.com/736x/d9/56/9b/d9569bbed4393e2ceb1af7ba64fdf86a.jpg',
                name: 'Jane Smith',
                timePosted: '5 hours ago',
                status: 'Handled',
                title: 'Feed Title 2',
                description:
                    'Nulla facilisi. Sed aliquam nibh auctor mauris tincidunt, et mattis velit commodo.',
                voteCount: 15,
              ),
              // Add more feeds for the "Official" tab
            ],
          ),
          FeedsTabView(
            feeds: [
              FeedModel(
                avatarUrl:
                    'https://i.pinimg.com/736x/d9/56/9b/d9569bbed4393e2ceb1af7ba64fdf86a.jpg',
                name: 'Alice Johnson',
                timePosted: '1 hour ago',
                status: 'Waiting',
                title: 'Feed Title 3',
                description:
                    'In eget dolor nisl. Sed tristique purus at sollicitudin convallis.',
                voteCount: 8,
              ),
              // Add more feeds for the "My Reports" tab
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle floating action button click
          // Navigate to the create feed page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateFeedScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Constants().p_button,
      ),
    );
  }
}