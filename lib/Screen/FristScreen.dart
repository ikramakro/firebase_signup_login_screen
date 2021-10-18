import 'package:flutter/material.dart';
import 'package:untitled/Screen/Signup.dart';
import 'package:untitled/widget/Button.dart';

import 'login.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("Assets/firebase.PNG"),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Mybutton(
                title: 'Login',
                width: double.infinity,
                height: 50,
                onpress: () {Navigator.push(
                  context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                }),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Mybutton(
                title: 'Sign Up',
                width: double.infinity,
                height: 50,
                onpress: () {Navigator.push(context, MaterialPageRoute(builder: (
            context) => SignUp()));}),
          ),
        ],
      ),
    );
  }
}
