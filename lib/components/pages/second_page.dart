
import 'package:flutter/material.dart';
class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    
    final value = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    
    
    return Scaffold(
      appBar: AppBar(title: const Text("Second Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Text(
              value!['title'],
            ),
            const SizedBox(height: 10),
            Text(
              value['content'],
            ),
            const SizedBox(height: 10),
            Text(
              value['counter'].toString(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.cyan,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.pop(context, 'Hello from Second Page');
              },
              child: const Text('Back to Home'),
            )
          ],
        ),
      ),
    );
    
    
  }
}