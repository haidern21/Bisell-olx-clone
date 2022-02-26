import 'package:bisell_olx_clone/Models/ad_model.dart';
import 'package:bisell_olx_clone/Models/user_model.dart';
import 'package:bisell_olx_clone/Provider/ad_provider.dart';
import 'package:bisell_olx_clone/Provider/user_provider.dart';
import 'package:bisell_olx_clone/Screens/Authentication_Screens/signup_screen_without_skip.dart';
import 'package:bisell_olx_clone/Screens/view_and_edit_profile_screen.dart';
import 'package:bisell_olx_clone/Widgets/ad_details_screen.dart';
import 'package:bisell_olx_clone/Widgets/ad_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  UserModel userModel = UserModel();
  AdModel adModel= AdModel();

  @override
  void initState() {
    super.initState();
  }

  String? userName;
  String? userProfilePic;

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {}
    UserProvider userProvider = Provider.of(context);
    AdProvider adProvider=Provider.of(context);
    userProvider.getUserData();
    adProvider.getAllAds();
    userName = userProvider.user.userName;
    userProfilePic = userProvider.user.profileUrl;
    return FirebaseAuth.instance.currentUser != null
        ? Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 50,
                              child: userProfilePic != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        userProfilePic!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Image.asset('assets/user/man.png'),
                              // child: userProfilePic!.isEmpty?Image.asset( 'assets/user/man.png'):Image.network(userProfilePic,fit: BoxFit.cover,),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  userName!.isEmpty ? 'User-Name' : userName!,
                                softWrap: true,
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w700),
                                overflow: TextOverflow.clip,
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ViewAndEditProfileScreen()));
                                    },
                                    child: const Text(
                                      'view and edit profile',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                             AdDetailsScreen(adModel: adProvider.myAds[index],)));
                              },
                              child: AdItem(
                                  adImageUrl: adProvider.myAds[index].imagesUrl!.first,
                                  adCity: adProvider.myAds[index].posterCity!,
                                  adPrice: adProvider.myAds[index].price!,
                                  adTitle: adProvider.myAds[index].title!,),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: adProvider.myAds.length),
                    ),
                  ],
                ),
              ),
            ),
          )
        : const SignupScreenWithoutSkip();
  }
}
