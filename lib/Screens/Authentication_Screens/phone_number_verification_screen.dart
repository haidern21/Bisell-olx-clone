import 'package:bisell_olx_clone/Models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bisell_olx_clone/Widgets/Buttons/progree_indicating_button.dart';
import 'package:bisell_olx_clone/Constants/constants.dart';

import '../../Secure_Storage/secure_storage.dart';
import '../landing_screen.dart';
import '../location_page.dart';

class PhoneNumberVerification extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const PhoneNumberVerification(
      {Key? key, required this.verificationId, required this.phoneNumber})
      : super(key: key);

  @override
  _PhoneNumberVerificationState createState() =>
      _PhoneNumberVerificationState();
}

class _PhoneNumberVerificationState extends State<PhoneNumberVerification> {
  final _focusNode = FocusNode();
  var _strokeColor = Colors.black;
  var _smsCode = '';
  var responsiveButtonState = GlobalKey<ProgressIndicatingButtonState>();
  bool _isInProgress = false;
  final UserModel userModel = UserModel();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? userId;
  String? userEmail;
  LocationStorage locationStorage = LocationStorage();
  String cityName = kUnknownCity;
  String stateName = kUnknownState;

  Future getLocation() async {
    String tempCity =
        await locationStorage.getLocation('user_city') ?? kUnknownCity;
    String tempState =
        await locationStorage.getLocation('user_state') ?? kUnknownState;
    if (tempCity.isEmpty || tempState.isEmpty) {
      tempCity = kUnknownCity;
      tempState = kUnknownState;
    }
    if (cityName.isNotEmpty && stateName.isNotEmpty) {
      setState(() {
        cityName = tempCity;
        stateName = tempState;
      });
    }
  }
  @override
  void initState() {
    getLocation();
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(
          () {
            _strokeColor = Colors.blue;
          },
        );
      } else {
        setState(() {
          _strokeColor = Colors.black;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          if (kDebugMode) {
            print('Somewhere else clicked');
          }
        },
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                }, // Handle your callback
                child: Ink(
                  height: 50,
                  width: 70,
                  child: const Center(child: Text('< Back')),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome',
                      style: kTextStyleHeadline,
                    ),
                    const Text('We have sent a 6-digit code at ***********'),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        border: Border.all(color: _strokeColor),
                      ),
                      child: TextField(
                        style: const TextStyle(letterSpacing: 50),
                        maxLength: 6,
                        onChanged: (value) {
                          _smsCode = value;
                        },
                        focusNode: _focusNode,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterStyle: TextStyle(
                            height: double.minPositive,
                          ),
                          counterText: "",
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ProgressIndicatingButton(
                  key: responsiveButtonState,
                  onTap: _verifyCode,
                  title: 'Next',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Check If Document Exists
  Future<bool> checkIfDocExists(String docId) async {
    try {
      // Get reference to Firestore collection
      var collectionRef = FirebaseFirestore.instance.collection('users');

      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      rethrow;
    }
  }

  void _verifyCode() async {
    setState(() {
      _isInProgress = true;
    });
    responsiveButtonState.currentState!.setProgressState();
    await FirebaseAuth.instance.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: widget.verificationId, smsCode: _smsCode));
    responsiveButtonState.currentState!.setNormalState();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>
        cityName == kUnknownCity &&
            stateName == kUnknownState
            ? const LocationPage()
            : const LandingPage()),
        (route) => false);
    if (FirebaseAuth.instance.currentUser != null) {
      userId = _firebaseAuth.currentUser!.uid;
      userModel.uid = userId;
      userModel.phoneNumber = widget.phoneNumber;
      userModel.isPhoneNumberVerified = true;
      bool docExist = await checkIfDocExists(userId!);
      if (docExist == false) {
        FirebaseFirestore.instance
            .collection(kUsers)
            .doc(userId)
            .set(userModel.asMap());
      }
    }
  }
}
