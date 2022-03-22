import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'dart:ui';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:pinput/pin_put/pin_put_state.dart';

class Otpscreen extends StatefulWidget {
  final String phone;
  Otpscreen(this.phone);
  //Otpscreen({Key? key}) : super(key: key);

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  String _verificationCode = "";
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 60),
                child: Center(
                  child: Text(
                    "+213 ${widget.phone}",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: PinPut(
                  fieldsCount: 6,
                  textStyle: TextStyle(fontSize: 25),
                  eachFieldWidth: 40,
                  eachFieldHeight: 50,
                  focusNode: FocusNode(),
                  controller: TextEditingController(),
                  submittedFieldDecoration: pinPutDecoration,
                  selectedFieldDecoration: pinPutDecoration,
                  followingFieldDecoration: pinPutDecoration,
                  pinAnimationType: PinAnimationType.fade,
                  onSubmit: (pin) async {
                    await FirebaseAuth.instance.signInWithCredential(
                        PhoneAuthProvider.credential(
                            verificationId: _verificationCode, smsCode: pin));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _verifyOhone() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    /*   ConfirmationResult confirmationResult = await auth.signInWithPhoneNumber("+213 ${widget.phone}",RecaptchaVerifier(
  container: 'recaptcha',
  size: RecaptchaVerifierSize.compact,
  theme: RecaptchaVerifierTheme.dark,
));
    UserCredential userCredential = await confirmationResult.confirm('123456');*/
    await auth.verifyPhoneNumber(
      phoneNumber: '+213 ${widget.phone}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!

        // Sign the user in (or link) with the auto-generated credential
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }

        // Handle other errors
      },
      codeSent: (String verificationId, int? resendToken) async {
        // Update the UI - wait for the user to enter the SMS code
        String smsCode = 'xxxx';

        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);

        // Sign the user in (or link) with the credential
        await auth.signInWithCredential(credential);
      },
      timeout: const Duration(seconds: 120),
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
      // ConfirmationResult confirmationResult = await auth.signInWithPhoneNumber('+44 7123 123 456');
      //UserCredential userCredential = await confirmationResult.confirm('123456');
    );
    ConfirmationResult confirmationResult = await auth.signInWithPhoneNumber(
        "+213 ${widget.phone}",
        RecaptchaVerifier(
          container: 'recaptcha',
          size: RecaptchaVerifierSize.compact,
          theme: RecaptchaVerifierTheme.dark,
          onSuccess: () => print('reCAPTCHA Completed!'),
          onError: (FirebaseAuthException error) => print(error),
          onExpired: () => print('reCAPTCHA Expired!'),
        ));
    UserCredential userCredential = await confirmationResult.confirm('123456');
  }

  @override
  void initState() {
    super.initState();
    _verifyOhone();
  }
}
