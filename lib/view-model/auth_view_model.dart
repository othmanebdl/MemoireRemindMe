import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/iam/v1.dart';
import 'package:testgoogle/screens/RemindMe-page1.dart';
import 'package:testgoogle/model/User_information.dart';
import 'package:testgoogle/view-model/service_firestore/FirestoreUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testgoogle/model/Homework_Lesson.dart';
import 'package:testgoogle/view-model/service_firestore/firestoreLessHomework.dart';

class Authviewmodel extends GetxController {
  String? id;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FirebaseAuth _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  late String nameuser;
  late String title;
  //late String typeTask;
  late int jour;
  late int mois;
  late int year;
  late int hour;
  late int minute;

  // DateTime dateTime = DateTime.now();
  //TimeOfDay time = TimeOfDay.now();
  Rxn<User> _user = Rxn<User>();

  //Userinfo infouser;
  // late Userinfo infouser;

  String? get user => _user.value?.email;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void SignIngoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.accessToken,
        accessToken: googleSignInAuthentication.accessToken);
    UserCredential userCredential =
        _auth.signInWithCredential(credential).then((usergoogle) async {
      Userinfo usergoogleAccount = Userinfo(
        userId: usergoogle.user?.uid,
        email: usergoogle.user?.email,
        name: nameuser == null ? usergoogle.user?.displayName : nameuser,
      );
      await FirestoreUser().addUserToFireStore(usergoogleAccount);
      print("user created");
    }) as UserCredential;
    Get.offAll(RemindMe1());
  }

  void SignInWithemailandoassword() async {
    // print("hello word");
    //Userinfo user;
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        //print(value.user?.uid);
        id = value.user?.uid;
        var usercurrent = _auth.currentUser!;
        // print(id);
        //Get.to(FirestoreLessondevoir(),arguments: id);
        //  userid.id = value.user?.uid;
      });

      Get.offAll(RemindMe1());
    } catch (errore) {
      Get.snackbar("Errore login account", errore.toString(),
          colorText: Colors.black, snackPosition: SnackPosition.BOTTOM);
    }
  }

  void Create_Account_WithEmailandPassword() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        Userinfo usermodel = Userinfo(
          userId: _auth.currentUser?.uid,
          email: user.user?.email,
          name: nameuser,
        );

        // userid.id =user.user?.uid;

        await FirestoreUser().addUserToFireStore(usermodel);
          Get.offAll(RemindMe1());
      });
    } catch (errore) {
      Get.snackbar("Errore Create account", errore.toString(),
          colorText: Color.fromARGB(255, 87, 78, 78),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void AddCour_Lesson(var typetask) async {
    // print("add task");
    final CollectionReference userCollectionRef =
        FirebaseFirestore.instance.collection("Homework_lessonUser");
    Homework_Lesson info = Homework_Lesson(
      homework_lessonuserId: _auth.currentUser?.uid,
      title: title,
      jour: jour,
      mois: mois,
      year: year,
      hour: hour,
      minute: minute,
      typetask :typetask
    );
    FirestoreLessondevoir().addCourToFireStore(info);
    //print(info.homework_lessonuserId);
    // FirestoreLessondevoir().filter();
    //userCollectionRef.add(info);
  }
}
