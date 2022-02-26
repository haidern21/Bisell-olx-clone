import 'package:bisell_olx_clone/Models/user_model.dart';
import 'package:bisell_olx_clone/Screens/landing_screen.dart';
import 'package:bisell_olx_clone/Utils/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bisell_olx_clone/Widgets/Buttons/progree_indicating_button.dart';
import 'package:bisell_olx_clone/Constants/constants.dart';
import 'email_registration_screen.dart';
import 'forgot_password_screen.dart';

class EmailPasswordLogin extends StatefulWidget {
  static String name = '/emailLogin';

  const EmailPasswordLogin({Key? key}) : super(key: key);

  @override
  _EmailPasswordLogin createState() => _EmailPasswordLogin();
}

class _EmailPasswordLogin extends State<EmailPasswordLogin> {
  String? email;
  String? password;
  String generalErrorMessage = '';
  var formState = GlobalKey<FormState>();
  var responsiveButtonState = GlobalKey<ProgressIndicatingButtonState>();
  final UserModel userModel = UserModel();
  String? userId;
  String? userEmail;

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
                    'Welcome Back',
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
                        'Enter your Email and Password to Login',
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
                    key: formState,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Email Address',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)))),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            String emailValidationResponse =
                                isValidEmail(value);
                            if (emailValidationResponse != 'YES') {
                              return emailValidationResponse;
                            }
                            return null;
                          },
                          onSaved: (value) {
                            email = value;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password can\'t be null';
                            } else if (value.length < 6) {
                              return 'Password must be 6 digits long';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            password = value!.trim();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: _registerNewUserClicked,
                    child: Container(
                      alignment: Alignment.center,
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                                text: 'Need account? ',
                                style: TextStyle(color: Colors.black)),
                            TextSpan(
                              text: 'Register Now',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: InkWell(
                      onTap: () => _forgotPassword(context),
                      child: const Text(
                        'Forgot Password?',
                        style: kTextStyleClickable,
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
                key: responsiveButtonState,
                onTap: _loginUser,
                title: 'Log In',
              ),
            ],
          ),
        ),
      ),
    );
  }

  _forgotPassword(context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
    );
  }

  _registerNewUserClicked() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const EmailRegistrationScreen()));
  }

  _loginUser() {
    if (responsiveButtonState.currentState!.buttonState ==
            ButtonState.progress ||
        responsiveButtonState.currentState!.buttonState == ButtonState.done) {
      return;
    }

    if (formState.currentState!.validate()) {
      //Everything is valid
      formState.currentState!.save();
      if (kDebugMode) {
        print('We got email: $email and Password: $password');
      }
      _loginWithEmailAndPassword();
    }
  }

  _loginWithEmailAndPassword() async {
    responsiveButtonState.currentState!.setProgressState();
    var authInstance = FirebaseAuth.instance;

    try {
      await authInstance.signInWithEmailAndPassword(
          email: email!, password: password!);
      responsiveButtonState.currentState!.setDoneState();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LandingPage()),
          (route) => false);

    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      setState(() {
        generalErrorMessage = (e as FirebaseAuthException).message.toString();
        if (kDebugMode) {
          print(e);
        }
      });
      responsiveButtonState.currentState!.setNormalState();
    }

    return;
  }
}
