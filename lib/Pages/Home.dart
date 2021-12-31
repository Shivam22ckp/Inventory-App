import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory/Pages/detailpage.dart';
import 'package:inventory/Pages/signin.dart';
import 'package:inventory/service.dart/Auth.dart';
import 'package:inventory/service.dart/Database.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream? orderStream;
  bool searching = false;

  @override
  void initState() {
    super.initState();
    doThisOnLaunch();
  }

  doThisOnLaunch() async {
    orderStream = await DatabaseMethods().getProducts();
    setState(() {});
  }

  Widget orderSoon() {
    return StreamBuilder(
      stream: orderStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(
                                    quantity: ds["Quantity"],
                                    Name: ds["Name"],
                                    Detail: ds["Detail"],
                                    Image: ds["imgUrl"],
                                    Username: ds["UserName"],
                                  )));
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              ds["imgUrl"],
                              width: 140,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 130,
                                child: Text(
                                  ds["Name"],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Container(
                                width: 100,
                                child: Text(
                                  "by " + ds["UserName"],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                height: 50,
                                width: 130,
                                child: Text(
                                  ds["Detail"],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                width: 70,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(14)),
                                child: Center(
                                  child: Text(
                                    "Buy",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          )
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

  TextEditingController searchgroceryEditingController =
      TextEditingController();

  //       onSearchBtnClick() async {
  //   isSearching = true;
  //   setState(() {});
  //   usersStream = await DatabaseMethods()
  //       .getUserBygrocerysearch(searchgroceryEditingController.text);

  //   setState(() {});
  // }

  // Widget searchListUserTile({required String profileUrl, name, price, stock}) {
  //   return GestureDetector(
  //     onTap: () {
  //       // Navigator.pushReplacement(
  //       //     context,
  //       //     MaterialPageRoute(
  //       //         builder: (context) => ProductDetail(
  //       //               primage: profileUrl,
  //       //               prname: name,
  //       //               prprice: price,
  //       //               prstock: stock,
  //       //             )));
  //     },
  //     child: Container(
  //       margin: EdgeInsets.symmetric(vertical: 8),
  //       child: Row(
  //         children: [
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(40),
  //             child: Image.network(
  //               profileUrl,
  //               height: 40,
  //               width: 40,
  //             ),
  //           ),
  //           SizedBox(width: 12),
  //           Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [Text(name), Text(price.toString())])
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget searchUsersList() {
  //   return StreamBuilder(
  //     stream: usersStream,
  //     builder: (context, AsyncSnapshot snapshot) {
  //       return snapshot.hasData
  //           ? ListView.builder(
  //               itemCount: snapshot.data.docs.length,
  //               shrinkWrap: true,
  //               itemBuilder: (context, index) {
  //                 DocumentSnapshot ds = snapshot.data.docs[index];
  //                 return searchListUserTile(
  //                     profileUrl: ds["imgUrl"],
  //                     name: ds["Name"],
  //                     price: ds["Price"],
  //                     stock: ds["Stock"]);
  //               },
  //             )
  //           : Center(
  //               child: CircularProgressIndicator(),
  //             );
  //     },
  //   );

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

    //   Widget Search() {
    //     return Padding(
    //       padding: const EdgeInsets.only(right: 15, left: 15),
    //       child: Material(
    //         borderRadius: BorderRadius.all(Radius.circular(16.0)),
    //         child: TextField(
    //             onChanged: (value) {
    //               initiateSearch(value);
    //             },
    //             style: TextStyle(color: Colors.black, fontSize: 16.0),
    //             cursorColor: Theme.of(context).primaryColor,
    //             controller: searchgroceryEditingController,
    //             decoration: InputDecoration(
    //                 contentPadding:
    //                     EdgeInsets.symmetric(horizontal: 35.0, vertical: 15.0),
    //                 prefixIcon: Material(
    //                     borderRadius: BorderRadius.all(Radius.circular(23.0)),
    //                     child: GestureDetector(
    //                       onTap: () {
    //                         if (searchgroceryEditingController.text != "") {
    //                           // onSearchBtnClick();
    //                         }
    //                       },
    //                       child: Icon(
    //                         Icons.search,
    //                         color: Colors.black,
    //                       ),
    //                     )),
    //                 border: InputBorder.none,
    //                 hintText: "Search")),
    //       ),
    //     );
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 32.0, left: 15.0, right: 15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              "Inventory Helper",
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Container(
                            child: Text(
                              "Perfect Choice!",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn()));
                        },
                        child: Icon(
                          Icons.exit_to_app,
                          size: 30.0,
                          color: Colors.green,
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Padding(
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
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 35.0, vertical: 15.0),
                            prefixIcon: Material(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(23.0)),
                                child: GestureDetector(
                                  onTap: () {
                                    if (searchgroceryEditingController.text !=
                                        "") {
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
                ),
              ),
              searching
                  ? ListView(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      primary: false,
                      shrinkWrap: true,
                      children: tempSearchStore.map((element) {
                        return buildResultCard(element);
                      }).toList())
                  : Container(height: 450, child: orderSoon())
            ],
          ),
        ),
      ),
    );
  }

  Widget buildResultCard(data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(
                      quantity: data["Quantity"],
                      Name: data["Name"],
                      Detail: data["Detail"],
                      Image: data["imgUrl"],
                      Username: data["UserName"],
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
