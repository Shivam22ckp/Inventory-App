import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory/service.dart/Database.dart';
import 'package:inventory/service.dart/shared_pref.dart';

class Removed extends StatefulWidget {
  Removed({Key? key}) : super(key: key);

  @override
  _RemovedState createState() => _RemovedState();
}

class _RemovedState extends State<Removed> {
  late Stream orderStream;
  late String userIdkey, id, name;
  getMyInfoFromSharedPreference() async {
    userIdkey = await SharedPreferenceHelper().getUserId();
    id = await SharedPreferenceHelper().getUserId();
    name = await SharedPreferenceHelper().getUserName();
  }

  doThisOnLaunch() async {
    await getMyInfoFromSharedPreference();
    orderStream = await DatabaseMethods().getRemoved();
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
                            onTap: () {},
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
                                        height: 20.0,
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
                                          Text(
                                            ds["Email"],
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
                                        height: 20.0,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Removed By :   ",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 20.0),
                                          ),
                                          Flexible(
                                            child: Text(
                                              ds["AdminName"],
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
          "Removed",
          style: TextStyle(
              color: Colors.black, fontFamily: 'Poppins', fontSize: 25.0),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: orderSoon(),
    );
  }
}
