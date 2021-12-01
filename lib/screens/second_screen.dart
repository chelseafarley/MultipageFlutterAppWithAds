import 'package:flutter/material.dart';
import 'first_screen.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => FirstScreen(
              title: 'Flutter Multipage Ad Demo'
            )
          ));
        },
        child: const Text('Back to First Screen'),
      )
    );
  }
}