import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/model_for_single.dart';

class ShowListScreen extends StatefulWidget {
  const ShowListScreen({Key? key}) : super(key: key);

  @override
  State<ShowListScreen> createState() => _ShowListScreenState();
}

class _ShowListScreenState extends State<ShowListScreen> {
  Future<List<User>> getUserDataList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList = prefs.getStringList('mydataList') ?? [];

    print('JSON List: $jsonList'); // Print the retrieved JSON list

    List<User> userList = [];

    for (String jsonString in jsonList) {
      try {
        User user = User.fromMap(jsonDecode(jsonString));
        userList.add(user);
      } catch (e) {
        print('Error decoding user data: $e');
      }
    }

    print('User List: $userList'); // Print the final user list for debugging

    return userList;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Data'),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<User>>(
        future: getUserDataList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            List<User> userList = snapshot.data!;
            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                User user = userList[index];
                print('this is usedr lish${user}');
                return ListTile(
                  title: Text('Name: ${user.name}'),
                  subtitle: Text('Age: ${user.age}, Address: ${user.add}'),
                );
              },
            );
          } else {
            return Center(child: Text('No user data available'));
          }
        },
      ),
    );
  }
}