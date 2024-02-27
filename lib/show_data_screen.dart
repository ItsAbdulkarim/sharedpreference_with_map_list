import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/model_for_single.dart';

class ShowDataScreen extends StatelessWidget {
  const ShowDataScreen({super.key});

  // Retrieve user data from shared preferences
  Future<User?> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Step 4: Retrieve JSON data from shared preferences
    final String? jsonData = prefs.getString('mydata');
    print('JSON dddddData: $jsonData');

    if (jsonData != null) {
      // Step 5: Decode JSON data to a map
      final Map<String, dynamic> userMap = json.decode(jsonData);

      // Step 6: Create a User object from the map
      return User.fromMap(userMap);
    }

    return null;

    // Return null if no data is found
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<User?>(
          future: getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              User? userData = snapshot.data;

              if (userData != null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Name: ${userData.name}'),
                    Text('Age: ${userData.age}'),
                    Text('Address: ${userData.add}'),
                  ],
                );
              } else {
                return Text('User data is null');
              }
            } else {
              return Text('No user data available');
            }
          },
        )

      ),
    );
  }
}



