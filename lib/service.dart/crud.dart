import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods {
  Future<void> addData(blogData, String id) async {
    FirebaseFirestore.instance
        .collection("Upload")
        .doc(id)
        .set(blogData)
        .catchError((e) {
      print(e);
    });
  }

  Future<void> addProduct(blogData, String id) async {
    FirebaseFirestore.instance
        .collection("AdminUpload")
        .doc(id)
        .set(blogData)
        .catchError((e) {
      print(e);
    });
  }
}
