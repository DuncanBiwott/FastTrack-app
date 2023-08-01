import 'package:fast_track/models/complaint_response.dart';
import 'package:fast_track/services/api/user_request_services/complaint_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';

import '../constants/constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<String> suggestions = [
    'Noise disturbances',
    'Water leaks',
    'Parking issues',
    'Garbage collection problems',
    'Security concerns',
    'Street lighting outages',
    'Vandalism incidents',
    'Pet-related complaints',
    'Traffic accidents',
    'Community events/activities',
    'Lost and found items',
    'Neighbor disputes',
    'Air quality concerns',
    'Broken infrastructure',
    'Insect/pest infestations',
    'Property maintenance issues',
    'Safety hazards',
    'Unattended children',
    'Suspicious activities',
    'Deteriorating road conditions',
    'Internet connectivity problems',
    'Package delivery issues',
    'Illegal dumping',
    'Graffiti',
    'Power outages',
    'Trespassing incidents',
    'Excessive speeding',
    'Drainage problems',
    'Wildlife sightings/concerns',
    'Loud parties/gatherings',
    'Tree trimming requests',
    'Damaged public property',
    'Street signage issues',
    'Abandoned vehicles',
    'Harassment complaints',
    'Public transportation issues',
    'Hazardous waste disposal',
    'Health and sanitation concerns',
    'Faulty street signals',
    'Broken playground equipment',
    'Stray animal sightings',
    'Unsightly property conditions',
    'Encroachment violations',
    'Water supply disruptions',
    'Criminal activities',
    'Overgrown vegetation',
    'School zone safety concerns',
    'Unlicensed businesses',
    'Flooded areas',
  ];
  Future<List<ComplaintResponse>>? _complaintsFuture;
  Future<void> _fetchComplaints(String searchString) async {
    setState(() {
      _complaintsFuture = ComplaintClient().getComplaints(
        page: 1,
        perPage: 20,
        context: context,
        search: searchString,
      );
    });
  }

  void _showDetailsBottomSheet(
      BuildContext context, ComplaintResponse dataItem) {
    DateTime parsedDate = DateTime.parse(dataItem.date);
    String formattedDate = DateFormat('EEEE, d MMMM').format(parsedDate);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16.0,
              right: 16.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
                const Center(
                  child: CircleAvatar(
                    radius: 48.0,
                    backgroundImage: NetworkImage(
                        "https://cdn.pixabay.com/photo/2015/03/04/22/35/head-659651_960_720.png"),
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  dataItem.user["username"],
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  dataItem.title,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  dataItem.description,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "From ${dataItem.location}",
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Status: ${dataItem.status}",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: dataItem.status == 'OPEN'
                            ? Colors.orange
                            : Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const Icon(
                  Icons.thumb_up,
                  size: 24.0,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TypeAheadField(
              textFieldConfiguration: const TextFieldConfiguration(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search...',
                ),
              ),
              suggestionsCallback: (pattern) async {
                return suggestions.where((item) =>
                    item.toLowerCase().contains(pattern.toLowerCase()));
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion),
                );
              },
              onSuggestionSelected: (suggestion) {
                _fetchComplaints(suggestion);
              },
            ),
            Expanded(
              child: FutureBuilder<List<ComplaintResponse>>(
                future: _complaintsFuture,
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
                    List<ComplaintResponse> data = snapshot.data!;
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        DateTime parsedDate = DateTime.parse(data[index].date);
                        String formattedDate =
                            DateFormat('EEEE, d MMMM').format(parsedDate);
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
                                    const CircleAvatar(
                                      radius: 16.0,
                                      backgroundImage: NetworkImage(
                                        "https://cdn.pixabay.com/photo/2015/03/04/22/35/head-659651_960_720.png",
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data[index].user["username"],
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          formattedDate,
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Text(data[index].location,
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        const SizedBox(
                                          width: 8.0,
                                        ),
                                        Text(
                                          data[index].status,
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color: data[index].status == 'OPEN'
                                                ? Colors.orange
                                                : Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                Text(
                                  data[index].title,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  data[index].description,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 16.0),
                                const Icon(
                                  Icons.thumb_up,
                                  size: 16.0,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4.0),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _showDetailsBottomSheet(
                                          context, data[index]);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Constants().s_button,
                                    ),
                                    child: Text(
                                      'View Details',
                                      style: TextStyle(
                                          color: Constants().s_button_text),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
