import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: '4COM1 - APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.funcPromt,
      required this.btnText,
      required this.btnColor})
      : super(key: key);

  final Function() funcPromt;
  final String btnText;
  final Color btnColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: funcPromt,
        style: ElevatedButton.styleFrom(
            primary: btnColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        child: Text(btnText));
  }
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
      // if(_counter <= 0){
      //   _counter = 0;
      // }else{
      //   _counter--;
      // }
      
      if(_counter > 0){
        _counter--;
      }
     
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
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
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '$_counter',
              style: const TextStyle(color: Colors.green, fontSize: 50),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CustomButton(
                  funcPromt: _incrementCounter,
                  btnColor: Colors.green,
                  btnText: 'ເພີ່ມຄ່າ',
                ),
                CustomButton(
                  funcPromt: _disincrementCounter,
                  btnColor: Colors.red,
                  btnText: 'ລົບຄ່າ',
                ),
                CustomButton(
                  funcPromt: _resetCounter,
                  btnColor: Colors.blue,
                  btnText: 'ຄືນຄ່າ',
                ),
              ],
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
