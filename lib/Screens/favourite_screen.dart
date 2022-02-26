import 'package:bisell_olx_clone/Provider/ad_provider.dart';
import 'package:bisell_olx_clone/Screens/Authentication_Screens/signup_screen_without_skip.dart';
import 'package:bisell_olx_clone/Widgets/ad_details_screen.dart';
import 'package:bisell_olx_clone/Widgets/ad_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {

    AdProvider adProvider = Provider.of(context);
    adProvider.getFavoriteAds();
    print(adProvider.favouriteAds);
    //adProvider.getFavouriteAds();
    return FirebaseAuth.instance.currentUser!=null?Scaffold(
      appBar: AppBar(
        title: const Text('Favourites Screen'),
      ),
      body: adProvider.favouriteAds.isEmpty
          ? Center(
              child: Image.asset("assets/images/no_fav.png"),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdDetailsScreen(
                                    adModel: adProvider.favouriteAds[index])));
                      },
                      child: AdItem(
                          adImageUrl:
                              adProvider.favouriteAds[index].imagesUrl!.first,
                          adCity: adProvider.favouriteAds[index].posterCity!,
                          adPrice: adProvider.favouriteAds[index].price!,
                          adTitle: adProvider.favouriteAds[index].title!),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: adProvider.favouriteAds.length),
            ),
    ): const SignupScreenWithoutSkip();
  }
}
