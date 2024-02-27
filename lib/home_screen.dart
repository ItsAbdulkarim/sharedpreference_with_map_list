import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpreference_with_map_list/listscreen.dart';
import 'package:sharedpreference_with_map_list/model/model_for_single.dart';
import 'package:sharedpreference_with_map_list/show_data_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> userList = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text('HomeScreen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            Image.asset(
              'images/forshare.png',
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                hintText: 'Enter Name',
                labelText: 'Enter Name',
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: ageController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                hintText: 'Enter Age',
                labelText: 'Enter Age',
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: addController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                hintText: 'Enter Address',
                labelText: 'Enter Address',
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: ContinuousRectangleBorder(),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: ()  {
                User user = User(
                  name: nameController.text.trim(),
                  age: int.tryParse(ageController.text.trim()) ?? 0,
                  add: addController.text.trim(),
                );

                saveUserData(user).then((value) => {
                  print('data is saved')
                });
                print('this is homescreedata${user}');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('User data saved in SharedPreferences')),
                );
              },
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ShowDataScreen();
                    },
                  ),
                );
              },
              child: Text('See Data'),
            ),
            SizedBox(height: 20,),
            /////////////////////////////////

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ShowListScreen();
                    },
                  ),
                );
              },
              child: Text('See Data'),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async
              {

                User user = User(
                  name: nameController.text.trim(),
                  age: int.tryParse(ageController.text.trim()) ?? 0,
                  add: addController.text.trim(),
                );
                userList.add(user);
                await saveUserDataList(userList);




              },
              child: Text('saveData'),
            ),

          ],
        ),
      ),
    );
  }

  Future<void> saveUserData(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Step 1: Convert user object to a map
    final Map<String, dynamic> userMap = user.toMap();

    // Step 2: Encode the map to JSON
    final String jsonData = jsonEncode(userMap);

    // Step 3: Save JSON data to shared preferences
   prefs.setString('mydata', jsonData);
  }
}


Future<void> saveUserDataList(List<User> userList) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String> userJsonList = userList.map((user) => jsonEncode(user.toMap())).toList();

  // Save the JSON list in shared preferences
  prefs.setStringList('mydataList', userJsonList);
}


