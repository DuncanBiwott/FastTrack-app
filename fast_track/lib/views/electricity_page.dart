import 'package:flutter/material.dart';

class ElectricityDetails extends StatefulWidget {
  ElectricityDetails({Key? key}) : super(key: key);

  @override
  State<ElectricityDetails> createState() => _ElectricityDetailsState();
}

class _ElectricityDetailsState extends State<ElectricityDetails> {
  String dropdownValue = 'Power Outage';

  var items = ['Power Outage', 'High Electricity Bill', 'Electrical Hazards'];

  // Add a description map for each complaint type
  Map<String, String> complaintDescriptions = {
    'Power Outage': 'Raise this complaint if you are experiencing a power outage in your area or property. Provide information about the duration and location of the outage.',
    'High Electricity Bill': 'If you find that your electricity bill is significantly higher than usual or contains discrepancies, report it here with relevant details about your billing concerns.',
    'Electrical Hazards': 'Use this complaint type to report any electrical hazards or unsafe electrical installations. Describe the hazards and the potential risks they pose.',
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
                        "Power Outage",
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
                        "High Electricity Bill",
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
                        "Electrical Hazards",
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
