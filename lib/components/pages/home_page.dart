import 'package:flutter/material.dart';
import '../buttoms/custom_buttom.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

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

  void _goToSecondPage() {
    Navigator.pushNamed(context, '/second');
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
              const Text(
                'ຈຳນວນ',
                style: TextStyle(fontSize: 20, fontFamily: 'NotoSansLao' ),
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
              )
            ],
          ),
        ),
      ),
    );
  }

}
