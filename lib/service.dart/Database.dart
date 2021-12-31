import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<Stream<QuerySnapshot>> getProducts() async {
    return FirebaseFirestore.instance.collection("Posts").snapshots();
  }

  Future addUserDetail(Map<String, dynamic> userInfoMap, String date) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(date)
        .set(userInfoMap);
  }

  Future<QuerySnapshot> Search(String date) async {
    return await FirebaseFirestore.instance
        .collection("Posts")
        .where("Key", isEqualTo: date.substring(0, 1).toUpperCase())
        .get();
  }

  Future addPosts(Map<String, dynamic> userInfoMap, String id) async {
    await FirebaseFirestore.instance
        .collection("Posts")
        .doc(id)
        .set(userInfoMap);
  }

  Future addApproved(Map<String, dynamic> userInfoMap) async {
    await FirebaseFirestore.instance.collection("Approved").add(userInfoMap);
  }

  updateLastMessageSend(String date, Map<String, dynamic> lastMessageInfoMap) {
    return FirebaseFirestore.instance
        .collection("Posts")
        .doc(date)
        .update(lastMessageInfoMap);
  }

  Future removePosts(Map<String, dynamic> userInfoMap) async {
    await FirebaseFirestore.instance.collection("Remove").add(userInfoMap);
  }

  Future addUserProducts(Map<String, dynamic> userInfoMap, String date) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(date)
        .collection("Products")
        .add(userInfoMap);
  }

  Future addAdminUpload(Map<String, dynamic> userInfoMap) async {
    await FirebaseFirestore.instance.collection("Upload").add(userInfoMap);
  }

  Future addUserAccount(Map<String, dynamic> userInfoMap, String date) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(date)
        .collection("Orders")
        .add(userInfoMap);
  }

  Future addEdit(Map<String, dynamic> userInfoMap) async {
    await FirebaseFirestore.instance.collection("Edit").add(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getOrders(String date) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(date)
        .collection("Orders")
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getAdminApproved() async {
    return FirebaseFirestore.instance.collection("Approved").snapshots();
  }

  Future<Stream<QuerySnapshot>> getUpload() async {
    return FirebaseFirestore.instance.collection("Upload").snapshots();
  }

  Future<Stream<QuerySnapshot>> getRemoved() async {
    return FirebaseFirestore.instance.collection("Remove").snapshots();
  }

  Future<Stream<QuerySnapshot>> getAdminProduct() async {
    return FirebaseFirestore.instance.collection("AdminUpload").snapshots();
  }

  Future<Stream<QuerySnapshot>> getAdminEdit() async {
    return FirebaseFirestore.instance.collection("Edit").snapshots();
  }

  Future<Stream<QuerySnapshot>> getAdminUsers() async {
    return FirebaseFirestore.instance.collection("users").snapshots();
  }
}
