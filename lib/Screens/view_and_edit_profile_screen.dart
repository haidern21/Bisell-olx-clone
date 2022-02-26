import 'dart:io';
import 'package:bisell_olx_clone/Constants/constants.dart';
import 'package:bisell_olx_clone/Models/user_model.dart';
import 'package:bisell_olx_clone/Provider/user_provider.dart';
import 'package:bisell_olx_clone/Screens/Authentication_Screens/signup_screen.dart';
import 'package:bisell_olx_clone/Widgets/Buttons/responsive_button.dart';
import 'package:bisell_olx_clone/Widgets/verify_phone_number_bottom_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../Widgets/Buttons/progree_indicating_button.dart';

class ViewAndEditProfileScreen extends StatefulWidget {
  const ViewAndEditProfileScreen({Key? key}) : super(key: key);

  @override
  _ViewAndEditProfileScreenState createState() =>
      _ViewAndEditProfileScreenState();
}

class _ViewAndEditProfileScreenState extends State<ViewAndEditProfileScreen> {
  String? userName;
  String? userEmail;
  String? userBio;
  String? userPhone;
  String? userProfilePic;
  String? newUserName;
  String? newUserEmail;
  String? newUserBio;
  String? newUserPhone;
  // String? tempImage1 = '';
  File? image1;
  String? downLoadLink;
  var saveButtonState = GlobalKey<ResponsiveButtonState>();
  bool enableSaveButton = true;
  TextEditingController userBioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  String currentUser = FirebaseAuth.instance.currentUser!.uid.toString();
  UserModel userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {}
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();
    userName = userProvider.user.userName;
    userEmail = userProvider.user.emailAddress;
    userBio = userProvider.user.somethingAboutYou;
    userPhone = userProvider.user.phoneNumber;
    userProfilePic = userProvider.user.profileUrl;
    bool? isEmailVerified = userProvider.user.isEmailVerified ?? false;
    bool isPhoneNumberVerified =
        userProvider.user.isPhoneNumberVerified ?? false;
    nameController = TextEditingController(text: userName);
    // nameController.text = userName.toString();
    return FirebaseAuth.instance.currentUser != null
        ? Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding:
              const EdgeInsets.only(top: 10.0, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Basic Information',
                    style: TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          var picker = await ImagePicker()
                              .getImage(source: ImageSource.gallery,imageQuality: 20);
                          setState(() {
                            image1 = File(picker!.path);
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.blue.shade100,
                          radius: 50,
                          child: userProfilePic == null
                              ? Image.asset('assets/user/man.png')
                              : ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: image1 == null
                                ? Image.network(
                              userProfilePic!,
                              fit: BoxFit.cover,
                            )
                                : Image.file(
                              image1!,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Name'),
                              TextFormField(
                                initialValue: userName,
                                onChanged: (value) {
                                  setState(() {
                                    newUserName = value;
                                  });
                                  if (kDebugMode) {
                                    print(userName);
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: userBio,
                    onChanged: (value) {
                      setState(() {
                        newUserBio = value;
                      });
                      if (kDebugMode) {
                        print(userBio);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Basic Information',
                    style: TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w900),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.2,
                        child: TextFormField(
                          initialValue: '+92',
                          keyboardType: TextInputType.phone,
                          maxLength: 3,
                          enabled: false,
                          decoration: const InputDecoration(
                            labelText: 'Country',
                            counterStyle: TextStyle(
                              height: double.minPositive,
                            ),
                            counterText: "",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: isPhoneNumberVerified == true
                            ? MediaQuery
                            .of(context)
                            .size
                            .width * 0.70
                            : (MediaQuery
                            .of(context)
                            .size
                            .width * 0.55) -
                            32,
                        child: TextFormField(
                          initialValue: userPhone,
                          keyboardType: TextInputType.phone,
                          enabled: isPhoneNumberVerified == false
                              ? true
                              : false,
                          onChanged: (value) {
                            setState(() {
                              newUserPhone = value;
                              if (kDebugMode) {
                                print(userPhone);
                              }
                            });
                          },
                          maxLength: 10,
                          decoration: const InputDecoration(
                            // labelText: 'Phone Number',
                            counterStyle: TextStyle(
                              height: double.minPositive,
                            ),
                            counterText: "",
                          ),
                        ),
                      ),
                      isPhoneNumberVerified == false
                          ? InkWell(
                        onTap: () {
                          _verifyPhoneNumberClicked(context);
                        },
                        //edited by haidder
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width *
                              0.15,
                          alignment: Alignment.center,
                          child: const Text(
                            'Verify\nNow',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                          : Container(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        // width: (!currentUser.emailVerified)
                        //      ?
                        width: MediaQuery
                            .of(context)
                            .size
                            .width - 32,
                        // : MediaQuery.of(context).size.width - 32,
                        child: TextFormField(
                          initialValue: userEmail,
                          enabled: isEmailVerified == true ? false : true,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            setState(() {
                              newUserEmail = value;
                              if (kDebugMode) {
                                print(userPhone);
                              }
                            });
                          },
                          decoration: InputDecoration(
                            // labelText: 'Email Address',
                            hintText: isEmailVerified
                                ? userEmail
                                : 'Email Address',
                            counterStyle: const TextStyle(
                              height: double.minPositive,
                            ),
                            counterText: "",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ResponsiveButton(
                    key: saveButtonState,
                    label: 'Save',
                    onTap: () async {
                      Map<String, dynamic> data = {
                        kUserName: newUserName,
                        kSomethingAboutYou: newUserBio,
                        kPhoneNumber: newUserPhone,
                      };
                      if(image1!=null){
                        await uploadProfileImage();
                      }
                      userModel.userName = newUserName ?? userName;
                      userModel.isPhoneNumberVerified =
                          isPhoneNumberVerified;
                      userModel.phoneNumber = newUserPhone != null
                          ? '+92' + newUserPhone!
                          : userPhone;
                      userModel.isEmailVerified = isEmailVerified;
                      userModel.emailAddress = newUserEmail ?? userEmail;
                      userModel.somethingAboutYou = newUserBio ?? userBio;
                      userModel.profileUrl = downLoadLink ?? userProfilePic;
                      userModel.uid = currentUser;
                      userModel.fcmToken = null;

                      await FirebaseFirestore.instance
                          .collection(kUsers)
                          .doc(currentUser)
                          .set(userModel.asMap());
                      if (kDebugMode) {
                        print(data);
                      }
                      userProvider.getUserData();
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Data Updated!!!')));
                    },
                    enabled: enableSaveButton,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ResponsiveButton(
                    label: 'Logout',
                    enabled: true,
                    onTap: () async {
                      FirebaseAuth.instance.signOut();
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              const SignupScreen()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    )
        : const SignupScreen();
  }

  _verifyPhoneNumberClicked(BuildContext context) async {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        var verifyButtonState = GlobalKey<ProgressIndicatingButtonState>();
        //edited by haider
        return VerifyPhoneNumberBottomSheet(
          verifyButtonState: verifyButtonState,
          phoneNumber: userPhone!,
          currentUser: FirebaseAuth.instance.currentUser,
        );
        // else {
        //   return null;
        // }
      },
    );
  }

  uploadProfileImage() async {
    try {
      if (image1 == null) {}
      if (image1 != null) {
        var reference1 =
        FirebaseStorage.instance.ref('$kAdImagesBucket/profile-pictures/${FirebaseAuth.instance.currentUser!.uid.toString()}/$image1');
        await reference1.putFile(image1!);
        String download1 = await reference1.getDownloadURL();
        setState(() {
          downLoadLink=download1;
        });
        if (kDebugMode) {
          print('Image1 DOWNLOAD URL:$download1');
        }
      }
    }
    on FirebaseException catch (e) {
      if (kDebugMode) {
        print(
            'RUNNING CATCH BLOCK OF UPLOAD PROFILE IMAGE FROM VIEW AND EDIT SCREEN :${e
                .message}');
      }
    }
  }
}
