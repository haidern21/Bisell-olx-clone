import 'package:bisell_olx_clone/Constants/constants.dart';
import 'package:bisell_olx_clone/Models/ad_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdProvider extends ChangeNotifier {
  List<AdModel> ads = [];
  List<AdModel> favouriteAds = [];
  List<AdModel> myAds = [];
  List<AdModel> locationSpecificAds = [];

  List<AdModel> get getAdsList {
    return ads;
  }

  List<AdModel> get getFavAdsList {
    return favouriteAds;
  }

  Future uploadDataToFirestore(AdModel adModel) async {
    await FirebaseFirestore.instance
        .collection('ads')
        .doc(adModel.id)
        .set(adModel.asMap());
  }

  getLocationSpecificAds(String city) async {
    List<AdModel> tempLocationSpecificAds = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection(kAds)
        .orderBy(kAdTimeDate, descending: true)
        .get();
    for (var element in value.docs) {
      if (element.get(kPosterCity) == city) {
        AdModel adModel = AdModel(
          title: element.get(kAdTitle),
          mainCategory: element.get(kAdMainCategory),
          imagesUrl: element.get(kAdImagesUrl),
          dateTime: (element.get(kAdTimeDate) as Timestamp).toDate(),
          isFavourite: element.get(kIsFavouriteAd),
          posterCity: element.get(kPosterCity),
          posterState: element.get(kPosterState),
          phoneNumber: element.get(kAdPhoneNumber),
          description: element.get(kAdDescription),
          details: element.get(kAdDetails),
          posterId: element.get(kAdPosterId),
          id: element.get(kAdId),
          subCategory: element.get(kAdSubCategory),
          price: element.get(kAdPrice),
          views: element.get(kViews),
        );
        tempLocationSpecificAds.add(adModel);
      }
      locationSpecificAds = tempLocationSpecificAds;
      notifyListeners();
    }
  }

  getAllAds() async {
    List<AdModel> tempAd = [];
    List<AdModel> favTempAd = [];
    List<AdModel> tempMyAds = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection('ads')
        .orderBy(kAdTimeDate, descending: true)
        .get();
    for (var element in value.docs) {
      AdModel adModel = AdModel(
        title: element.get(kAdTitle),
        mainCategory: element.get(kAdMainCategory),
        imagesUrl: element.get(kAdImagesUrl),
        dateTime: (element.get(kAdTimeDate) as Timestamp).toDate(),
        isFavourite: element.get(kIsFavouriteAd),
        phoneNumber: element.get(kAdPhoneNumber),
        description: element.get(kAdDescription),
        posterCity: element.get(kPosterCity),
        posterState: element.get(kPosterState),
        details: element.get(kAdDetails),
        posterId: element.get(kAdPosterId),
        id: element.get(kAdId),
        subCategory: element.get(kAdSubCategory),
        price: element.get(kAdPrice),
        views: element.get(kViews),
      );

      tempAd.add(adModel);
      if (FirebaseAuth.instance.currentUser != null) {
        String currentUserId =
            FirebaseAuth.instance.currentUser!.uid.toString();
        if (element.get(kAdPosterId) == currentUserId) {
          tempMyAds.add(adModel);
        }
      }
    }
    ads = tempAd;
    myAds = tempMyAds;
    notifyListeners();
  }

  getFavoriteAds() async {
    List<AdModel> tempAds = [];
    List<AdModel> tempFavAds = [];
    List<dynamic> userFavAds = [];
    QuerySnapshot ads = await FirebaseFirestore.instance.collection(kAds).get();
    for (var element in ads.docs) {
      AdModel adModel = AdModel(
        title: element.get(kAdTitle),
        mainCategory: element.get(kAdMainCategory),
        imagesUrl: element.get(kAdImagesUrl),
        dateTime: (element.get(kAdTimeDate) as Timestamp).toDate(),
        isFavourite: element.get(kIsFavouriteAd),
        phoneNumber: element.get(kAdPhoneNumber),
        description: element.get(kAdDescription),
        posterCity: element.get(kPosterCity),
        posterState: element.get(kPosterState),
        details: element.get(kAdDetails),
        posterId: element.get(kAdPosterId),
        id: element.get(kAdId),
        subCategory: element.get(kAdSubCategory),
        price: element.get(kAdPrice),
        views: element.get(kViews),
      );
      tempAds.add(adModel);
    }
    DocumentSnapshot userValue = await FirebaseFirestore.instance
        .collection(kUsers)
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();
     userFavAds=userValue.get(kFavoriteAds);
     print(userFavAds);
     print(tempAds.length);
     for (int i=0;i<userFavAds.length;i++) {
        tempAds.where((element) => element.id==userFavAds[i]).forEach((element) {
          tempFavAds.add(element);
        });
      print(tempFavAds);
     }
     print(tempFavAds.length);
    favouriteAds = tempFavAds;
    notifyListeners();
  }
}
