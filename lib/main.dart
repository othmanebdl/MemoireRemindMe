// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'dart:ui';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinput/pin_put/pin_put_state.dart';
import 'package:testgoogle/Sign_Up.dart';
import 'package:testgoogle/Test.dart';
import 'package:get/get.dart';
import 'package:testgoogle/help/Biding.dart';
import 'package:testgoogle/help/Biding.dart';
import 'package:testgoogle/view-model/auth_view_model.dart';
import 'Otpsceen.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:testgoogle/screens/RemindMe-page1.dart';
import 'package:testgoogle/screens/RemindMe-page2.dart';
import 'package:testgoogle/screens/SplashScreen.dart';
import 'package:testgoogle/view-model/check_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(Memoirereminder());
}

/*class Google extends StatefulWidget {
  Google({Key? key}) : super(key: key);

  @override
  State<Google> createState() => _GoogleState();
}

class _GoogleState extends State<Google> {
  

  String uid = "";
  TextEditingController _controller = TextEditingController();
  Map? _userData;
  AccessToken? _accesToken;
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    onPressed: () async {
                      UserCredential cred = await signInWithGoogle();
                      print(cred);
                    },
                    child: Text("sign in with google"),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      final result = await FacebookAuth.i
                          .login(permissions: ["public_profile", "email"]);
                      if (result.status == LoginStatus.success) {
                        final requestData = await FacebookAuth.i.getUserData(
                          fields: "email,name",
                        );
                        setState(() {
                          _userData = requestData;
                        });
                      }
                    },
                    child: Text("sign in with facebook"),
                  ),
                  TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: ("enter your phone number  "),
                      prefix: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text("+213"),
                      ),
                    ),
                    controller: _controller,
                    maxLength: 10,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Otpscreen(_controller.text)));
                    },
                    color: Colors.blue,
                    textColor: Colors.black,
                    child: Text(
                      "Verification",
                      textAlign: TextAlign.center,
                    ),
                  ),
                 
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

}*/
class Memoirereminder extends GetWidget<Authviewmodel> {
  const Memoirereminder({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
 
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: GetMaterialApp(
        initialBinding: Binding(),
        debugShowCheckedModeBanner: false,
        home: Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: ControlleAuth(),
            ),
          );
        }),
      ),
    );
  }
}

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);
 
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
   
  }
  Authviewmodel controller = Authviewmodel();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String?> facebookSignin() async {
    try {
      final _instance = FacebookAuth.instance;
      final result = await _instance.login(permissions: ['email']);
      if (result.status == LoginStatus.success) {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        final a = await _auth.signInWithCredential(credential);
        await _instance.getUserData().then((userData) async {
          await _auth.currentUser!.updateEmail(userData['email']);
        });

        return null;
      } else if (result.status == LoginStatus.cancelled) {
        return 'Login cancelled';
      } else {
        return 'Error';
      }
    } catch (e) {
      return e.toString();
    }
  }

  String uid = "";
  TextEditingController _controller = TextEditingController();
  Map? _userData;
  AccessToken? _accesToken;
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  //final googleSignIn = GoogleSignIn();
  //GoogleSignInAccount? _user;
  //GoogleSignInAccount get user => _user!;

  //final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(
          flex: 6,
          child: Column(children: [
            Image.asset("images/reminder.png"),
            Text(
              "Welcome",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 28,
                  fontFamily: 'Raleway'),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Before enjoying Reminder Students Service , Please register first",
              style: TextStyle(
                color: Color(0xff4B5563),
                fontSize: 22,
                fontWeight: FontWeight.w300,
                fontFamily: 'Raleway',
              ),
              textAlign: TextAlign.center,
            ),
          ]),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Get.offAll(Sign_up());
                        },
                        child: Text("create Account")),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _buttomsheetlogin(context);
                          //Get.to(RemindMe1());
                          //controller.SignIngoogle();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        elevation: 5,
                        padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: Text(
                        "Create Acount",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                   
                  ],
                ),
              ),
            ],
          ),
        ),
    
        /*  RaisedButton(onPressed: (){
     Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignInDemo()),
                        );
            },
            child: Text("xx"),
            
            ),*/
      ]
          /* Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[100],
                    padding: EdgeInsets.symmetric(horizontal: 60),
                  ),
                ),
              ),*/
    
          ),
    );
  }

  void _buttomsheetlogin(context) {
    showModalBottomSheet(
        enableDrag: true,
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xff737373),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                ),
                color: Colors.white,
              ),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(40, 40, 40, 0),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xffdee8ec),
                        // border: Border.all(color: Color(0xff4B5563),),
                      ),
                      child: TextField(
                        cursorColor: Colors.grey,
                        onChanged: (value) {
                          //email = value;
                          controller.email = value;
                        },
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: Colors.red,
                          ),
                          hintText: "Email",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(40, 20, 40, 0),
                      padding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xffdee8ec),
                        border: Border.all(
                          color: Color(0xffdee8ec),
                        ),
                      ),
                      child: TextField(
                        cursorColor: Colors.grey,
                        onChanged: (value) {
                          //   password = value;
                          controller.password = value;
                        },
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.password,
                            color: Colors.red,
                          ),
                          hintText: "**********",
                          border: InputBorder.none,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                            },
                            child: Icon(Icons.visibility, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // print(email);
                        //print(password);
                        //  final new_user =
                        // await _auth.createUserWithEmailAndPassword(
                        //  email: email, password: password);
                        //Navigator.of(context).push(
                        //MaterialPageRoute(builder: (context) => RemindMe1()),

                        //);
                        controller.SignInWithemailandoassword();
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xffFC4F4F),
                        elevation: 5,
                        padding: EdgeInsets.symmetric(horizontal: 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                   
                    /* Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70),
                      child: ElevatedButton(
                        onPressed: () async {
                          UserCredential cred = await signInWithGoogle();
                        },
                        child: Row(
                          children: [
                            Image.asset("images/google.png"),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Login With Google",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          elevation: 5,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),*/

                    /* Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(100),
                          topRight: Radius.circular(100),
                          

                        ),
                        color: Color(0xffdee8ec),
                    ),
                    alignment: Alignment.center,
                  ),
                  


                ),*/
                  
                 
                 
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _buttomsheetcreateaccount(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              color: Color(0xff737373),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.circular(22),
                  ),
                  color: Colors.white,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(40, 40, 40, 0),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xffdee8ec),
                          // border: Border.all(color: Color(0xff4B5563),),
                        ),
                        child: TextField(
                          cursorColor: Colors.grey,
                          onChanged: (value) {
                            // username = value;
                          },
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.account_circle,
                              color: Colors.red,
                            ),
                            hintText: "Username",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(40, 40, 40, 0),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xffdee8ec),
                          // border: Border.all(color: Color(0xff4B5563),),
                        ),
                        child: TextField(
                          cursorColor: Colors.grey,
                          onChanged: (value) {
                            //  email = value;
                          },
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.email,
                              color: Colors.red,
                            ),
                            hintText: "Email",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(40, 20, 40, 0),
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xffdee8ec),
                          border: Border.all(
                            color: Color(0xffdee8ec),
                          ),
                        ),
                        child: TextField(
                          cursorColor: Colors.grey,
                          onChanged: (value) {
                            // password = value;
                          },
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.password,
                              color: Colors.red,
                            ),
                            hintText: "Password",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // print(email);
                          //print(password);
                          //  final new_user =
                          // await _auth.createUserWithEmailAndPassword(
                          //  email: email, password: password);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => RemindMe1()),
                          );
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffFC4F4F),
                          elevation: 5,
                          padding: EdgeInsets.symmetric(horizontal: 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.red[800],
                                  child: IconButton(
                                    icon: Icon(FontAwesomeIcons.google,
                                        color: Colors.white),
                                    onPressed: () async {
                                      UserCredential cred =
                                          await signInWithGoogle();
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => RemindMe1()),
                                      );
                                    },
                                  )),
                              CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.blue,
                                  child: IconButton(
                                    icon: Icon(FontAwesomeIcons.facebookF,
                                        color: Colors.white),
                                    onPressed: () async {
                                      facebookSignin();
                                    },
                                  )),
                              CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.green,
                                  child: IconButton(
                                    icon: Icon(FontAwesomeIcons.phoneAlt,
                                        color: Colors.white),
                                    onPressed: () {},
                                  )),
                            ],
                          )),
                      /* Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        child: ElevatedButton(
                          onPressed: () async {
                            UserCredential cred = await signInWithGoogle();
                          },
                          child: Row(
                            children: [
                              Image.asset("images/google.png"),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Login With Google",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            elevation: 5,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),*/

                      /* Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(100),
                            topRight: Radius.circular(100),
                            
          
                          ),
                          color: Color(0xffdee8ec),
                      ),
                      alignment: Alignment.center,
                    ),
                    
          
          
                  ),*/
                      ElevatedButton(
                        onPressed: () async {
                          facebookSignin();
                        },
                        child: Text("sign with facebook"),
                      ),
                      TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: ("enter your phone number  "),
                          prefix: Padding(
                            padding: EdgeInsets.all(4),
                            child: Text("+213"),
                          ),
                        ),
                        controller: _controller,
                        maxLength: 10,
                      ),
                      RaisedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  Otpscreen(_controller.text)));
                        },
                        color: Colors.blue,
                        textColor: Colors.black,
                        child: Text(
                          "Verification",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  /*Future googlelogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }
  }*/
}
