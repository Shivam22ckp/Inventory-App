import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory/service.dart/Database.dart';
import 'package:inventory/service.dart/shared_pref.dart';

class DetailPage extends StatefulWidget {
  String Name, Image, quantity, Detail, Username;
  DetailPage(
      {required this.Image,
      required this.Name,
      required this.quantity,
      required this.Detail,
      required this.Username});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late String userIdKey;
  getMyInfoFromSharedPreference() async {
    userIdKey = await SharedPreferenceHelper().getUserId();
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

  int number = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 40.0,
            ),
            Text(
              "Product Details",
              style: TextStyle(color: Colors.black, fontSize: 24.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: Container(
                height: 220,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  widget.Image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.Name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "by " + widget.Username,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 15.0, left: 15.0),
                  child: Text(
                    widget.Detail,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Only " + widget.quantity + " left in stock - order soon.",
                    style: TextStyle(color: Colors.green, fontSize: 22.0),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 40,
                      width: 130,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(width: 2.0, color: Colors.brown)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (number > 1) number = number - 1;
                              setState(() {});
                            },
                            child: Icon(
                              Icons.remove,
                              color: Colors.brown,
                              size: 24.0,
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            number.toString(),
                            style: TextStyle(color: Colors.brown, fontSize: 24),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              number = number + 1;
                              setState(() {});
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.brown,
                              size: 24.0,
                            ),
                          )
                        ],
                      ),
                    ),
                    // Text(
                    //   widget.price.toString() + " CHF",
                    //   style: TextStyle(
                    //       color: Colors.brown,
                    //       fontSize: 24.0,
                    //       fontWeight: FontWeight.bold),
                    // )
                    GestureDetector(
                      onTap: () {
                        Map<String, dynamic> userorderInfoMap = {
                          "Product": widget.Name,
                          "Quantity": number,
                          "Image": widget.Image,
                        };
                        DatabaseMethods()
                            .addUserAccount(userorderInfoMap, userIdKey);
                        Fluttertoast.showToast(
                            msg: "Order Placed Successfully!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      },
                      child: Container(
                        width: 130,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(16)),
                        padding: EdgeInsets.all(8),
                        child: Center(
                          child: Text(
                            "Buy",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
