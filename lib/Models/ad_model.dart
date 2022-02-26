import 'package:bisell_olx_clone/Constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdModel {
  String? id;
  String? title;
  String? description;
  String? price;
  String? mainCategory;
  String? subCategory;
  Map<String, dynamic>? details;
  List<dynamic>? imagesUrl;
  DateTime? dateTime;
  String? phoneNumber;
  String? posterId;
  List<dynamic>? views;
  bool isFavourite;
  String? posterCity;
  String? posterState;

  AdModel({
    this.title,
    this.mainCategory,
    this.phoneNumber,
    this.dateTime,
    this.description,
    this.details,
    this.id,
    this.posterId,
    this.imagesUrl,
    this.price,
    this.subCategory,
    this.views,
    this.posterCity,
    this.posterState,
    this.isFavourite = false,
  });

  Map<String, dynamic> asMap() {
    //Commented by haider
    // Map<String, String> imageMap = {};
    // print('No of images to upload: ${imagesUrl.length}');
    // for (int i = 0; i < imagesUrl.length; i++) {
    //   print('Adding following URL: ${imagesUrl[i]}');
    //   imageMap[i.toString()] = imagesUrl[i];
    // }
    return {
      kAdId: id,
      kAdTitle: title,
      kAdDescription: description,
      kAdPrice: price,
      kAdMainCategory: mainCategory,
      kAdSubCategory: subCategory,
      kAdPosterId: posterId,
      kAdImagesUrl: imagesUrl??[],
      kAdDetails: details,
      kAdTimeDate: dateTime,
      kAdPhoneNumber: phoneNumber,
      kIsFavouriteAd: isFavourite,
      kPosterCity:posterCity,
      kPosterState:posterState,
      kViews: views??[],
    };
  }

  factory AdModel.fromMap(Map<String, dynamic> map) {
    return AdModel(
      title: map[kAdTitle],
      id: map[kAdId],
      phoneNumber: map[kPhoneNumber],
      posterId: map[kAdPosterId],
      price: map[kAdPrice],
      mainCategory: map[kAdMainCategory],
      description: map[kAdDescription],
      imagesUrl: map[kAdImagesUrl],
      details: map[kAdDetails],
      dateTime: (map[kAdTimeDate] as Timestamp).toDate(),
      isFavourite: map[kIsFavouriteAd],
      views: map[kViews],
    );
  }
}
