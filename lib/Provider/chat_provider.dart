import 'package:bisell_olx_clone/Models/message_model.dart';
import 'package:bisell_olx_clone/Models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Constants/constants.dart';

class ChatProvider extends ChangeNotifier {
  List<UserModel> allChatUsers = [];
  List<MessageModel> messages = [];

  getAllChatUsers() async {
    // if (FirebaseAuth.instance.currentUser != null) {
    //   final String currentUserId =
    //       FirebaseAuth.instance.currentUser!.uid.toString();
    //   List<UserModel> tempAllChatUsers = [];
    //   QuerySnapshot value =
    //       await FirebaseFirestore.instance.collection('chats').get();
    //   for (var element in value.docs) {
    //     if (element.get('sent_by') == currentUserId) {
    //       DocumentSnapshot userValue = await FirebaseFirestore.instance
    //           .collection(kUsers)
    //           .doc(element.get('received_by'))
    //           .get();
    //       UserModel userModel = UserModel(
    //         emailAddress: userValue.get(kEmailAddress),
    //         userName: userValue.get(kUserName),
    //         uid: userValue.get(kUid),
    //         profileUrl: userValue.get(kProfilePicUrl),
    //         somethingAboutYou: userValue.get(kSomethingAboutYou),
    //         isPhoneNumberVerified: userValue.get(kIsPhoneNumberVerified),
    //         phoneNumber: userValue.get(kPhoneNumber),
    //         isEmailVerified: userValue.get(kIsEmailVerified),
    //       );
    //       for (var i in tempAllChatUsers) {
    //         if (i.uid == element.get('received_by')) {
    //         } else {
    //           tempAllChatUsers.add(userModel);
    //         }
    //       }
    //       if (tempAllChatUsers.contains(userModel)) {
    //       } else {
    //         tempAllChatUsers.add(userModel);
    //       } // tempCurrentUserMessages=element.get(currentUserId);
    //       // tempOtherUserMessages=element.get(otherUerId);
    //     } else if (element.get('received_by') == currentUserId) {
    //       DocumentSnapshot userValue = await FirebaseFirestore.instance
    //           .collection(kUsers)
    //           .doc(element.get('sent_by'))
    //           .get();
    //       UserModel userModel = UserModel(
    //         emailAddress: userValue.get(kEmailAddress),
    //         userName: userValue.get(kUserName),
    //         uid: userValue.get(kUid),
    //         profileUrl: userValue.get(kProfilePicUrl),
    //         somethingAboutYou: userValue.get(kSomethingAboutYou),
    //         isPhoneNumberVerified: userValue.get(kIsPhoneNumberVerified),
    //         phoneNumber: userValue.get(kPhoneNumber),
    //         isEmailVerified: userValue.get(kIsEmailVerified),
    //       );
    //       if (tempAllChatUsers.contains(userModel)) {
    //       } else {
    //         tempAllChatUsers.add(userModel);
    //       }
    //       // tempCurrentUserMessages=element.get(element.get('user1Id'));
    //       // tempOtherUserMessages=element.get(element.get('user2Id'));
    //     }
    //   }
    //   allChatUsers = tempAllChatUsers;
    //   notifyListeners();
    // }
    if (FirebaseAuth.instance.currentUser != null) {
      List<UserModel> tempAllChatUsers = [];
      QuerySnapshot value = await FirebaseFirestore.instance
          .collection(kUsers)
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .collection('contacts')
          .get();
      for (var element in value.docs) {
        DocumentSnapshot userValue = await FirebaseFirestore.instance
            .collection(kUsers)
            .doc(element.get('userId'))
            .get();
        UserModel userModel = UserModel(
          emailAddress: userValue.get(kEmailAddress),
          userName: userValue.get(kUserName),
          uid: userValue.get(kUid),
          profileUrl: userValue.get(kProfilePicUrl),
          somethingAboutYou: userValue.get(kSomethingAboutYou),
          isPhoneNumberVerified: userValue.get(kIsPhoneNumberVerified),
          phoneNumber: userValue.get(kPhoneNumber),
          isEmailVerified: userValue.get(kIsEmailVerified),
        );
        tempAllChatUsers.add(userModel);
      }
      allChatUsers = tempAllChatUsers;
      notifyListeners();
    }
  }

  getTwoUserChats(String currentUser, String otherUser) async {
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection('chats')
        .orderBy('dateTime', descending: false)
        .get();
    List<MessageModel> tempMessages = [];
    for (var element in value.docs) {
      if (element.get('sent_to') == currentUser &&
          element.get('sent_by') == otherUser) {
        MessageModel messageModel = MessageModel(
          message: element.get('message'),
          sentBy: element.get('sent_by'),
          sentTo: element.get('sent_to'),
          dateTime: (element.get('dateTime') as Timestamp).toDate(),
        );
        tempMessages.add(messageModel);
      } else if (element.get('sent_by') == currentUser &&
          element.get('sent_to') == otherUser) {
        MessageModel messageModel = MessageModel(
          message: element.get('message'),
          sentBy: element.get('sent_by'),
          sentTo: element.get('sent_to'),
          dateTime: (element.get('dateTime') as Timestamp).toDate(),
        );
        tempMessages.add(messageModel);
      }
      messages = tempMessages;
      notifyListeners();
    }
  }
}
