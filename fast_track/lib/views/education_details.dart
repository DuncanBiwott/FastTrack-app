import 'package:flutter/material.dart';

class EducationDetails extends StatefulWidget {
  EducationDetails({Key? key}) : super(key: key);

  @override
  State<EducationDetails> createState() => _EducationDetailsState();
}

class _EducationDetailsState extends State<EducationDetails> {
  String dropdownValue = 'Teacher Issues';

  var items = ['Teacher Issues', 'Curriculum Complaint', 'School Facilities'];

  // Add a description map for each complaint type
  Map<String, String> complaintDescriptions = {
    'Teacher Issues': 'Raise this complaint if you have concerns or issues with a specific teacher or teaching methods. Describe the situation and any incidents that have affected your learning experience.',
    'Curriculum Complaint': 'If you feel that the curriculum lacks necessary information or contains inappropriate content, report your concerns here with detailed feedback and suggestions for improvement.',
    'School Facilities': 'Use this complaint type to report any issues or problems with school facilities, such as classrooms, laboratories, or other amenities. Describe the specific problems you have encountered.',
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
                        "Teacher Issues",
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
                        "Curriculum Complaint",
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
                        "School Facilities",
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
