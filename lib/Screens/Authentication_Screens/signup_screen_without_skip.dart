import 'package:bisell_olx_clone/Screens/Authentication_Screens/signup_with_phone_number_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Authentication/auth.dart';
import '../../Widgets/Buttons/rounded_filled_button.dart';
import '../../Widgets/Buttons/rounded_stroke_button.dart';
import '../landing_screen.dart';
import 'email_login_screen.dart';
class SignupScreenWithoutSkip extends StatefulWidget {
  const SignupScreenWithoutSkip({Key? key}) : super(key: key);

  @override
  _SignupScreenWithoutSkipState createState() => _SignupScreenWithoutSkipState();
}

class _SignupScreenWithoutSkipState extends State<SignupScreenWithoutSkip> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    Auth _auth = Auth();
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Stack(children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset("assets/images/main_bottom.png"),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset("assets/images/main_top.png"),
              ),
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8),
                        alignment: Alignment.centerRight,
                      ),
                    ],
                  ),
                  Container(
                    height: size.height * 0.20,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20, top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Welcome to'),
                        Text(
                          'Bisell',
                          style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'The trusted community of buyers and sellers',
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.55,
                    width: size.width * 0.70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundedStrokeButton(
                          label: 'Continue with Phone Number',
                          icon: const Icon(Icons.phone),
                          onClick: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const SignUpWithPhoneNumber()),
                            );
                          },
                        ),
                        RoundedStrokeButton(
                          label: 'Continue with Google',
                          image: SvgPicture.asset(
                            "assets/icons/google-plus.svg",
                          ),
                          onClick: () async {
                            try {
                              await _auth.googleAuth();
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (
                                      context) => const LandingPage()), (
                                      route) => false);
                            }
                            catch (e) {
                              if (kDebugMode) {
                                print(
                                    'PROBLEM IN GOOGLE SIGNIN. RUNNING CATCH BLOCK FROM SIGNUP SCREEN');
                              }
                            }
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const LandingPage()));
                            //TODO
                            //ADD THESE FUNCTIONS
                            // FirebaseAnalytics.instance
                            //     .logEvent(name: 'google_acc_created', parameters: {
                            //   'logged in': true,
                            // });
                            // final facebookAnalytics = FacebookAnalytics();
                            // facebookAnalytics.logEvent(
                            //   name: "google_acc_created",
                            // );
                          },
                        ),
                        RoundedStrokeButton(
                          label: 'Continue with Facebook',
                          image: SvgPicture.asset("assets/icons/facebook.svg"),
                          onClick: () async {
                            try {
                              await _auth.facebookAuth();
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (
                                      context) => const LandingPage()), (
                                      route) => false);
                            }
                            catch (e) {
                              if (kDebugMode) {
                                print('PROBLEM IN FACEBOOK LOGIN. RUNNING CATCH BLOCK FROM SIGNUP SCREEN');
                              }
                            }
                            //_singInWithFacebook(context);
                            // await FirebaseAnalytics.instance
                            //     .logEvent(name: 'fb_acc_created', parameters: {
                            //   'logged in': true,
                            // });
                            // final facebookAnalytics = FacebookAnalytics();
                            // facebookAnalytics.logEvent(
                            //   name: "fb_acc_created",
                            // );
                          },
                        ),
                        RoundedFilledButton(
                          label: 'Continue with Email',
                          icon: Icons.email,
                          onButtonClick: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const EmailPasswordLogin()));
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: size.height * 0.10,
                    alignment: Alignment.bottomCenter,
                    child: const Text(
                      'If you continue, you are accepting\nLoopez Terms and Privacy Policy',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ));
  }
}
