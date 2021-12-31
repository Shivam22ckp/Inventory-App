import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory/service.dart/Database.dart';
import 'package:inventory/service.dart/shared_pref.dart';
import 'package:random_string/random_string.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late File selectedImage;
  late String addId;
  bool _isLoading = false;
  var downloadUrl;
  String? pic;
  // CrudMethods crudMethods = new CrudMethods();

  getMyInfoFromSharedPreference() async {
    pic = await SharedPreferenceHelper().getUserProfileUrl();
  }

  doThisOnLaunch() async {
    await getMyInfoFromSharedPreference();
    orderStream = await DatabaseMethods().getProducts();
    print(pic);

    setState(() {});
  }

  @override
  void initState() {
    doThisOnLaunch();
    super.initState();
  }

  final ImagePicker _picker = ImagePicker();

  bool imageSelected = false;

  uploadBlog() async {
    if (selectedImage != null) {
      setState(() {
        _isLoading = true;
      });
      addId = randomAlphaNumeric(9);

      /// uploading image to firebase storage
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("blogImages").child(addId);

      final UploadTask task = firebaseStorageRef.putFile(selectedImage);

      var downloadUrl = await (await task).ref.getDownloadURL();
      print("this is url $downloadUrl");
      SharedPreferenceHelper().saveUserProfileUrl(downloadUrl);
      setState(() {});

      //     task.whenComplete(() {
      //     var url = ref.getDownloadURL();
      //  }).catchError((onError) {
      //   print(onError);
      //   });
    }
  }

  Future getImage() async {
    ImagePicker imagePicker;
    var image = await _picker.getImage(source: ImageSource.gallery);
    selectedImage = File(image.path);
    await uploadBlog();
    setState(() {});
  }

  Stream? orderStream;

  Widget orderSoon() {
    return StreamBuilder(
      stream: orderStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: snapshot.data.docs.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             Detail(id: ds["id"], Image: ds["imgUrl"])));
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          height: 110,
                          width: 110,
                          child: Image.network(
                            ds["imgUrl"],
                            height: 110,
                            width: 110,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
              fontSize: 24, fontFamily: 'Poppins', color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Column(
            children: [
              pic == null
                  ? GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.circular(70)),
                        child: Center(
                            child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 28.0,
                        )),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(70),
                        child: Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25)),
                          child: Image.network(
                            pic!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Text(
                  "Shivam Gupta",
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 350,
                child: orderSoon(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
