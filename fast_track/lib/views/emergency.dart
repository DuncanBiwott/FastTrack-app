import 'package:flutter/material.dart';

class EmergencyDetails extends StatefulWidget {
  EmergencyDetails({Key? key}) : super(key: key);

  @override
  State<EmergencyDetails> createState() => _EmergencyDetailsState();
}

class _EmergencyDetailsState extends State<EmergencyDetails> {
  String dropdownValue = 'Medical Emergency';

  var items = ['Medical Emergency', 'Fire Incident', 'Natural Disaster'];

  // Add a description map for each complaint type
  Map<String, String> complaintDescriptions = {
    'Medical Emergency': 'Raise this complaint if you are facing a medical emergency and need immediate medical assistance. Provide relevant details about the emergency situation.',
    'Fire Incident': 'If you have witnessed or experienced a fire incident, report it immediately with detailed information about the location and nature of the fire.',
    'Natural Disaster': 'Use this complaint type to report any natural disaster such as floods, earthquakes, or storms. Provide details about the disaster and its impact.',
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
                        "Medical Emergency",
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
                        "Fire Incident",
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
                        "Natural Disaster",
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
