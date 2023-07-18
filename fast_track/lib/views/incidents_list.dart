import 'package:fast_track/models/incidents_response.dart';
import 'package:fast_track/services/api/user_request_services/incident_client.dart';
import 'package:flutter/material.dart';

class IncidentsList extends StatefulWidget {
  const IncidentsList({super.key});

  @override
  State<IncidentsList> createState() => _IncidentsListState();
}

class _IncidentsListState extends State<IncidentsList> {
  Future<List<IncidentResponse>>? incidents;
  @override
  void initState() {
   incidents=IncidentClient().getAllIncidents(perpage: 20, page: 1, context: context);
    super.initState();
  }

  onRefreshPage(){
    setState(() {
      incidents=IncidentClient().getAllIncidents(perpage: 20, page: 1, context: context);
    });
  }
  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: FutureBuilder<List<IncidentResponse>>(
      future:IncidentClient().getAllIncidents(perpage: 20, page: 1, context: context),
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
          List<IncidentResponse> data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID: ${data[index].id}',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  'Title: ${data[index].title}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  'Description: ${data[index].description}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  'Location: ${data[index].location}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  'Status: ${data[index].status}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                data[index].downloadUrl !=null? Container(
                  height: 120, 
                  child:  Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Image.network(
                          '${data[index].downloadUrl}',
                          width: 120, 
                          fit: BoxFit.cover,
                        ),
                      
                    
                  ),
                ) :  Container(
                  height: 120, 
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data[index].downloadUrls?.length,
                    itemBuilder: (context, urlIndex) {
                      String url = data[index].downloadUrls![urlIndex];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Image.network(
                          url,
                          width: 120, 
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
    );
        }
      },
    ),
  );
}
}