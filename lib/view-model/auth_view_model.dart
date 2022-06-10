import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/iam/v1.dart';
import 'package:testgoogle/Sign_Up.dart';
import 'package:testgoogle/screens/RemindMe-page1.dart';
import 'package:testgoogle/model/User_information.dart';

import 'package:testgoogle/view-model/service_firestore/FirestoreUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testgoogle/model/Homework_Lesson.dart';
import 'package:testgoogle/view-model/service_firestore/firestoreLessHomework.dart';

class Authviewmodel extends GetxController {
  String id;
  // creer instance  GoogleSignIn pour faire login par le compte google
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FirebaseAuth _auth = FirebaseAuth.instance;
  String email;
  String password;
  static String nameuser;
  String title;
  String desciption; // desceiption de la tache
  List<String> keytitle = []; // list pour les mots clés de tache
  //late String typeTask;
  int jour;
  int mois;
  int year;
  int hour;
  int minute;

  // DateTime dateTime = DateTime.now();
  //TimeOfDay time = TimeOfDay.now();
  Rxn<User> _user = Rxn<User>();

  //Userinfo infouser;
  // late Userinfo infouser;

  String get user => _user.value?.email;
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

  Future<dynamic> SignUpgoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.accessToken,
        accessToken: googleSignInAuthentication.accessToken);

    await _auth.signInWithCredential(credential).then((usergoogle) async {
      Userinfo usergoogleAccount = Userinfo(
        userId: "usergoogle.user!.uid",
        email: "usergoogle.user!.email",
        name: "nameuser == null ? usergoogle.user!.displayName : nameuser",
      );
      await FirestoreUser().addUserToFireStore(usergoogleAccount);
      print("user created");
    });
    Get.to(RemindMe1());
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    if (authResult.additionalUserInfo.isNewUser) {
      if (user != null) {
        Userinfo usergoogleAccount = Userinfo(
          userId: authResult.user.uid,
          email: authResult.user.email,
          name: authResult.user.displayName,
        );
        await FirestoreUser().addUserToFireStore(usergoogleAccount);

        Get.to(RemindMe1());
      }
    } else {
      Get.to(Sign_up());
      
      //await signInWithGoogle();
      Get.snackbar("Errore Create  account", "Compte Exist deja",
          colorText: Colors.black, snackPosition: SnackPosition.BOTTOM);
    }

    return await FirebaseAuth.instance.signInWithCredential(credential);
    // Once signed in, return the UserCredential
    /*return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((usergoogle) async {
    
      Userinfo usergoogleAccount = Userinfo(
        userId: usergoogle.user.uid,
        email: usergoogle.user.email,
        name: usergoogle.user.displayName,
      );
      await FirestoreUser().addUserToFireStore(usergoogleAccount);
      print("user created");

      Get.to(RemindMe1());
    }) as UserCredential;*/
  }

  void SignInWithemailandoassword() async {
  
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        //print(value.user?.uid);
        id = value.user?.uid;
        var usercurrent = _auth.currentUser;
       
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
        var usname = nameuser;
        
     

        await FirestoreUser().addUserToFireStore(usermodel);
        Get.offAll(RemindMe1(), arguments: usname);
      });
    } catch (errore) {
      Get.snackbar("Errore Create account", errore.toString(),
          colorText: Color.fromARGB(255, 87, 78, 78),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void AddLesson_HomeWork_Exam(var typetask) async {
    
    final CollectionReference userCollectionRef =
        FirebaseFirestore.instance.collection("Homework_lessonUser");
    Homework_Lesson info = Homework_Lesson(
        homework_lessonuserId: _auth.currentUser?.uid,
        description: desciption,
        title: title,
        jour: jour,
        mois: mois,
        year: year,
        hour: hour,
        minute: minute,
        typetask: typetask,
        keywordTitle: keytitle);
    FirestoreLessondevoir().addLesson_Homework_ExamToFireStore(info);
  }
}
