import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
   final String title;
   final VoidCallback onpress;
   double width=10;
   double height=10;
  Mybutton({required this.title,required this.onpress,required this.width,required this.height});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      child: MaterialButton(
        color: Colors.grey,
        minWidth: width,
        height: height,
        child:Text(title),
        onPressed: onpress,

      ),
    );
  }
}
