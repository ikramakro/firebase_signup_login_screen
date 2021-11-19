import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:untitled/widget/Button.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  bool showSpiner=false;
  final postRef=FirebaseDatabase.instance.reference().child('posts');
  firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;

  FirebaseAuth _auth=FirebaseAuth.instance;
  File? _image;
  final picker = ImagePicker();
  TextEditingController titlecontroler = TextEditingController();
  TextEditingController descriptioncontroler = TextEditingController();

  Future getGellaryimage () async{
    final pickedFile=await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
         print('NO Image Selected');
    }});

  }
  Future getCameraimage () async{
    final pickedFile=await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('NO Image Selected');
      }});

  }

  void dialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Container(
              height: 120,
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      getCameraimage();
                      Navigator.pop(context);
                      },
                    child: ListTile(
                      leading: Icon(Icons.camera),
                      title: Text('Camera'),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      getGellaryimage();
                      Navigator.pop(context);
                      },
                    child: ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Gallery'),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpiner,
      child: Scaffold(
        appBar: AppBar(
          title: Text('post Screen '),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    dialog(context);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * .2,
                    width: MediaQuery.of(context).size.width * .8,
                    child: _image != null
                        ? ClipRect(
                            child: Image.file(
                            _image!.absolute,
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ))
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            width: 100,
                            height: 100,
                            child: Icon(Icons.camera_alt),
                          ),
                  ),
                ),
                Form(
                  child: Column(children: [
                    TextFormField(
                      controller: titlecontroler,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Enter Post Title ',
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: descriptioncontroler,
                      keyboardType: TextInputType.text,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Enter Post Description ',
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Mybutton(
                      title: "Upload",
                      width: double.infinity,
                      height: 50,
                      onpress: ()async {
                        setState(() {
                          showSpiner=true;
                        });
                        try{
                          int date =DateTime.now().microsecondsSinceEpoch;
                          firebase_storage.Reference ref=firebase_storage.FirebaseStorage.instance.ref('/untitled$date');
                          UploadTask  uploadTask= ref.putFile(_image!.absolute);
                          await Future.value(uploadTask);
                          var newurl=await ref.getDownloadURL();

                          final User? user=_auth.currentUser;
                          postRef.child('post list').child(date.toString()).set({
                            "pid":date.toString(),
                            "pImage":newurl.toString(),
                            "pTime":date.toString(),
                            "pTitle":titlecontroler.text.toString(),
                            "pDescription":descriptioncontroler.text.toString(),
                            "pEmail":user!.email.toString(),
                            // "uid":user!.uid.toString()


                          }).then((value) {
                            toastMasseges('post published');
                            setState(() {
                              showSpiner=false;
                            });
                            
                          }).onError((error, stackTrace) {
                            toastMasseges(error.toString());
                            setState(() {
                              showSpiner=false;
                            });
                          });

                        }catch(e){
                          setState(() {
                            showSpiner=false;
                          });
                          toastMasseges(e.toString());
                          print(e);

                        }

                      },
                    )
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void toastMasseges(String masseg) {
    Fluttertoast.showToast(
        msg: masseg.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

