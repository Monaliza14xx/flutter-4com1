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

  void _showInputDialog({Student? student}) {
    TextEditingController stdIdController =
        TextEditingController(text: student?.stdId ?? '');
    TextEditingController nameController =
        TextEditingController(text: student?.name ?? '');
    TextEditingController surnameController =
        TextEditingController(text: student?.surname ?? '');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              student == null ? 'Enter Student Data' : 'Edit Student Data'),
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
                if (student == null) {
                  _addStudent(stdIdController.text, nameController.text,
                      surnameController.text);
                } else {
                  _editStudent(student, stdIdController.text,
                      nameController.text, surnameController.text);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addStudent(String stdId, String name, String surname) {
    String newId = (_dataList.isNotEmpty
        ? (int.parse(_dataList.last.id) + 1).toString()
        : '1');
    Student newStudent =
        Student(id: newId, stdId: stdId, name: name, surname: surname);
    setState(() {
      _dataList.add(newStudent);
    });

    // Optionally, send the new student data to the server
    _sendDataToServer(newStudent);
  }

  void _editStudent(
      Student student, String stdId, String name, String surname) {
    Student editedStudent =
    Student(id: student.id, stdId: stdId, name: name, surname: surname);
    setState(() {
      int index = _dataList.indexOf(student);
      _dataList[index] = editedStudent;
    });

    // Optionally, send the edited student data to the server
    _updateDataOnServer(editedStudent);
  }

  void _sendDataToServer(Student student) async {
    var url = Uri.parse('https://sheetdb.io/api/v1/2i98c60xvm3gp');
    var response = await http.post(url,
        body: jsonEncode(student.toJson()),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 201) {
      getData();
    } else {
      // Handle error
    }
  }

  void _updateDataOnServer(Student student) async {
    var url =
        Uri.parse('https://sheetdb.io/api/v1/2i98c60xvm3gp/id/${student.id}');
    var response = await http.put(url,
        body: jsonEncode(student.toJson()),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      getData();
    } else {
      // Handle error
    }
  }

  void _confirmDeleteStudent(Student student) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: Text(
              'Are you sure you want to delete ${student.name} ${student.surname}?'),
          actions: [
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteStudent(student);
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteStudent(Student student) async {
    var url =
        Uri.parse('https://sheetdb.io/api/v1/2i98c60xvm3gp/id/${student.id}');
    var response = await http.delete(url);
    if (response.statusCode == 200) {
      setState(() {
        _dataList.remove(student);
      });
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Student ID: ${item.stdId}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon:
                                          Icon(Icons.edit, color: Colors.blue),
                                      onPressed: () {
                                        _showInputDialog(student: item);
                                      },
                                    ),
                                    IconButton(
                                      icon:
                                          Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        _confirmDeleteStudent(item);
                                      },
                                    ),
                                  ],
                                ),
                              ],
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
          onPressed: () {
            _showInputDialog();
          },
          tooltip: 'Add Student',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
