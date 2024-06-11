import 'package:flutter/material.dart';
import '../buttoms/custom_buttom.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _value = "Innital value";
  late String _data = "No data";

  void convertData(value) {
    setState(() {
      _data = value.toString();
    });
  }

  void getData() async {
    var url = Uri.parse('https://sheetdb.io/api/v1/2i98c60xvm3gp');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      convertData(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      convertData("Error");
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _disincrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  void _reciveContext(value) {
    setState(() {
      _value = value;
    });
  }

  void _goToSecondPage() {
    Navigator.pushNamed(context, '/second', arguments: {
      "title": "second page",
      "content": "This is the second page",
      "counter": _counter
    }).then((value) => _reciveContext(value));
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
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_value, style: const TextStyle(fontSize: 20)),
              const Text(
                'ຈຳນວນ',
                style: TextStyle(fontSize: 20, fontFamily: 'NotoSansLao'),
              ),
              Text(
                '$_counter',
                style: const TextStyle(fontSize: 50, color: Colors.orange),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CustomButton(
                      btnFunc: _incrementCounter,
                      btnColor: Colors.green,
                      btnText: "ເພີ່ມຄ່າ",
                    ),
                    CustomButton(
                      btnFunc: _disincrementCounter,
                      btnColor: Colors.red,
                      btnText: "ລົບຄ່າ",
                    ),
                    CustomButton(
                      btnFunc: _resetCounter,
                      btnColor: Colors.blue,
                      btnText: "ຄືນຄ່າ",
                    ),
                  ]),
              CustomButton(
                btnFunc: _goToSecondPage,
                btnColor: Colors.cyan,
                btnText: "Go to second page",
              ),
              Text(
                _data.toString(),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: getData,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        )
      ),
    );
  }
}
