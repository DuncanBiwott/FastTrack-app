import 'package:fast_track/constants/constants.dart';
import 'package:flutter/material.dart';

class ProfileManagementPage extends StatefulWidget {
  const ProfileManagementPage({super.key});

  @override
  _ProfileManagementPageState createState() => _ProfileManagementPageState();
}

class _ProfileManagementPageState extends State<ProfileManagementPage> {
  String _name = 'Dan Biwott';
  String _email = 'danbiwott77@gmail.com';
  bool _isEmailNotificationEnabled = true;
  bool _isPushNotificationEnabled = false;
  bool _isSMSNotificationEnabled = true;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = _name;
    _emailController.text = _email;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _updateName(String newName) {
    setState(() {
      _name = newName;
      _nameController.text = _name;
    });
  }

  void _updateEmail(String newEmail) {
    setState(() {
      _email = newEmail;
      _emailController.text = _email;
    });
  }

  void _toggleEmailNotification(bool value) {
    setState(() {
      _isEmailNotificationEnabled = value;
    });
  }

  void _togglePushNotification(bool value) {
    setState(() {
      _isPushNotificationEnabled = value;
    });
  }

  void _toggleSMSNotification(bool value) {
    setState(() {
      _isSMSNotificationEnabled = value;
    });
  }

  void _showNameEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Name'),
          content: TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              hintText: 'Enter your name',
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants().s_button, // Set background color
              ),
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                _updateName(_nameController.text);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).primaryColor, // Set background color
              ),
            ),
          ],
        );
      },
    );
  }

  void _showEmailEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Email'),
          content: TextField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: 'Enter your email',
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants().s_button, // Set background color
              ),
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                _updateEmail(_emailController.text);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).primaryColor, // Set background color
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Personal Information',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              ListTile(
                title: Text('Name'),
                subtitle: Text(_name),
                trailing: IconButton(
                    icon: Icon(Icons.edit), onPressed: _showNameEditDialog),
              ),
              ListTile(
                title: Text('Email'),
                subtitle: Text(_email),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: _showEmailEditDialog,
                ),
              ),
              SizedBox(height: 32.0),
              Text(
                'Communication Preferences',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              SwitchListTile(
                title: Text('Email Notifications'),
                value: _isEmailNotificationEnabled,
                onChanged: _toggleEmailNotification,
              ),
              SwitchListTile(
                title: Text('Push Notifications'),
                value: _isPushNotificationEnabled,
                onChanged: _togglePushNotification,
              ),
              SwitchListTile(
                title: Text('SMS Notifications'),
                value: _isSMSNotificationEnabled,
                onChanged: _toggleSMSNotification,
              ),
              SizedBox(height: 32.0),
              Text(
                'Activity History',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              // TODO: Implement activity history section
            ],
          ),
        ),
      ),
    );
  }
}