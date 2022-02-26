import 'package:bisell_olx_clone/Screens/Sell/intermediate_sell_screen.dart';
import 'package:flutter/material.dart';
import '../../main_category.dart';
class SeeAllSubCategoryScreen extends StatelessWidget {
  final MainCategory mainCategory;
  const SeeAllSubCategoryScreen({Key? key,required this.mainCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(mainCategory.catName),
      ),
      body: ListView.builder(
        itemCount: mainCategory.subCategories!.length,
        itemBuilder: (context,index){
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>IntermediateSellScreen(mainCategory: mainCategory, subCatName: mainCategory.subCategories![index])));
            },
            child: ListTile(
              title: Text(mainCategory.subCategories![index],style: const TextStyle(fontSize: 18,),),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
            ),
          );
        },
      ),
    );
  }
}
