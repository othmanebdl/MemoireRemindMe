import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:testgoogle/Resetpassword.dart';
import 'package:testgoogle/main.dart';
import 'package:testgoogle/screens/RemindMe-page1.dart';
import 'package:testgoogle/view-model/auth_view_model.dart';
import 'package:testgoogle/view-model/service_firestore/FirestoreUser.dart';
import 'model/User_information.dart';

Authviewmodel controller = Authviewmodel();
String username;

class Sign_In extends StatefulWidget {
  const Sign_In({Key key}) : super(key: key);

  @override
  State<Sign_In> createState() => _Sign_InState();
}

class _Sign_InState extends State<Sign_In> {
  bool password_obscure_text = true; //for check if the password visible or no.
  var iconvisibilty = Icons.visibility; //create Icon visibility
  int count_password_obscure_text = 0;
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

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
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return    GestureDetector(
                 onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                  child: Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height,
                    maxWidth: MediaQuery.of(context).size.width),
                color: Colors.white,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 36, horizontal: 24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                      onTap: () {
                                        Get.offAll(Homepage());
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Color(0xff274472),
                                        size: 30,
                                      )),
                                ),
                                Text(
                                  "Sign In",
                                  style: TextStyle(color: Colors.black, fontSize: 46),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Sign in to Continue",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                  ),
                                )
                              ],
                            ),
                          )),
                      Expanded(
                        flex: 5,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0xff1f4690),
                           Color(0xff1f4690)
                            ], begin: Alignment.topLeft, end: Alignment.centerRight),
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    onChanged: (value) {
                                      controller.email =
                                          value; /* initialiser la valeur de variable email dans la class
                                                      Authviewmodel par la valeur qui saisir dans le TextFormField*/
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        hintText: "E-mail",
                                        prefixIcon: Icon(
                                          Icons.email,
                                          color: Colors.black,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        hintStyle: TextStyle(color: Colors.black),
                                        fillColor: Color(0xffDFE7F4)),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    obscureText: password_obscure_text,
                                    autofocus: false,
                                    maxLength: 8,
                                    onChanged: (value) {
                                      controller.password =
                                          value; /* initialiser la valeur de variable password dans la class
                                                      Authviewmodel par la valeur qui saisir dans le TextFormField*/
                                    },
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            iconvisibilty,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              count_password_obscure_text++;
                                              if (count_password_obscure_text % 2 ==
                                                  0) {
                                                iconvisibilty = Icons.visibility;
                                                password_obscure_text = true;
                                              } else {
                                                iconvisibilty = Icons.visibility_off;
                                                password_obscure_text = false;
                                              }
                                           
                                            });
                                          },
                                        ),
                                        hintText: "Password",
                                        prefixIcon: Icon(Icons.password_outlined,
                                            color: Colors.black),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        hintStyle: TextStyle(color: Colors.black),
                                        fillColor: Color(0xffDFE7F4)),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Get.to(ResetPassword());
                                      },
                                      child: Text("Forget password ?",style: TextStyle(color: Colors.white),)),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      elevation: 5,
                                      padding: EdgeInsets.fromLTRB(95, 20, 95, 20),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                    ),
                                    onPressed: () {
                                      controller
                                          .SignInWithemailandoassword(); //on appele la methode qui faire la login
                                    },
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontFamily: 'Raleway'),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      )
                    ]),
              ) /*Padding(
                  padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Sign up to Continue",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "User Name",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade900,
                          ),
                        ),
                      ),
                      TextFormField(
                        onChanged: (value) {
                          controller.nameuser = value;
                          username = value;
                        },
                        decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey),
                            fillColor: Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade900,
                          ),
                        ),
                      ),
                      TextFormField(
                        onChanged: (value) {
                          controller.email = value;
                          email = value;
                        },
                        decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey),
                            fillColor: Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade900,
                          ),
                        ),
                      ),
                      TextFormField(
                        obscureText: password_obscure_text,
                        autofocus: false,
                        maxLength: 8,
                        onChanged: (value) {
                          controller.password = value;
                          password = value;
                        },
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(iconvisibilty),
                              onPressed: () {
                                setState(() {
                                  count_password_obscure_text++;
                                  if (count_password_obscure_text % 2 == 0) {
                                     iconvisibilty = Icons.visibility;
                                    password_obscure_text = true;
                                  } else {
                                  iconvisibilty = Icons.visibility_off;
                                    password_obscure_text = false;
                                  }
                                  print(password_obscure_text);
                                });
                              },
                            ),
                            hintText: "***********",
                            hintStyle: TextStyle(color: Colors.grey),
                            fillColor: Colors.white),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          elevation: 5,
                          padding: EdgeInsets.fromLTRB(95, 20, 95, 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        onPressed: () {
                          //print(controller.nameuser);
              
                          try {
                            controller.Create_Account_WithEmailandPassword();
                          } catch (errore) {
                            Get.snackbar("Errore  zCreate Account", errore.toString(),
                                colorText: Colors.black,
                                backgroundColor: Colors.red,
                                snackPosition: SnackPosition.TOP);
                          }
                        },
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Raleway'),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(60, 20, 60, 20),
                        child: ElevatedButton(
                          onPressed: () async {
                            // _buttomsheetcreateaccount(context);
                            // UserCredential cred = await signInWithGoogle();
                            //Navigator.of(context).push(
                            //MaterialPageRoute(builder: (context) => RemindMe1()),
                            // );
                            // Get.to(RemindMe1());
                            await controller.signInWithGoogle();
              
                            //UserCredential usercred = await signInWithGoogle();
                            //
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                FontAwesomeIcons.google,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 18,
                              ),
                              Text(
                                "Sign With Google",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Raleway'),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            elevation: 5,
                            padding: EdgeInsets.fromLTRB(20, 20, 40, 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),*/
                  ),
            ),
          );
        }
      ),
    );
  }
}
