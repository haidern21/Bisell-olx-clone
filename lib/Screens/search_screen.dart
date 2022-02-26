import 'package:bisell_olx_clone/Models/ad_model.dart';
import 'package:bisell_olx_clone/Widgets/ad_details_screen.dart';
import 'package:bisell_olx_clone/Widgets/ad_item.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final List<AdModel> ads;

  const SearchScreen({Key? key, required this.ads}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<AdModel> filterAds = [];

  @override
  Widget build(BuildContext context) {
    print(widget.ads.length);
    return Scaffold(
      body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    SafeArea(
                      child: TextFormField(
                        autofocus: false,
                        onChanged: (value) {
                          List<AdModel> tempFilterAds = [];
                          for (var element in widget.ads) {
                            element.title!.toLowerCase().contains(value)
                                ? tempFilterAds.add(element)
                                : null;
                            print(filterAds.length);
                            setState(() {
                              filterAds = tempFilterAds;
                            });
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter message',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                )),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            suffixIcon: const Icon(
                              Icons.search,
                              color: Colors.blue,
                            )),
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return filterAds.isEmpty
                                ? InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdDetailsScreen(
                                                      adModel:
                                                          widget.ads[index])));
                                    },
                                    child: AdItem(
                                        adImageUrl:
                                            widget.ads[index].imagesUrl!.first,
                                        adCity: widget.ads[index].posterCity!,
                                        adPrice: widget.ads[index].price!,
                                        adTitle: widget.ads[index].title!),
                                  )
                                : InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdDetailsScreen(
                                                      adModel:
                                                          filterAds[index])));
                                    },
                                    child: AdItem(
                                        adImageUrl:
                                            filterAds[index].imagesUrl!.first,
                                        adCity: filterAds[index].posterCity!,
                                        adPrice: filterAds[index].price!,
                                        adTitle: filterAds[index].title!),
                                  );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 5,
                              ),
                          itemCount: filterAds.isEmpty
                              ? widget.ads.length
                              : filterAds.length),
                    )
                  ],
                ),
              ),
            )
    );
  }
}
