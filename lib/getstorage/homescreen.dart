import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GetStorageScreen extends StatefulWidget {
  const GetStorageScreen({super.key});

  @override
  State<GetStorageScreen> createState() => _GetStorageScreenState();
}

class _GetStorageScreenState extends State<GetStorageScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  final storageBox = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('GetStorage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Enter your name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter your age'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(vertical: 20)),
                onPressed: () {
                  String name = nameController.text.trim();
                  int age = int.tryParse(ageController.text.trim()) ?? 0;
                  //save user data
                  storageBox.write('name', name);
                  storageBox.write('age', age);
                },
                child: Text(
                  'saved',
                  style: TextStyle(color: Colors.white),
                )),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(vertical: 20)),
                onPressed: () {
                  Get.to(ShowStorageDataScreen());
                },
                child: Text(
                  'show',
                  style: TextStyle(color: Colors.white),
                )),
            Text('this is for one time'),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 20,
              color: Colors.blue,
            ),
            Text('this is list of user'),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    padding: EdgeInsets.symmetric(vertical: 20)),
                onPressed: () {
                  String name = nameController.text.trim();
                  int age = int.tryParse(ageController.text.trim()) ?? 0;
                  //save user data
                  // Read existing data
                  List<int> agee = storageBox.read('age') ?? [];
                  List<String> namee = storageBox.read('name') ?? [];

                  // Add new data
                  agee.add(age);
                  namee.add(name);

                  // Save updated data
                  storageBox.write('name', namee);
                  storageBox.write('age', agee);
                },
                child: Text(
                  'saved',
                  style: TextStyle(color: Colors.white),
                )),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(vertical: 20)),
                onPressed: () {
                  Get.to(UserDataList());
                },
                child: Text(
                  'show',
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}

//for one time
class ShowStorageDataScreen extends StatelessWidget {
  ShowStorageDataScreen({super.key});
  final getdata = GetStorage();

  @override
  Widget build(BuildContext context) {
    String name = getdata.read('name') ?? 'N/A';
    int age = getdata.read('age') ?? 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('show data'),
      ),
      body: ListView(
        children: [Text('this is name${name}'), Text('this is age${age}')],
      ),
    );
  }
}
////list screen

class UserDataList extends StatelessWidget {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    List<String> names = box.read('name') ?? [];
    List<int> ages = box.read('age') ?? [];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: names.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 10,
              child: ListTile(
                title: Text('Name: ${names[index]}'),
                subtitle: Text('Age: ${ages[index]}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
