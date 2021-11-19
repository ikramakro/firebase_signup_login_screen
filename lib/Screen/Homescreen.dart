import 'package:flutter/material.dart';
import 'package:untitled/Screen/PostScreen.dart';
import 'package:untitled/Screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomScreen extends StatefulWidget {
  const HomScreen({Key? key}) : super(key: key);

  @override
  _HomScreenState createState() => _HomScreenState();
}

class _HomScreenState extends State<HomScreen> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home Screen '),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));},
            child: Icon(Icons.add),
          ),
          SizedBox(width: 20,),
          InkWell(
            
            onTap: (){
              _auth.signOut().then((value) {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
              });

              },
            child: Icon(Icons.logout),
          ),
        SizedBox(width: 20,),
        ],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
