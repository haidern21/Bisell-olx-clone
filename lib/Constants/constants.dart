import 'package:flutter/material.dart';

const double kButtonCornerRadius = 6;

//Below are the keys for Users
const String kUsers = 'users';
const String kUserName = 'user_name';
const String kProfilePicUrl = 'profile_pic_url';
const String kFCMToken = "fcm_token";
const String kGroupChatId='group_chat_id';
const String kUid = 'uid';
const String kSomethingAboutYou = 'something_about_you';
const String kPhoneNumber = 'phone_number';
const String kEmailAddress = 'email';
const String kIsPhoneNumberVerified = 'is_phone_number_verified';
const String kIsEmailVerified = 'is_Email_verified';
const String kFavoriteAds = 'favorite_ads';
const String kMyAds = 'my_ads';
const String kViews='views';

//Following are the keys for Chat
const String kChats = "chats";
const String kMessages = "messages";

//Following are to for the path in Firestore
const String kAds = 'ads';
const String kCategories = 'categories';
const String kLocations = 'locations';

const String kUnknownState = 'unknown_state';
const String kUnknownCity = 'unknown_city';
const String kCountryName='country_name';
const String kStateName='state_Name';
const String kCityName='city_Name';

const kTextStyleClickable = TextStyle(
  color: Colors.blue,
  fontWeight: FontWeight.bold,
  decoration: TextDecoration.underline,
);

const kSizedBoxHeight10 = SizedBox(height: 10,);

const kTextStyleHeadline =
TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold);

const kTextStyleButton =
TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold);

const kTextStyleSubheading =
TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal);
const String kAdId = 'id';
const String kAdTitle = 'title';
const String kAdDescription = 'description';
const String kAdPrice = 'price';
const String kAdAddress = 'address';
const String kAdMainCategory = 'main_category';
const String kAdSubCategory = 'sub_category';
const String kAdTimeDate = 'time_date';
const String kAdDetails = 'ad_details';
const String kAdImagesUrl = 'images_urls';
const String kAdImagesBucket = "ads_images";
const String kAdPhoneNumber = 'phone_number';
const String kAdPosterId = 'poster_id';
const String kPosterCity='poster_city';
const String kPosterState='poster_state';
const String kIsFavouriteAd='is_favourite';
const String kDummyPhoneNumber='03XX-XXXXXXX';

//FOR ADDRESS
const String kAddressAddressLine = 'address_line';
const String kAddressAdminArea = 'admin_area';

const Map<String, List<String>> mapCategories = {
  'Laptops': [
    'Laptops',
    'Laptop Bags',
    'Laptop Charger',
    'Laptop Battery',
    'Laptop Stand'
  ],
  'Casings': [],
  'Storage': [
    'SSD',
    'HDD',
    'USB',
    'External Storage',
  ],
  'CPU': [],
  'GPU': [],
  'RAM': [],
  'Monitor': [],
  'Keyboard': [],
  'Mouse': [],
  'Headphones': [],
  'Speakers': [],
};
const List<String> kTopLaptopCompanies = [
  'Apple',
  'HP',
  'Lenovo',
  'Dell',
  'Acer',
  'Asus',
  'MSI',
  'Razer',
  'Samsung',
  'Other'
];
