import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Constants/constants.dart';
import 'Buttons/progree_indicating_button.dart';

class VerifyPhoneNumberBottomSheet extends StatefulWidget {
  @override
  _VerifyPhoneNumberBottomSheetState createState() =>
      _VerifyPhoneNumberBottomSheetState();
  final verifyButtonState;
  final String? phoneNumber;
  final User? currentUser;

  const VerifyPhoneNumberBottomSheet(
      {Key? key, this.verifyButtonState, this.phoneNumber, this.currentUser})
      : super(key: key);
}

class _VerifyPhoneNumberBottomSheetState
    extends State<VerifyPhoneNumberBottomSheet> {
  bool isCodeSent = false;
  String? smsCode;
  String? _verificationId;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("Verifying following phone Number: ${widget.phoneNumber}");
    }
    return Container(
      height: MediaQuery.of(context).size.height*.50,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Wrap(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Verify Phone Number',
                style: kTextStyleHeadline,
              ),
              const SizedBox(height: 30),
              isCodeSent
                  ? TextField(
                      onChanged: (value) {
                        smsCode = value;
                      },
                      decoration: const InputDecoration(
                        labelText: 'OTP',
                        border: OutlineInputBorder(),
                      ),
                    )
                  : const Text(
                      'We need to verify the phone number you provided by sending a verification code.\n\nWould you like to verify now?'),
              (errorMessage != null && errorMessage!.isNotEmpty)
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          errorMessage!,
                          style: const TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  : Container(),
              const SizedBox(height: 30),
              ProgressIndicatingButton(
                key: widget.verifyButtonState,
                title: 'Verify Now',
                onTap: () async {
                  widget.verifyButtonState.currentState.setProgressState();
                  if (!isCodeSent) {
                    //Code is not sent yet, we have to send the code first
                    FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: widget.phoneNumber!,
                        verificationCompleted:
                            (PhoneAuthCredential phoneAuthCredential) {
                          //ADDED BY HAIDER NAEEM
                          if (kDebugMode) {
                            print(
                              'Verification Completed: ${phoneAuthCredential.asMap()}');
                          }
                        },
                        verificationFailed: (FirebaseAuthException error) {
                          if (kDebugMode) {
                            print('Verification Failed: ${error.message}');
                          }
                          widget.verifyButtonState.currentState.setErrorState();
                          setState(() {
                            errorMessage = error.message;
                          });
                          var uid =
                              FirebaseAuth.instance.currentUser!.uid.toString();

                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(uid)
                              .update({
                            'is_phone_number_verified': false,
                          });
                        },
                        codeSent:
                            (String verificationId, int? forceResendingToken) {
                          _verificationId = verificationId;
                          widget.verifyButtonState.currentState.setDoneState();
                          Future.delayed(const Duration(milliseconds: 500), () {
                            setState(() {
                              isCodeSent = true;
                              widget.verifyButtonState.currentState
                                  .setNormalState();
                            });
                          });
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {
//                          widget.verifyButtonState.currentState.setDoneState();
                          if (kDebugMode) {
                            print('codeAutoRetrievalTimeout');
                          }
                        });
                  } else {
                    if (kDebugMode) {
                      print('Verification ID: $_verificationId');
                    }
                    var auth = PhoneAuthProvider.credential(
                        verificationId: _verificationId!, smsCode: smsCode!);

                    if (kDebugMode) {
                      print('Auth: $auth');
                    }

                    try {
                      await widget.currentUser!.updatePhoneNumber(auth);
                      var uid =
                          FirebaseAuth.instance.currentUser!.uid.toString();

                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .update({
                        'phone_number':widget.phoneNumber,
                        'is_phone_number_verified': true,
                      });
                      Navigator.pop(context);
                      widget.verifyButtonState.currentState.setDoneState();
                    } on FirebaseAuthException catch (e) {
                      if (kDebugMode) {
                        print('FirebaseAuthException was caught: ${e.message}');
                      }
                      if (kDebugMode) {
                        print('Verification Failed: ${e.message}');
                      }
                      widget.verifyButtonState.currentState.setErrorState();
                      setState(() {
                        errorMessage = e.message;
                      });
                    } catch (e) {
                      widget.verifyButtonState.currentState.setErrorState();
                      if (kDebugMode) {
                        print(
                          'Something went wrong with the update phone number: $e');
                      }
                    }
                  }
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
