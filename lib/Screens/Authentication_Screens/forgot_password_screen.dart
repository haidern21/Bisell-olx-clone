import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bisell_olx_clone/Widgets/bottomsheets/InformativeBottomSheet.dart';
import 'package:bisell_olx_clone/Widgets/Buttons/progree_indicating_button.dart';
import 'package:bisell_olx_clone/Widgets/rounded_stroke_textfield.dart';
import 'package:bisell_olx_clone/Constants/constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String emailErrorMessage = "";
  String email = "";
  var responsiveButtonStateKey = GlobalKey<ProgressIndicatingButtonState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _backClicked,
                child: const Text(
                  "< Back",
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Forgot Password",
                    style: kTextStyleHeadline,
                  ),
                  kSizedBoxHeight10,
                  kSizedBoxHeight10,
                  const Text(
                    'Please enter your email address below to reset your password.',
                    textAlign: TextAlign.left,
                  ),
                  kSizedBoxHeight10,
                  kSizedBoxHeight10,
                  RoundedStrokeTextField(
                    errorText: emailErrorMessage,
                    onChanged: (value) {
                      email = value;
                      if (kDebugMode) {
                        print('on Changed was called: $email');
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    hintText: 'Email Address',
                  ),
                ],
              ),
              ProgressIndicatingButton(
                title: "Send reset email",
                key: responsiveButtonStateKey,
                onTap: _sendEmailClicked,
              )
            ],
          ),
        ),
      ),
    );
  }

  _sendEmailClicked() async {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (_) {
          return InformativeBottomSheet(
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            information:
                "A reset email has been send to your email address. Please open that and follow instructions.",
          );
        });
    return;
  }

  void _backClicked() {
    Navigator.pop(context);
  }
}
