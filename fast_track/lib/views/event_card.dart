import 'package:fast_track/models/event_response.dart';
import 'package:flutter/material.dart';

import '../services/api/user_request_services/incident_client.dart';

class EventCard extends StatefulWidget {


  const EventCard({
    Key? key,
  }) : super(key: key);

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  late OverlayEntry _overlayEntry;
Future<List<EventResponse>>? eventsData;
  @override
  void initState() {
    super.initState();
    eventsData=IncidentClient().getAllEvents(perpage: 10,page: 1, context: context);
  
    _overlayEntry = OverlayEntry(builder: (context) => _buildOverlay());
  }

  @override
  void dispose() {
    _overlayEntry.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EventResponse>>(
      future:IncidentClient().getAllEvents(perpage: 10,page: 1, context: context),
      builder: (context, snapshot) { 
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          List<EventResponse> data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                data[index].imageUrl!,
                fit: BoxFit.cover,
                height: 150,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                data[index].title!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      data[index].eventDateTime!,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    onPressed: () {
                      Overlay.of(context).insert(_overlayEntry);
                    },
                    child: const Text(
                      'View Details',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
             },);
       
     
    }
      },
    );
    
    
    
    
    //
    
     
  }

  Widget _buildOverlay() {
    return Material(
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap: () {
              _overlayEntry.remove();
            },
            child: Container(
              color: Colors.black54,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height*0.5,
            left: MediaQuery.of(context).size.width*0.5,
            child:Card(
      child: SizedBox(
        width: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://img.freepik.com/free-vector/elegant-event-party-banner-with-black-splash_1361-2171.jpg?w=2000',
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Event Title',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Event Date Time',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () {
                      _overlayEntry.remove();
                    },
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () {
                         
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_red_eye),
                        onPressed: () {
                          
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.share),
                        onPressed: () {
                          
                        },
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    ),
             ),
          
        ],
      ),
    );
  }
}
