import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory/service.dart/Database.dart';
import 'package:inventory/service.dart/crud.dart';
import 'package:inventory/service.dart/shared_pref.dart';
import 'package:random_string/random_string.dart';

class EditPage extends StatefulWidget {
  String Image, Detail, Name, Quantity, UserName, Email, id, pid;
  EditPage(
      {required this.Detail,
      required this.Image,
      required this.Name,
      required this.Quantity,
      required this.Email,
      required this.UserName,
      required this.id,
      required this.pid});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  File? selectedImage;
  bool _isLoading = false;
  CrudMethods crudMethods = new CrudMethods();
  String addId = "";
  late String userIdkey, name, email;

  getMyInfoFromSharedPreference() async {
    userIdkey = await SharedPreferenceHelper().getUserId();
    name = await SharedPreferenceHelper().getUserName();
    email = await SharedPreferenceHelper().getUserEmail();
  }

  doThisOnLaunch() async {
    await getMyInfoFromSharedPreference();

    setState(() {});
  }

  @override
  void initState() {
    doThisOnLaunch();
    super.initState();
  }

  var downloadUrl;
  // CrudMethods crudMethods = new CrudMethods();

  final ImagePicker _picker = ImagePicker();

  bool imageSelected = false;

  uploadBlog() async {
    String name = widget.Name,
        Detail = widget.Detail,
        quantity = widget.Quantity,
        image = widget.Image;
    if (userTitleeditingcontroller.text != "") {
      name = userTitleeditingcontroller.text;
    }
    if (userDetaileditingcontroller.text != "") {
      Detail = userDetaileditingcontroller.text;
    }
    if (userquantityeditingcontroller.text != "") {
      quantity = userquantityeditingcontroller.text;
    }

    /// uploading image to firebase storage

    //     task.whenComplete(() {
    //     var url = ref.getDownloadURL();
    //  }).catchError((onError) {
    //   print(onError);
    //   });
    if (selectedImage != null) {
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("blogImages").child(addId);

      final UploadTask task = firebaseStorageRef.putFile(selectedImage);

      var downloadUrl = await (await task).ref.getDownloadURL();
      print("this is url $downloadUrl");

      image = downloadUrl;
    }

    Map<String, dynamic> blogMap = {
      "imgUrl": image,
      "Name": name,
      "Detail": Detail,
      "UserName": widget.UserName,
      "Quantity": quantity,
      "id": widget.id,
      "Email": widget.Email,
      "Productid": widget.pid,
    };
    DatabaseMethods().addEdit(blogMap);
    DatabaseMethods().updateLastMessageSend(widget.pid, blogMap).then((result) {
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => StepList(
      //               id: addId,
      //             )));

      Fluttertoast.showToast(
          msg: "Product has been Edited Successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {
        userTitleeditingcontroller.text = "";
        userDetaileditingcontroller.text = "";
        selectedImage = null;
      });
    });
  }

  Future getImage() async {
    ImagePicker imagePicker;
    var image = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = File(image.path);
    });
  }

  TextEditingController userTitleeditingcontroller =
      new TextEditingController();
  TextEditingController userDetaileditingcontroller =
      new TextEditingController();
  TextEditingController userquantityeditingcontroller =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit",
          style: TextStyle(
              fontSize: 22, fontFamily: 'Poppins', color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: [
              selectedImage != null
                  ? GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Center(
                        child: Container(
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Image.file(
                            selectedImage!,
                            fit: BoxFit.cover,
                          )),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Container(
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.network(
                            widget.Image,
                            fit: BoxFit.cover,
                          )),
                    ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.black,
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(24)),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  controller: userTitleeditingcontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.Name,
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.black,
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(24)),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  controller: userquantityeditingcontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.Quantity,
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.black,
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 15,
                  style: TextStyle(color: Colors.black),
                  controller: userDetaileditingcontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.Detail,
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              GestureDetector(
                onTap: () {
                  uploadBlog();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 138, 120, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Edit",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
