import 'package:bisell_olx_clone/Screens/Authentication_Screens/signup_screen_without_skip.dart';
import 'package:bisell_olx_clone/Screens/Sell/sell_sub_categories_screen.dart';
import 'package:bisell_olx_clone/main_category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class SellCategoriesScreen extends StatelessWidget {
  const SellCategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser!=null?Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListView.builder(
            itemCount: ALL_CATEGORIES.length,
              itemBuilder:(context,index){
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SeeAllSubCategoryScreen(mainCategory: ALL_CATEGORIES[index])));
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: ALL_CATEGORIES[index].bgColor,
                    radius: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SvgPicture.asset(ALL_CATEGORIES[index].catIconAddress),
                    ),
                  ),
                  title: Text(ALL_CATEGORIES[index].catName,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,),
                ),
              );
              }),
        ),
      ),
    ): const SignupScreenWithoutSkip();
  }
}
