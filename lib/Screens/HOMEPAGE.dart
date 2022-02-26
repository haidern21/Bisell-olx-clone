import 'dart:developer';

import 'package:bisell_olx_clone/Constants/constants.dart';
import 'package:bisell_olx_clone/Models/ad_model.dart';
import 'package:bisell_olx_clone/Models/location_model.dart';
import 'package:bisell_olx_clone/Provider/ad_provider.dart';
import 'package:bisell_olx_clone/Screens/all_categories_screen.dart';
import 'package:bisell_olx_clone/Screens/location_page.dart';
import 'package:bisell_olx_clone/Screens/search_screen.dart';
import 'package:bisell_olx_clone/Screens/subcategories_screen.dart';
import 'package:bisell_olx_clone/Secure_Storage/secure_storage.dart';
import 'package:bisell_olx_clone/Widgets/ad_details_screen.dart';
import 'package:bisell_olx_clone/Widgets/ad_item.dart';
import 'package:bisell_olx_clone/Widgets/category_item.dart';
import 'package:bisell_olx_clone/main_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LocationModel locationModel = LocationModel();
  LocationStorage locationStorage = LocationStorage();
  String cityName = kUnknownCity;
  String stateName = kUnknownState;
  List<AdModel> ads = [];
  List<AdModel> locationSpecificAds = [];
  ScrollController? controller;

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
    log('build called');
    if (FirebaseAuth.instance.currentUser == null) {}
    AdProvider adProvider = Provider.of(context);
    // if(cityName.isNotEmpty){
    //   adProvider.getLocationSpecificAds(cityName);
    //   ads=adProvider.locationSpecificAds;
    // }
    // if (cityName.isEmpty || cityName == kUnknownCity) {
    //   adProvider.getAllAds();
    //     print('if');
    //     ads = adProvider.ads;
    // }
    if (kDebugMode) {
      print(
          'The length of ADS list called in HOMEPAGE: ${adProvider.ads.length}');
      print('The ADS list called in HOMEPAGE: ${adProvider.ads.asMap()}');
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LocationPage()));
                },
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            size: 25,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            cityName.isEmpty ? 'Unknown city' : cityName,
                            style: const TextStyle(fontSize: 18),
                          ),
                          const Text(' , '),
                          Text(
                            stateName.isEmpty ? 'Unknown state' : stateName,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Colors.black,
                        size: 25,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchScreen(
                                ads: ads,
                              )));
                },
                child: SizedBox(
                  height: 60,
                  child: Center(
                    child: InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: const [
                            SizedBox(
                              width: 4,
                            ),
                            Icon(Icons.search),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Search anything',
                              style: TextStyle(fontSize: 17),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Browse Categories',
                    style: TextStyle(fontSize: 15),
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(50, 30),
                          alignment: Alignment.centerLeft),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AllCategoriesScreen()));
                      },
                      child: const Text(
                        'See All',
                        style: TextStyle(fontSize: 15),
                      )),
                ],
              ),
              SizedBox(
                height: 150,
                child: ListView.separated(
                  controller: controller,
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 15,
                        ),
                    scrollDirection: Axis.horizontal,
                    itemCount: ALL_CATEGORIES.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (ALL_CATEGORIES[index].subCategories!.isEmpty) {
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SubCategoryScreen(
                                          mainCategory: ALL_CATEGORIES[index],
                                        )));
                          }
                        },
                        child: CategoryItem(
                            bgColor: ALL_CATEGORIES[index].bgColor,
                            catIconAddress:
                                ALL_CATEGORIES[index].catIconAddress,
                            catName: ALL_CATEGORIES[index].catName),
                      );
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: FutureBuilder(
                  future: cityName.isNotEmpty? adProvider.getLocationSpecificAds(cityName):adProvider.getAllAds(),
                  builder: (context, snapshot) {
                    if(cityName.isNotEmpty){
                      ads=adProvider.locationSpecificAds;
                    }
                    if(cityName.isEmpty){
                      ads=adProvider.ads;
                    }

                    return ListView.separated(
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return ads.isNotEmpty
                                ? Column(
                              children: [
                                Center(
                                    child: Text(cityName.isNotEmpty
                                        ? 'Showing you ads from $cityName'
                                        : 'Showing you ads from Pakistan')),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                    onTap: () async {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdDetailsScreen(
                                                    adModel:
                                                    adProvider.ads[index],
                                                  )));
                                      if (FirebaseAuth.instance.currentUser !=
                                          null) {
                                        var uid = FirebaseAuth
                                            .instance.currentUser!.uid
                                            .toString();
                                        if (ads[index].posterId == uid) {
                                        } else {
                                          var documentSnapshot =
                                          FirebaseFirestore.instance
                                              .collection(kAds)
                                              .doc(ads[index].id);
                                          List<dynamic> docSnap = [];
                                          try {
                                            docSnap = (await documentSnapshot
                                                .get())[kViews] ??
                                                [];
                                          } on FirebaseException catch (e) {
                                            print(
                                                'Problem in views part :${e.message}');
                                          }
                                          if (docSnap.contains(uid)) {
                                          } else {
                                            docSnap.add(uid);
                                            await documentSnapshot
                                                .update({kViews: docSnap});
                                          }
                                        }
                                      }
                                    },
                                    child: AdItem(
                                        adImageUrl:
                                        ads[index].imagesUrl!.first,
                                        adCity: ads[index].posterCity!,
                                        adPrice: ads[index].price.toString(),
                                        adTitle: ads[index].title!)),
                              ],
                            )
                                : Center(
                              child: Text(
                                  'No ads are available from $cityName city '),
                            );
                          }
                          return ads.isNotEmpty
                              ? InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AdDetailsScreen(
                                          adModel: adProvider.ads[index],
                                        )));
                              },
                              child: AdItem(
                                  adImageUrl: ads[index].imagesUrl!.first,
                                  adCity: ads[index].posterCity!,
                                  adPrice: ads[index].price.toString(),
                                  adTitle: ads[index].title!))
                              : Center(
                            child: Text(
                                'No ads are available from $cityName city'),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemCount: ads.length);
                  }),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
