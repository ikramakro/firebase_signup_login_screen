// import 'dart:html';
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class shopPicCard extends StatefulWidget {
//   const shopPicCard({Key? key}) : super(key: key);
//
//   @override
//   _shopPicCardState createState() => _shopPicCardState();
// }
//
// class _shopPicCardState extends State<shopPicCard> {
//   @override
//   File? _image;
//
//   Widget build(BuildContext context) {
//     final _authData = Provider.of<AuthProvider>(context);
//     return Padding(padding: const EdgeInsets.all(20.0),
//       child: InkWell(
//         onTap: () {},
//
//         child: SizedBox(height: 150, width: 150,
//           child: Card(
//             child: ClipRRect(borderRadius: BorderRadius.circular(4),
//               child: _image == null ? Center(child: Text(
//                 "add image", style: TextStyle(color: Colors.grey),
//               )):Image.file(_image,fit:BoxFit.fill),
//             ),
//           ),
//         ),
//       ),
//
//     );
//   }
// }
