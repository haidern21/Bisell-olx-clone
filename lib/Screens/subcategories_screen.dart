import 'package:bisell_olx_clone/Models/ad_model.dart';
import 'package:bisell_olx_clone/Provider/ad_provider.dart';
import 'package:bisell_olx_clone/Widgets/ad_details_screen.dart';
import 'package:bisell_olx_clone/Widgets/ad_item.dart';
import 'package:bisell_olx_clone/main_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubCategoryScreen extends StatelessWidget {
  final MainCategory mainCategory;

  const SubCategoryScreen({Key? key, required this.mainCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mainCategory.catName),
      ),
      body: ListView.builder(
        itemCount: mainCategory.subCategories!.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategorySpecificScreen(
                            mainCategory: mainCategory,
                            subCategory: mainCategory.subCategories![index],
                          )));
            },
            child: ListTile(
              title: Text(mainCategory.subCategories![index]),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
            ),
          );
        },
      ),
    );
  }
}

class CategorySpecificScreen extends StatefulWidget {
  final String subCategory;
  final MainCategory mainCategory;

  const CategorySpecificScreen(
      {Key? key, required this.subCategory, required this.mainCategory})
      : super(key: key);

  @override
  _CategorySpecificScreenState createState() => _CategorySpecificScreenState();
}

class _CategorySpecificScreenState extends State<CategorySpecificScreen> {
  @override
  Widget build(BuildContext context) {
    AdProvider adProvider = Provider.of(context);
    List<AdModel> catAds = [];
    adProvider.ads.forEach((element) {
      if (element.subCategory == widget.subCategory) {
        catAds.add(element);
      }
    });
    print(
        'The length of CAT-ADS list called in Category Specific: ${catAds.length}');
    print('The CAT-ADS list called in Category Specific: ${catAds.asMap()}');
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.mainCategory.catName} > ${widget.subCategory}'),
      ),
      body: catAds.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 10, right: 10),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AdDetailsScreen(adModel: catAds[index])));
                      },
                      child: AdItem(
                          adImageUrl:
                              'https://blog.logrocket.com/wp-content/uploads/2021/09/create-customize-flutter-radio-buttons.png',
                          adCity: 'Islamabad',
                          adPrice: catAds[index].price!,
                          adTitle: catAds[index].title!),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: catAds.length),
            )
          : Center(
              child: Image.asset("assets/images/no_result.png"),
            ),
    );
  }
}
