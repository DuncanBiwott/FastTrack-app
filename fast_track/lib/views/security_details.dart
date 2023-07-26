import 'package:flutter/material.dart';

class SecurityDetails extends StatefulWidget {
  SecurityDetails({Key? key}) : super(key: key);

  @override
  State<SecurityDetails> createState() => _SecurityDetailsState();
}

class _SecurityDetailsState extends State<SecurityDetails> {
  String dropdownValue = 'Safety Concerns';

  var items = ['Safety Concerns', 'Theft Report', 'Security Staff Issues'];

  // Add a description map for each complaint type
  Map<String, String> complaintDescriptions = {
    'Safety Concerns': 'Raise this complaint if you feel unsafe or have concerns about the security of a specific area or location. Describe the situation and any incidents that have occurred.',
    'Theft Report': 'If you have experienced theft or witnessed a theft incident, report it here with detailed information about the incident and any suspect description, if available.',
    'Security Staff Issues': 'Use this complaint to report any issues or concerns related to security personnel or security services. Provide relevant details about the incident or behavior of the security staff.'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Complaint Type"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 140,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        "Safety Concerns",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 140,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        "Theft Report",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 140,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        "Security Staff Issues",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "More Complaints",
                    style: TextStyle(color: Colors.black),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      elevation: 0,
                      value: dropdownValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Write Short Description"),
                      const SizedBox(height: 10),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Enter your concern here",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (() {}),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Container(
                  height: 40,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Expanded(
                    child: Center(
                      child: Text(
                        "Raise Complaint",
                        style: TextStyle(color: Colors.white70, fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
