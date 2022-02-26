import 'package:bisell_olx_clone/Authentication/auth.dart';
import 'package:bisell_olx_clone/Screens/landing_screen.dart';
import 'package:bisell_olx_clone/Screens/location_page.dart';
import 'package:flutter/foundation.dart';
import '../../Constants/constants.dart';
import '../../Secure_Storage/secure_storage.dart';
import 'signup_with_phone_number_screen.dart';
import 'package:bisell_olx_clone/Widgets/Buttons/rounded_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:bisell_olx_clone/Widgets/Buttons/rounded_stroke_button.dart';
import 'package:flutter_svg/svg.dart';

import 'email_login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
    Size size = MediaQuery.of(context).size;
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
          InkWell(
              onTap: () async {
                await Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => cityName == kUnknownCity &&
                                stateName == kUnknownState
                            ? const LocationPage()
                            : const LandingPage()),
                    (route) => false);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(
                        height: 30,
                        width: 50,
                        child: Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.black,
                        )),
                    SizedBox(
                        height: 30,
                        width: 100,
                        child: Text(
                          'Skip Login',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        )),
                  ],
                ),
              )),
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
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      cityName == kUnknownCity &&
                                              stateName == kUnknownState
                                          ? const LocationPage()
                                          : const LandingPage()),
                              (route) => false);
                        } catch (e) {
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
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      cityName == kUnknownCity &&
                                              stateName == kUnknownState
                                          ? const LocationPage()
                                          : const LandingPage()),
                              (route) => false);
                        } catch (e) {
                          if (kDebugMode) {
                            print(
                                'PROBLEM IN FACEBOOK LOGIN. RUNNING CATCH BLOCK FROM SIGNUP SCREEN');
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
