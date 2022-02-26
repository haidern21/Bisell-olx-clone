import 'package:bisell_olx_clone/Models/user_model.dart';
import 'package:bisell_olx_clone/Screens/landing_screen.dart';
import 'package:bisell_olx_clone/Utils/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bisell_olx_clone/Widgets/Buttons/progree_indicating_button.dart';

import 'package:bisell_olx_clone/Constants/constants.dart';

import '../../Secure_Storage/secure_storage.dart';
import '../location_page.dart';

class EmailRegistrationScreen extends StatefulWidget {
  static String name = '/emailRegistration';

  const EmailRegistrationScreen({Key? key}) : super(key: key);

  @override
  _EmailRegistrationScreenState createState() =>
      _EmailRegistrationScreenState();
}

class _EmailRegistrationScreenState extends State<EmailRegistrationScreen> {
  var formKey = GlobalKey<FormState>();
  var passwordFieldController = TextEditingController();

  String? email;
  String? password;
  final UserModel userModel = UserModel();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? userId;
  String? userEmail;
  String generalErrorMessage = '';
  var progressIndicatingButtonKey = GlobalKey<ProgressIndicatingButtonState>();
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text('< Back'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome',
                    style: kTextStyleHeadline,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                        ),
                      ),
                      Text(
                        'Enter your Email and Password to register',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            String emailValidationResponse =
                                isValidEmail(value);
                            if (emailValidationResponse != 'YES') {
                              return emailValidationResponse;
                            }
                            return null;
                          },
                          onSaved: (value) => email = value,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: passwordFieldController,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password can\'t be empty';
                            }

                            if (value.length < 6) {
                              return 'Password must be 6 character long';
                            }

                            return null;
                          },
                          onSaved: (value) => password = value,
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Repeat Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (passwordFieldController.text != value) {
                              return 'Repeat Password doesn\'t match';
                            }
                            return null;
                          },
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: _loginExistingUserClicked,
                    child: Container(
                      alignment: Alignment.center,
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                                text: 'Already have account? ',
                                style: TextStyle(color: Colors.black)),
                            TextSpan(
                              text: 'Login Now',
                              style: kTextStyleClickable,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(generalErrorMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red)),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
              ProgressIndicatingButton(
                  title: 'Register',
                  onTap: _registerUser,
                  key: progressIndicatingButtonKey
                  // inProgress: buttonInProgress,
                  ),
            ],
          ),
        ),
      ),
    );
  }

  _loginExistingUserClicked() {
    Navigator.pop(context);
  }

  _registerUser() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      _registerWithEmailAndPassword(email: email!, password: password!);
    }
  }

  _registerWithEmailAndPassword({String? email, String? password}) async {
    progressIndicatingButtonKey.currentState!.setProgressState();

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      if (FirebaseAuth.instance.currentUser != null) {
        userId = _firebaseAuth.currentUser!.uid;
        userEmail = _firebaseAuth.currentUser!.email;
        userModel.uid = userId;
        userModel.emailAddress = userEmail;
        bool docExist = await checkIfDocExists(userId!);
        if (docExist == false) {
          FirebaseFirestore.instance
              .collection(kUsers)
              .doc(userId)
              .set(userModel.asMap());
        }
      }
      progressIndicatingButtonKey.currentState!.setDoneState();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  cityName == kUnknownCity && stateName == kUnknownState
                      ? const LocationPage()
                      : const LandingPage()),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Firebase Auth exception: ${e.message}');
      }
      setState(() {
        generalErrorMessage = e.message!;
        progressIndicatingButtonKey.currentState!.setErrorState();
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      setState(() {
        generalErrorMessage = e.toString();
        if (kDebugMode) {
          print(e);
        }
        progressIndicatingButtonKey.currentState!.setErrorState();
      });
    }

    return;
  }

  /// Check If Document Exists
  Future<bool> checkIfDocExists(String docId) async {
    try {
      var collectionRef = FirebaseFirestore.instance.collection('users');

      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      rethrow;
    }
  }
}
