import 'package:bisell_olx_clone/Screens/subcategories_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../main_category.dart';
class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListView.builder(
              itemCount: ALL_CATEGORIES.length,
              itemBuilder:(context,index){
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>  SubCategoryScreen(mainCategory: ALL_CATEGORIES[index])));
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
    );
  }
}
