
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testgoogle/Sign_inPage.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({Key key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final auth = FirebaseAuth.instance;
  String email;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                                  Get.to(Sign_In());//Pour revenir à la page de login
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Color(0xff3a5ba0),
                                  size: 30,
                                )),
                          ),
                          SizedBox(
                            height: 19,
                          ),
                          Text(
                            "Reset Password",
                            style: TextStyle(color: Colors.black, fontSize: 46),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Enter Your E-mail",
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
                      gradient: LinearGradient(
                          colors: [Color(0xff1f4690), Color(0xff1f4690)],
                          begin: Alignment.topLeft,
                          end: Alignment.centerRight),
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
                                email = value;
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
                                  fillColor: Colors.white),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 20,
                            ),
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
                                if (email != null && email != "") {
                                  /*pour envoyer a l'utulisateur un lien dans l'email pour récupirer 
                                  le mot de pass
                                  */
                                  auth.sendPasswordResetEmail(email: email);
                                  Get.to(Sign_In());
                                } else {
                                  Get.snackbar(
                                      "Errore Resset Password", "Email Empty",
                                      colorText:
                                          Colors.white,
                                      backgroundColor:
                                          Color(0xffffa500),
                                      snackPosition: SnackPosition.BOTTOM,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      isDismissible: true,
                                      borderRadius: 20,
                                      icon: Icon(
                                        Icons.error,
                                        color: Colors.white,
                                      ));
                                }
                              },
                              child: Text(
                                "Send Request",
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
        )),
      ),
    );
  }
}
