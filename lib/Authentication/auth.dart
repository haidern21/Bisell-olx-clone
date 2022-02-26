import 'package:bisell_olx_clone/Constants/constants.dart';
import 'package:bisell_olx_clone/Models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Auth {
  final UserModel userModel = UserModel();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? userName;
  String? userId;
  String? userEmail;
  String? userProfileImage;

  Future googleAuth() async {
    late GoogleSignInAccount? googleSignIn;
    try {
      googleSignIn = await GoogleSignIn().signIn();
      GoogleSignInAuthentication googleSignInAuthentication;
      googleSignInAuthentication = await googleSignIn!.authentication;
      OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (FirebaseAuth.instance.currentUser != null) {
        userId = _firebaseAuth.currentUser!.uid;
        userName = _firebaseAuth.currentUser!.displayName;
        userEmail = _firebaseAuth.currentUser!.email;
        userProfileImage = _firebaseAuth.currentUser!.photoURL;
        userModel.uid = userId;
        userModel.userName = userName;
        userModel.emailAddress = userEmail;
        userModel.profileUrl = userProfileImage;
        userModel.isEmailVerified = true;
        bool docExist = await checkIfDocExists(userId!);
        if (docExist == false) {
          FirebaseFirestore.instance
              .collection(kUsers)
              .doc(userId)
              .set(userModel.asMap());
        }
      }
      if (kDebugMode) {
        print('USER CREDENTIALS FROM GOOGLE SIGN IN :$userCredential');
        print('USER MODEL AS MAP FROM GOOGLE SIGN IN IS :${userModel.asMap()}');
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Running catch block of Google sign in ');
        print('Problem occurred in google sign in function from Auth class');
        print('The problem is: ${e.message}');
      }
    }
  }

  Future facebookAuth() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      final OAuthCredential facebookCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(facebookCredential);
      if (FirebaseAuth.instance.currentUser != null) {
        userId = _firebaseAuth.currentUser!.uid;
        userName = _firebaseAuth.currentUser!.displayName;
        userEmail = _firebaseAuth.currentUser!.email;
        userProfileImage = _firebaseAuth.currentUser!.photoURL;
        userModel.uid = userId;
        userModel.userName = userName;
        userModel.emailAddress = userEmail;
        userModel.profileUrl = userProfileImage;
        userModel.isEmailVerified = true;
        bool docExist = await checkIfDocExists(userId!);
        if (docExist == false) {
          FirebaseFirestore.instance
              .collection(kUsers)
              .doc(userId)
              .set(userModel.asMap());
        }
      }
      if (kDebugMode) {
        print('USER CREDENTIALS FROM FACEBOOK SIGN IN :$userCredential');
        print(
            'USER MODEL AS MAP FROM FACEBOOK SIGN IN IS :${userModel.asMap()}');
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Running catch block of Facebook sign in ');
        print('Problem occurred in Facebook sign in function from Auth class');
        print('The problem is: ${e.message}');
      }
    }
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
