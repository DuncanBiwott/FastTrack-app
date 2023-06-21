import 'package:fast_track/constants/constants.dart';
import 'package:flutter/material.dart';

class FeedCard extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String timePosted;
  final String status;
  final String title;
  final String description;
  final int voteCount;

  const FeedCard({
    Key? key,
    required this.avatarUrl,
    required this.name,
    required this.timePosted,
    required this.status,
    required this.title,
    required this.description,
    required this.voteCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                    radius: 20.0, backgroundImage: NetworkImage(avatarUrl)),
                SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      timePosted,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: status == 'Waiting' ? Colors.orange : Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              description,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Icon(
                  Icons.thumb_up,
                  size: 16.0,
                  color: Colors.grey,
                ),
                SizedBox(width: 4.0),
                Text(
                  voteCount.toString(),
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // Add your logic for viewing feed details here
                  },
                  style: ElevatedButton.styleFrom(
                backgroundColor:Constants().s_button, // Set background color
              ),
                  child: Text('View Details',style: TextStyle(color: Constants().s_button_text),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
