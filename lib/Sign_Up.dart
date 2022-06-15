
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testgoogle/main.dart';
import 'package:testgoogle/view-model/auth_view_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


Authviewmodel controller = Authviewmodel();
String username;

class Sign_up extends StatefulWidget {
  const Sign_up({Key key}) : super(key: key);

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  String nameuser; //le nom de l'utilisateur
  String email;//l'email de l'utilisateur
  String password;//le mot de pass de l'utlisateur
  bool password_obscure_text = true; // 
  var iconvisibilty = Icons.visibility;
  int count_password_obscure_text = 0;//Pour voir si le mot de passe apparaît ou non
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(builder: (context) {
        return GestureDetector(
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
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff1f4690), Color(0xff1f4690)],
                    begin: Alignment.topLeft,
                    end: Alignment.centerRight),
              ),
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
                                      Get.to(Homepage());//Pour revenir à la page d'accueil
                                    },
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 30,
                                    )),
                              ),
                              Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 46),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Sign up to Continue",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              )
                            ],
                          ),
                        )),
                    Expanded(
                      flex: 5,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
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
                                TextFormField(
                                  onChanged: (value) {
                                  /* affecter la valeur entrer par l'utilisateur dans variable
                                  name user
                                  */
                                    Authviewmodel.nameuser = value;
                                    username = value;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "User Name",
                                      prefixIcon: Icon(Icons.face_outlined),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      hintStyle: TextStyle(color: Colors.grey),
                                      fillColor: Color(0xffDFE7F4)),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                       /* affecter la valeur entrer par l'utilisateur dans variable
                                  email
                                  */
                                    controller.email = value;
                                    email = value;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      hintText: "E-mail",
                                      prefixIcon: Icon(Icons.email),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      hintStyle: TextStyle(color: Colors.grey),
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
                                     /* affecter la valeur entrer par l'utilisateur dans variable
                                  password
                                  */
                                    controller.password = value;
                                    password = value;
                                  },
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(iconvisibilty),
                                        onPressed: () {
                                          setState(() {
                                            //pour changer icon de visibiliti mot de pass
                                            count_password_obscure_text++;
                                            if (count_password_obscure_text %
                                                    2 ==
                                                0) {
                                              iconvisibilty = Icons.visibility;
                                              password_obscure_text = true;
                                            } else {
                                              iconvisibilty =
                                                  Icons.visibility_off;
                                              password_obscure_text = false;
                                            }
                                          });
                                        },
                                      ),
                                      hintText: "Password",
                                      prefixIcon: Icon(Icons.password_outlined),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      hintStyle: TextStyle(color: Colors.grey),
                                      fillColor: Color(0xffDFE7F4)),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xff1f4690),
                                    elevation: 5,
                                    padding:
                                        EdgeInsets.fromLTRB(95, 20, 95, 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                  ),
                                  onPressed: () {
                                    

                                    // on appele la methode qui creer compte de l'utilisateur
                                    controller
                                        .Create_Account_WithEmailandPassword();
                                  },
                                  child: Text(
                                    "SignUp",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'Raleway'),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                   
                                      await controller
                                          .signInWithGoogle(); /*on appele la methode qui faire login
                                                                par le compte google*/

                              
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.google,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 10,
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
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 40, 20),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                    ),
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
      }),
    );
  }
}
