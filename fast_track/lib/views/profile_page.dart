import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/api/authenticationService/loginService/login_dio_client.dart';
import '../services/api/user_request_services/complaint_client.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future _showSuccessMessage(String massage, Color color) {
    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: color,
      message: massage,
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  final ComplaintClient complaintClient = ComplaintClient();
  Future<Response>? _profileFuture;

  @override
  void initState() {
    _profileFuture = complaintClient.getProfile(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 30.0),
              child: Text(
                'My Profile',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<Response>(
              future: _profileFuture,
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
                  Map<String, dynamic>? userData = snapshot.data?.data;

                  return Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  child: Container(
    height: 220,
    width: MediaQuery.of(context).size.width * 0.7,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.grey),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                FontAwesomeIcons.user,
                size: 32,
              ),
              const Icon(
                FontAwesomeIcons.angleRight,
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Text(
            "Email: ${userData?['email'] ?? 'N/A'}",
            style: TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 4.0),
          Row(
            children: [
              const Icon(
                Icons.verified,
                color: Colors.blue,
                size: 16.0,
              ),
              const SizedBox(width: 4.0),
              Text(
                "UserName: ${userData?['username'] ?? 'N/A'}",
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
          Text(
            "FullName: ${userData?['fullName'] ?? 'N/A'}",
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            "Account created At: ${userData?['createdAt'] ?? 'N/A'}",
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            "Status: ${userData?['contentStatus'] ?? 'N/A'}",
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    ),
  ),
);

                }
              },
            ),
            const Divider(),
             Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey)),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ListTile(
                  leading: const Icon(
                    Icons.notifications,
                  ),
                  title: const Text(
                  "Payments & purchases",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Icon(
                  FontAwesomeIcons.angleRight,
                  size: 24,
                ),
                  onTap: () {},
                ),
              ),
            ),
             const SizedBox(
              height: 10,
            ),
          
            const Text(
              "Settings & Preferences",
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey)),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ListTile(
                  leading: const Icon(
                    Icons.notifications,
                  ),
                  title: const Text(
                    'Notification',
                  ),
                  trailing: const Icon(FontAwesomeIcons.angleRight),
                  onTap: () {},
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey)),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ListTile(
                  leading: const Icon(Icons.dark_mode),
                  title: const Text(
                    'Dark Mode',
                  ),
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {},
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey)),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ListTile(
                  title: const Text(
                    'Language',
                  ),
                  leading: const Icon(
                    FontAwesomeIcons.language,
                  ),
                  trailing: const Icon(
                    FontAwesomeIcons.angleRight,
                  ),
                  onTap: () {},
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey)),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ListTile(
                  title: const Text(
                    'Security',
                  ),
                  leading: Icon(
                    FontAwesomeIcons.shield,
                  ),
                  trailing: const Icon(
                    FontAwesomeIcons.angleRight,
                  ),
                  onTap: () {},
                ),
              ),
            ),
            Divider(),
            //Support Section
            Text(
              'Support',
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey)),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ListTile(
                  title: Text('Help center'),
                  leading: const Icon(
                    FontAwesomeIcons.book,
                  ),
                  trailing: Icon(
                    FontAwesomeIcons.angleRight,
                  ),
                  onTap: () {},
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey)),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ListTile(
                  title: const Text('Report a bug'),
                  leading: const Icon(
                    FontAwesomeIcons.flag,
                  ),
                  trailing: Icon(
                    FontAwesomeIcons.angleRight,
                  ),
                  onTap: () {},
                ),
              ),
            ),
            Divider(),
            TextButton(
                onPressed: () async {
                  LoginDioClient().logout(context);
                },
                child: const Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.arrowRightToBracket,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Logout",
                      style: TextStyle(
                          letterSpacing: 0.5,
                          fontSize: 24,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}
