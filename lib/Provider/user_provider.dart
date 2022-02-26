import 'package:bisell_olx_clone/Constants/constants.dart';
import 'package:bisell_olx_clone/Models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
class UserProvider extends ChangeNotifier{
  final List<UserModel> _userData=[];
  UserModel user=UserModel();
  List<UserModel> allUsers=[];
  UserModel get getUser{
    return user;
  }
  getUserData()async {
    UserModel userModel=UserModel();
    if (FirebaseAuth.instance.currentUser != null) {
      _userData.clear();
      String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userValue = await FirebaseFirestore.instance.collection(
          kUsers).doc(userId).get();
      userModel.emailAddress = userValue.get(kEmailAddress);
      userModel.userName = userValue.get(kUserName);
      userModel.uid = userValue.get(kUid);
      userModel.profileUrl = userValue.get(kProfilePicUrl);
      userModel.somethingAboutYou = userValue.get(kSomethingAboutYou);
      userModel.isPhoneNumberVerified = userValue.get(kIsPhoneNumberVerified);
      userModel.phoneNumber = userValue.get(kPhoneNumber);
      userModel.isEmailVerified = userValue.get(kIsEmailVerified);
      _userData.add(userModel);
      user = _userData.first;
      notifyListeners();
    }
  }
  getAllUsers()async{
    UserModel userModel=UserModel();
    QuerySnapshot value=await FirebaseFirestore.instance.collection(kUsers).get();
    List<UserModel> tempAllUsers=[];
    for(var element in value.docs){
      userModel.emailAddress = element.get(kEmailAddress);
      userModel.userName = element.get(kUserName);
      userModel.uid = element.get(kUid);
      userModel.profileUrl = element.get(kProfilePicUrl);
      userModel.somethingAboutYou = element.get(kSomethingAboutYou);
      userModel.isPhoneNumberVerified = element.get(kIsPhoneNumberVerified);
      userModel.phoneNumber = element.get(kPhoneNumber);
      userModel.isEmailVerified = element.get(kIsEmailVerified);
      tempAllUsers.add(userModel);
    }
    allUsers=tempAllUsers;
    notifyListeners();
  }
}