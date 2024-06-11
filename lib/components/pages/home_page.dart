import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../controller/model/students.dart'; // Ensure the correct path to your model

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Student> _dataList = [];

  void convertData(List<dynamic> jsonData) {
    setState(() {
      _dataList = jsonData.map((item) => Student.fromJson(item)).toList();
    });
  }

  void getData() async {
    var url = Uri.parse('https://sheetdb.io/api/v1/2i98c60xvm3gp');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      convertData(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      convertData([]);
    }
  }

  void _showInputDialog() {
    TextEditingController stdIdController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController surnameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Student Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: stdIdController,
                decoration: const InputDecoration(labelText: 'Student ID'),
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: surnameController,
                decoration: const InputDecoration(labelText: 'Surname'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                _addStudent(stdIdController.text, nameController.text, surnameController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addStudent(String stdId, String name, String surname) {
    String newId = (_dataList.isNotEmpty ? (int.parse(_dataList.last.id) + 1).toString() : '1');
    Student newStudent = Student(id: newId, stdId: stdId, name: name, surname: surname);
    setState(() {
      _dataList.add(newStudent);
    });

    // Optionally, send the new student data to the server
    _sendDataToServer(newStudent);
  }

  void _sendDataToServer(Student student) async {
    var url = Uri.parse('https://sheetdb.io/api/v1/2i98c60xvm3gp');
    var response = await http.post(url, body: jsonEncode(student.toJson()), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 201) {
        getData();
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(onPressed: getData, child: const Text("Get Data")),
              Expanded(
                child: ListView.builder(
                  itemCount: _dataList.length,
                  itemBuilder: (context, index) {
                    var item = _dataList[index];
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Student ID: ${item.stdId}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Name: ${item.name} ${item.surname}",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showInputDialog,
          tooltip: 'Add Student',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
