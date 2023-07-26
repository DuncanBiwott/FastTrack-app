import 'package:flutter/material.dart';


class MedicalCareDetails extends StatefulWidget {
  MedicalCareDetails({Key? key}) : super(key: key);

  @override
  State<MedicalCareDetails> createState() => _MedicalCareDetailsState();
}

class _MedicalCareDetailsState extends State<MedicalCareDetails> {
  String dropdownValue = 'Doctor Appointment';

  var items = ['Doctor Appointment', 'Hospital Facilities', 'Medical Bill Issues'];

  // Add a description map for each complaint type
  Map<String, String> complaintDescriptions = {
    'Doctor Appointment': 'This complaint is related to issues with scheduling or managing doctor appointments. Describe the specific problem you encountered with your doctor appointment.',
    'Hospital Facilities': 'If you faced any problems with the facilities provided by the hospital, such as cleanliness, medical equipment, or amenities, please describe them here.',
    'Medical Bill Issues': 'Raise this complaint if you have concerns or discrepancies regarding medical bills or charges you received from healthcare services. Provide detailed information about the issues you encountered with the medical bills.'
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
            const Padding(
              padding: EdgeInsets.all(8.0),
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
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Center(
                      child: Text(
                        "Doctor Appointment",
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
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Center(
                      child: Text(
                        "Hospital Facilities",
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
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Center(
                      child: Text(
                        "Medical Bill Issues",
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
                decoration: const BoxDecoration(
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
