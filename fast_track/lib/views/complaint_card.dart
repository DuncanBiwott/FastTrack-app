import 'package:fast_track/constants/constants.dart';
import 'package:fast_track/models/complaint_response.dart';
import 'package:fast_track/services/api/user_request_services/complaint_client.dart';
import 'package:flutter/material.dart';

class ComplaintCard extends StatefulWidget {


  const ComplaintCard({
    Key? key,
  }) : super(key: key);

  @override
  State<ComplaintCard> createState() => _ComplaintCardState();

}

class _ComplaintCardState extends State<ComplaintCard> {

  

   Future<List<ComplaintResponse>>? complaintsData;

  @override
  void initState() {
    complaintsData=ComplaintClient().getComplaints(page: 1, perPage: 20);
    super.initState();
  }


onRefreshPage(){
  setState(() {
    complaintsData=ComplaintClient().getComplaints(page: 1, perPage: 20);
  });
}
 
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ComplaintResponse>>(
      future:ComplaintClient().getComplaints( page: 1, perPage: 20),
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
               
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data[index].user["username"],
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      data[index].date,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  data[index].status,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: data[index].status == 'OPEN' ? Colors.orange : Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              data[index].title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
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
            Row(
              children: [
                const Icon(
                  Icons.thumb_up,
                  size: 16.0,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4.0),
               
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
               
                  },
                  style: ElevatedButton.styleFrom(
                backgroundColor:Constants().s_button, 
              ),
                  child: Text('View Details',style: TextStyle(color: Constants().s_button_text),),
                ),
              ],
            ),
          ],
        ),
      ),
        );
             },);
       
     
    }
      },
    );
    
  }
}



