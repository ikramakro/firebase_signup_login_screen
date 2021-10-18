import 'package:flutter/material.dart';

class HomScreen extends StatefulWidget {
  const HomScreen({Key? key}) : super(key: key);

  @override
  _HomScreenState createState() => _HomScreenState();
}

class _HomScreenState extends State<HomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:

      AppBar(
        title: Text('Home Screen '),
        centerTitle: true,
      ),
      body:
      Column(
        children: [

        ],
      ),
    );
  }
}
