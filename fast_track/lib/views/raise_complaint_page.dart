import 'package:flutter/material.dart';

class RaiseComplaintPage extends StatefulWidget {
  @override
  _RaiseComplaintPageState createState() => _RaiseComplaintPageState();
}

class _RaiseComplaintPageState extends State<RaiseComplaintPage> {
  final TextEditingController _localityController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final List<String> _complaintTypes = [
    'Type 1',
    'Type 2',
    'Type 3',
    'Type 4',
  ];

  String? _selectedComplaintType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raise Complaint'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Locality Textfield
            TextField(
              controller: _localityController,
              decoration: InputDecoration(labelText: 'Locality'),
            ),
            SizedBox(height: 16),
            // Complaint Type Dropdown
            DropdownButtonFormField<String>(
              value: _selectedComplaintType,
              items: _complaintTypes.map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedComplaintType = newValue;
                });
              },
              decoration: InputDecoration(labelText: 'Complaint Type'),
            ),
            SizedBox(height: 16),
            // Title Textfield
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
        
            Expanded(
              child: TextField(
                controller: _descriptionController,
                maxLines: null,
                decoration: const InputDecoration(
                  
                  labelText: 'Write short description here',
                  hintText: 'Enter your concern here',
                ),
              ),
            ),
            SizedBox(height: 16),
       
            ElevatedButton(
              onPressed: () {
                
              },
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              child:  const Text('Raise a Complaint',style: TextStyle(color: Colors.white),)),
            
          ],
        ),
      ),
    );
  }
}
