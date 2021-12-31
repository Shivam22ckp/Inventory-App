import 'package:flutter/material.dart';

import 'package:inventory/Admin/AdminProduct.dart';
import 'package:inventory/Admin/AdminUpload.dart';
import 'package:inventory/Admin/Edit.dart';
import 'package:inventory/Admin/History.dart';
import 'package:inventory/Admin/Users.dart';

class HomeAdmin extends StatefulWidget {
  HomeAdmin({Key? key}) : super(key: key);

  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin Panel",
          style: TextStyle(fontSize: 24.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminUpload()));
                },
                child: Center(
                  child: Card(
                    elevation: 5.0,
                    child: Column(children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.upload,
                          size: 30.0,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminUpload()));
                        },
                        child: Center(
                          child: Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Uploads",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Edit()));
                },
                child: Center(
                  child: Card(
                    elevation: 5.0,
                    child: Column(children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.edit,
                          size: 30.0,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Edit()));
                        },
                        child: Center(
                          child: Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Edit Product",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddProduct()));
                },
                child: Center(
                  child: Card(
                    elevation: 5.0,
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.all(6),
                            child: Icon(
                              Icons.add,
                              size: 30.0,
                            )),
                        GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Add Product",
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => History()));
                },
                child: Center(
                  child: Card(
                    elevation: 5.0,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6),
                          child: Icon(
                            Icons.history,
                            size: 30.0,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "History",
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Users()));
                },
                child: Center(
                  child: Card(
                    elevation: 5.0,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6),
                          child: Icon(
                            Icons.person,
                            size: 30.0,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Users",
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
