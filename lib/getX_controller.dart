import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MyController extends GetxController
{
  RxBool isSearching=false.obs;
  RxBool haveSearchedUser=false.obs;
  FirebaseFirestore _firebaseFirestore=FirebaseFirestore.instance;
  List<String> userDetails=[];
  Future getUserFromFireCloud(String username) async
  {
    CollectionReference collection = _firebaseFirestore.collection('Users');
    collection.snapshots().listen((event) async
    {
      for (var doc in event.docs)
      {
        print(doc.data());
        var requiredName=doc.data()['username'];
        if(requiredName==username)
          {
            userDetails.add(doc.id);
            userDetails.add(doc.data()['username']);
            userDetails.add(doc.data()['email']);
          }
      }
      print(userDetails);
    });
    return userDetails;
  }
  Future displayUsers(String username) async
  {
  }
}