//import 'dart:ffi';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testgoogle/model/User_information.dart';

class FirestoreUser {
  //Creer une collection de nom "EtudiantUser" dans firestoreDatabase Firebase 
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection("EtudiantUser");
      

      
  Future<void> addUserToFireStore(Userinfo userinfo) async {
    
    return await _userCollectionRef.doc(userinfo.userId).set(userinfo.toJson());
  }
  
}
