import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory/Admin/Editpage.dart';
import 'package:inventory/Pages/upload.dart';
import 'package:inventory/service.dart/Database.dart';
import 'package:inventory/service.dart/shared_pref.dart';

class Edit extends StatefulWidget {
  Edit({Key? key}) : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  bool searching = false;

  late Stream orderStream;
  late String userIdkey, id;
  getMyInfoFromSharedPreference() async {
    userIdkey = await SharedPreferenceHelper().getUserId();
    id = await SharedPreferenceHelper().getUserId();
  }

  doThisOnLaunch() async {
    await getMyInfoFromSharedPreference();
    orderStream = await DatabaseMethods().getProducts();
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
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
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
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => DetailPage(
                              //             Image: ds["imgUrl"],
                              //             Name: ds["Name"],
                              //             quantity: ds["Quantity"],
                              //             Detail: ds["Detail"],
                              //             Username: ds["Username"])));
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
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditPage(
                                                        Image: ds["imgUrl"],
                                                        Detail: ds["Detail"],
                                                        Name: ds["Name"],
                                                        Quantity:
                                                            ds["Quantity"],
                                                        UserName:
                                                            ds["UserName"],
                                                        id: ds["id"],
                                                        Email: ds["Email"],
                                                        pid: ds["Productid"],
                                                      )));
                                        },
                                        child: Center(
                                          child: Container(
                                            width: 110,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                              child: Text(
                                                "Edit",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0),
                                              ),
                                            ),
                                          ),
                                        ),
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

  Widget Search() {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        child: TextField(
            onChanged: (value) {
              initiateSearch(value);
            },
            style: TextStyle(color: Colors.black, fontSize: 16.0),
            cursorColor: Theme.of(context).primaryColor,
            controller: searchgroceryEditingController,
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 35.0, vertical: 15.0),
                prefixIcon: Material(
                    borderRadius: BorderRadius.all(Radius.circular(23.0)),
                    child: GestureDetector(
                      onTap: () {
                        if (searchgroceryEditingController.text != "") {
                          // onSearchBtnClick();
                        }
                      },
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    )),
                border: InputBorder.none,
                hintText: "Search")),
      ),
    );
  }

  TextEditingController searchgroceryEditingController =
      TextEditingController();
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }
    setState(() {
      searching = true;
    });
    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      DatabaseMethods().Search(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.docs.length; ++i) {
          queryResultSet.add(docs.docs[i].data());
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['Name'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text(
            "Edit",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 30.0,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Search(),
              ),
              searching
                  ? ListView(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      primary: false,
                      shrinkWrap: true,
                      children: tempSearchStore.map((element) {
                        return buildResultCard(element);
                      }).toList())
                  : Container(height: 523, child: orderSoon())
            ],
          ),
        ));
  }

  Widget buildResultCard(data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditPage(
                      Image: data["imgUrl"],
                      Detail: data["Detail"],
                      Name: data["Name"],
                      Quantity: data["Quantity"],
                      UserName: data["UserName"],
                      id: data["id"],
                      Email: data["Email"],
                      pid: data["Productid"],
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.network(
                data["imgUrl"],
                height: 60,
                width: 60,
              ),
            ),
            SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                data["Name"],
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
