import 'package:flutter/material.dart';
import 'package:inventory/Admin/Added.dart';
import 'package:inventory/Admin/Approved.dart';
import 'package:inventory/Admin/Edited.dart';
import 'package:inventory/Admin/Removed.dart';

class History extends StatefulWidget {
  History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "History",
          style: TextStyle(
              fontSize: 25,
              fontFamily: 'Poppins',
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: [
            Text(
              "Who ?",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 34.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Approved()));
              },
              child: Center(
                child: Card(
                  elevation: 5.0,
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.all(6),
                      child: Icon(
                        Icons.done,
                        size: 30.0,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Approved()));
                      },
                      child: Center(
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Approved",
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
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
                    MaterialPageRoute(builder: (context) => Removed()));
              },
              child: Center(
                child: Card(
                  elevation: 5.0,
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.all(6),
                      child: Icon(
                        Icons.cancel,
                        size: 30.0,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Removed()));
                      },
                      child: Center(
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Removed",
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
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
                    context, MaterialPageRoute(builder: (context) => Added()));
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
                                "Added",
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
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Edited()));
              },
              child: Center(
                child: Card(
                  elevation: 5.0,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.edit,
                          size: 30.0,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Center(
                          child: Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Edited",
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
          ],
        ),
      ),
    );
  }
}
