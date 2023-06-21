import 'package:fast_track/models/feed.dart';
import 'package:flutter/material.dart';

import 'feeds_card.dart';

class FeedsTabView extends StatelessWidget {
  final List<FeedModel> feeds;

  const FeedsTabView({
    Key? key,
    required this.feeds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: feeds.length,
      itemBuilder: (context, index) {
        final feed = feeds[index];
        return FeedCard(
          avatarUrl: feed.avatarUrl,
          name: feed.name,
          timePosted: feed.timePosted,
          status: feed.status,
          title: feed.title,
          description: feed.description,
          voteCount: feed.voteCount,
        );
      },
    );
  }
}
