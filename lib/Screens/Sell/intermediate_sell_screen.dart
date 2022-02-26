import 'package:bisell_olx_clone/Models/ad_model.dart';
import 'package:bisell_olx_clone/Screens/Sell/finalize_ad_screen.dart';
import 'package:bisell_olx_clone/main_category.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class IntermediateSellScreen extends StatefulWidget {
  final MainCategory mainCategory;
  final String subCatName;

  const IntermediateSellScreen(
      {Key? key, required this.mainCategory, required this.subCatName})
      : super(key: key);

  @override
  _IntermediateSellScreenState createState() => _IntermediateSellScreenState();
}

class _IntermediateSellScreenState extends State<IntermediateSellScreen> {
  List<Options>? sellOptions;
  Map<String, dynamic> selectedOptions = {};
  int? selectedIndex;
  AdModel adModel = AdModel();
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    sellOptions = widget.mainCategory.sellOptions![widget.subCatName];
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.mainCategory.catName} > ${widget.subCatName}'),
      ),
      body: ListView.separated(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index1) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sellOptions![index1].title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                //Text(sellOptions![index].options[index]),
                SizedBox(
                  height: 50,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedOptions.addAll({
                                sellOptions![index1].title:
                                    sellOptions![index1].options[index],
                              });
                            });
                          },
                          child: Container(
                              width: 130,
                              decoration: BoxDecoration(
                                color: selectedOptions.containsValue(
                                        sellOptions![index1].options[index])
                                    ? Colors.blue
                                    : Colors.transparent,
                                border:
                                    Border.all(color: Colors.blue, width: 2),
                              ),
                              child: Center(
                                  child: Text(
                                sellOptions![index1].options[index],
                                style: const TextStyle(fontSize: 16),
                                overflow: TextOverflow.fade,
                              ))),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 15,
                          ),
                      itemCount: sellOptions![index1].options.length),
                ),
              ],
            ),
          );
        },
        itemCount: sellOptions!.length,
        separatorBuilder: (context, index) => const SizedBox(
          height: 5,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_forward),
        onPressed: () {
          adModel.details = selectedOptions;
          if (kDebugMode) {
            print('selected options are:$selectedOptions');
          }
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FinalizeAdScreen(
                        mainCategory: widget.mainCategory,
                        subCategory: widget.subCatName,
                        selectedDetails: selectedOptions,
                      )));
        },
      ),
    );
  }
}
