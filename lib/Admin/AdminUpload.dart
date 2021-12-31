import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory/Pages/detailpage.dart';
import 'package:inventory/service.dart/Database.dart';
import 'package:inventory/service.dart/shared_pref.dart';
import 'package:random_string/random_string.dart';

class AdminUpload extends StatefulWidget {
  AdminUpload({Key? key}) : super(key: key);

  @override
  _AdminUploadState createState() => _AdminUploadState();
}

class _AdminUploadState extends State<AdminUpload> {
  late Stream orderStream;
  late String userIdkey, id, name;
  getMyInfoFromSharedPreference() async {
    userIdkey = await SharedPreferenceHelper().getUserId();
    id = await SharedPreferenceHelper().getUserId();
    name = await SharedPreferenceHelper().getUserName();
  }

  doThisOnLaunch() async {
    await getMyInfoFromSharedPreference();
    orderStream = await DatabaseMethods().getUpload();
    setState(() {});
  }

  @override
  void initState() {
    doThisOnLaunch();
    super.initState();
  }

  Widget orderSoon() {
    return StreamBuilder(
      stream: orderStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(right: 10.0, left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                          Image: ds["imgUrl"],
                                          Name: ds["Name"],
                                          quantity: ds["Quantity"],
                                          Detail: ds["Detail"],
                                          Username: ds["Username"])));
                            },
                            child: Card(
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.black87,
                                      borderRadius:
                                          BorderRadius.circular(16.0)),
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Container(
                                            child: Image.network(
                                              ds["imgUrl"],
                                              height: 220,
                                              width: 300,
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Product Name :   ",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 20.0),
                                          ),
                                          Text(
                                            ds["Name"],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),

                                      Row(
                                        children: [
                                          Text(
                                            "Quantity :   ",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 20.0),
                                          ),
                                          Text(
                                            ds["Quantity"],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Name :   ",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 20.0),
                                          ),
                                          Text(
                                            ds["UserName"],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Email :   ",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 20.0),
                                          ),
                                          Container(
                                            width: 200,
                                            child: Text(
                                              ds["Email"],
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Detail :   ",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 20.0),
                                          ),
                                          Flexible(
                                            child: Text(
                                              ds["Detail"],
                                              maxLines: 8,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      // ElevatedButton(
                                      //   onPressed: () async {
                                      //     await FirebaseFirestore.instance
                                      //         .runTransaction((Transaction
                                      //             myTransaction) async {
                                      //       await myTransaction.delete(snapshot
                                      //           .data.docs[index].reference);
                                      //     }).then((value) {
                                      //       DatabaseMethods()
                                      //           .deleteOrder(id, ds["id"]);
                                      //     });
                                      //     Map<String, dynamic> userorderInfoMap =
                                      //         {
                                      //       "Image": ds["Image"],
                                      //       "Product": ds["Product"],
                                      //       "Qunatity": ds["Quantity"],
                                      //       "Total": ds["Total"],
                                      //       "Status": "Completed!!"
                                      //     };
                                      //     DatabaseMethods()
                                      //         .addComporder(userorderInfoMap);
                                      //   },
                                      //   child: Text(
                                      //     "Delivered",
                                      //     style: TextStyle(
                                      //         fontWeight: FontWeight.bold,
                                      //         fontSize: 18.0),
                                      //   ),
                                      // ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              String addId =
                                                  randomAlphaNumeric(10);
                                              Map<String, dynamic> blogMap = {
                                                "imgUrl": ds["imgUrl"],
                                                "Name": ds["Name"],
                                                "Detail": ds["Detail"],
                                                "UserName": ds["UserName"],
                                                "Quantity": ds["Quantity"],
                                                "id": userIdkey,
                                                "Email": ds["Email"],
                                                "Productid": addId,
                                                "AdminName": name,
                                                "Key": ds["Key"],
                                              };
                                              DatabaseMethods()
                                                  .addPosts(blogMap, addId);
                                              DatabaseMethods()
                                                  .addApproved(blogMap);
                                              DatabaseMethods()
                                                  .addUserProducts(
                                                      blogMap, ds["id"])
                                                  .then((value) =>
                                                      FirebaseFirestore.instance
                                                          .runTransaction(
                                                              (Transaction
                                                                  myTransaction) async {
                                                        myTransaction.delete(
                                                            snapshot
                                                                .data
                                                                .docs[index]
                                                                .reference);
                                                      }));
                                            },
                                            child: Container(
                                              width: 110,
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                child: Text(
                                                  "Add",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 50.0,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Map<String, dynamic> blogMap = {
                                                "imgUrl": ds["imgUrl"],
                                                "Name": ds["Name"],
                                                "Detail": ds["Detail"],
                                                "UserName": ds["UserName"],
                                                "Quantity": ds["Quantity"],
                                                "id": userIdkey,
                                                "Email": ds["Email"],
                                                "AdminName": name,
                                              };
                                              DatabaseMethods()
                                                  .removePosts(blogMap)
                                                  .then((value) =>
                                                      FirebaseFirestore.instance
                                                          .runTransaction(
                                                              (Transaction
                                                                  myTransaction) async {
                                                        myTransaction.delete(
                                                            snapshot
                                                                .data
                                                                .docs[index]
                                                                .reference);
                                                      }));
                                            },
                                            child: Container(
                                              width: 110,
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                child: Text(
                                                  "Remove",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                            ),
                          ),
                        ],
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
          "Upload",
          style: TextStyle(
              color: Colors.black, fontFamily: 'Pacifico', fontSize: 25.0),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: orderSoon(),
    );
  }
}
