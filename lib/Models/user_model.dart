import 'package:bisell_olx_clone/Constants/constants.dart';

class UserModel {
  String? uid;
  String? userName;
  String? phoneNumber;
  bool? isPhoneNumberVerified;
  bool? isEmailVerified;
  String? somethingAboutYou;
  String? profileUrl;
  String? emailAddress;
  String? fcmToken;
  List<dynamic>? favouriteAds;

  UserModel({
    this.favouriteAds,
    this.uid,
    this.userName='username',
    this.phoneNumber,
    this.isPhoneNumberVerified,
    this.somethingAboutYou,
    this.profileUrl,
    this.emailAddress,
    this.fcmToken,
    this.isEmailVerified
  });

  Map<String, dynamic> asMap() {
    return {
      kUid: uid??'USER-ID',
      kPhoneNumber: phoneNumber??'03XX-XXXXXXX',
      kIsPhoneNumberVerified: isPhoneNumberVerified?? false,
      kSomethingAboutYou: somethingAboutYou??'Something about you',
      kEmailAddress: emailAddress??'user@mail.com',
      kProfilePicUrl: profileUrl,
      kUserName: userName??'USERNAME',
      kFCMToken: fcmToken,
      kFavoriteAds:favouriteAds??[],
      kIsEmailVerified: isEmailVerified??false,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map[kUid],
      phoneNumber: map[kPhoneNumber],
      isPhoneNumberVerified: map[kIsPhoneNumberVerified],
      somethingAboutYou: map[kSomethingAboutYou],
      emailAddress: map[kEmailAddress],
     // myAds: map[kMyAds],
      userName: map[kUserName],
      //favoriteAds: map[kFavoriteAds],
      profileUrl: map[kProfilePicUrl],
      fcmToken: map[kFCMToken],
     favouriteAds: map[kFavoriteAds],
     // views: map[kViews],
      isEmailVerified: map[kIsEmailVerified],
    );
  }
}
