import 'dart:math';
import 'package:bisell_olx_clone/Constants/constants.dart';
import 'package:bisell_olx_clone/Models/ad_model.dart';
import 'package:bisell_olx_clone/Screens/conversation_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:bisell_olx_clone/Widgets/pageview_with_indicator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class AdDetailsScreen extends StatefulWidget {
  final AdModel adModel;

  const AdDetailsScreen({Key? key, required this.adModel}) : super(key: key);

  @override
  _AdDetailsScreenState createState() => _AdDetailsScreenState();
}

class _AdDetailsScreenState extends State<AdDetailsScreen> {
  var _scaffoldKey;
  bool isFavorite = false;

  String totalViews = '';

  @override
  void initState() {
   // _checkIfFavorite();
    _checkIfFavorite().then((value) {
      setState(() {
        isFavorite=value;
        print(isFavorite);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> imagesUrlList = widget.adModel.imagesUrl!;
    setState(() {
      totalViews = widget.adModel.views!.length.toString();
    });
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Ad Details'),
        actions: [
          FirebaseAuth.instance.currentUser != null
              ? InkWell(
                  onTap: () async {
                    return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                                'Are you sure want to delete your ad?'),
                            actions: [
                              TextButton(
                                  child: const Text('cancel'),
                                  onPressed: () => Navigator.of(context).pop()),
                              TextButton(
                                child: const Text('Yes'),
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection(kAds)
                                      .doc(widget.adModel.id)
                                      .delete();
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: widget.adModel.posterId ==
                          FirebaseAuth.instance.currentUser!.uid.toString()
                      ? const Icon(Icons.delete)
                      : Container())
              : Container(),
        ],
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.grey,
                height: MediaQuery.of(context).size.height * 0.3,
                child: imagesUrlList.isNotEmpty
                    ? PageViewWithIndicator(
                        imagesUrlList: imagesUrlList,
                        onViewClicked: _onTabClicked,
                      )
                    : const Icon(Icons.image),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rs ${widget.adModel.price!.toString()}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    // if (_ad.posterId != currentUserId)
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border),
                          onPressed: () async {
                            _favoritePressed();
                            // setState(() {
                            //   isFavorite = !isFavorite;
                            //});
                            // if (isFavorite == true) {
                            //   await FirebaseFirestore.instance
                            //       .collection(kAds)
                            //       .doc(widget.adModel.id)
                            //       .update({
                            //     kIsFavouriteAd: isFavorite,
                            //   });
                            // }
                            // if (isFavorite == false) {
                            //   await FirebaseFirestore.instance
                            //       .collection(kAds)
                            //       .doc(widget.adModel.id)
                            //       .update({
                            //     kIsFavouriteAd: isFavorite,
                            //   });
                            // }
                          },
                        ),
                        // IconButton(
                        // icon: Icon(Icons.share), onPressed: _sharePressed)
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                //This contains main and sub-categories
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(widget.adModel.mainCategory!),
                    if (widget.adModel.subCategory != null) const Text(' > '),
                    if (widget.adModel.subCategory != null)
                      Text(widget.adModel.subCategory!)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      // child: Text(_ad.title ??= 'Title Here',
                      child: Text(widget.adModel.title!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                    FirebaseAuth.instance.currentUser != null
                        ? widget.adModel.posterId ==
                                FirebaseAuth.instance.currentUser!.uid
                                    .toString()
                            ? Row(
                                children: [
                                  const Icon(
                                    Icons.remove_red_eye_sharp,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      widget.adModel.views!.isNotEmpty
                                          ? widget.adModel.views!.length
                                              .toString()
                                          : '0',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ],
                              )
                            : Container()
                        : Container(),
                  ],
                ),
              ),

              // for views
              // _ad.posterId==currentUserId? InkWell(
              //   onTap: ()async{
              //     var adViews=await FirebaseFirestore.instance.collection('ads').doc(_ad.id).get();
              //      setState(() {
              //        views=adViews.get('views');
              //      });
              //   },
              //   child: Padding(
              //     //THis is for title
              //     padding: const EdgeInsets.only(left: 8.0),
              //     child: Text(views.toString() ??0,
              //         style:
              //         TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              //   ),
              // ): Container(),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4, top: 8.0, right: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('${widget.adModel.posterCity ?? kUnknownCity},  '
                            '${widget.adModel.posterState ?? kUnknownState}')
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text((widget.adModel.dateTime == null)
                            ? ""
                            : DateFormat('dd MMMM')
                                .format(widget.adModel.dateTime!)),
                      ],
                    ),
                  ],
                ),
              ),
              // if (_containsDetails)
              const Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 8.0),
                  child: Text(
                    'Details',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              // if (_containsDetails)
              const SizedBox(
                height: 10,
              ),
              // if (_containsDetails)
              widget.adModel.details!.isNotEmpty
                  ? Container(
                      //height: 150,
                      height: min(widget.adModel.details!.length * 50.0, 150.0)
                          .toDouble(),
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withAlpha(100))),
                      //There was expanded widget but to build release i replaced it with container
                      child: Center(
                        child: ListView.separated(
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.adModel.details!.keys.elementAt(index),
                                ),
                                Text(
                                    widget.adModel.details!.values
                                        .elementAt(index),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          itemCount: widget.adModel.details!.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                        ),
                      ),
                    )
                  : Container(),
              const Padding(
                padding: EdgeInsets.only(top: 20.0, left: 8.0),
                child: Text(
                  'Description',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Text(widget.adModel.description!),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
        //There was expanded widget but to build release i replaced it with container
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                      onPressed: () {
                        _chatPressed(widget.adModel.posterId!.toString());
                      },
                      icon: const Icon(Icons.chat),
                      label: const Text('Chat')),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                      onPressed: _callPressed,
                      icon: const Icon(Icons.call),
                      label: const Text('Call')),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                      onPressed: _smsPressed,
                      icon: const Icon(Icons.sms),
                      label: const Text('SMS'))
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  void _onTabClicked(String clickedImageUrl) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: InteractiveViewer(
              panEnabled: true,
              minScale: 0.001,
              child: Image.network(clickedImageUrl),
              // child: PageViewWithIndicator(imagesUrlList: ad.ima,),
            ),
          );
        });
  }

  void _callPressed() async {
    String url = 'tel:${widget.adModel.phoneNumber}';
    await canLaunch(url) ? await launch(url) : _showErrorToast();
  }

  void _chatPressed(String receiverUserId) {
    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (_) => ConversationScreen(receiverUserId: _ad.posterId)));
    // builder: (_) => ConversationScreen(receiverUserId: _ad.posterId)));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ConversationScreen(
                  receiverUserId: receiverUserId,
                )));
  }

  void _smsPressed() async {
    String url = 'sms: ${widget.adModel.phoneNumber}';
    await canLaunch(url) ? await launch(url) : _showErrorToast();
  }

  void _showErrorToast() {
    Fluttertoast.showToast(
        msg: "Something went wrong. Please try again latter",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<bool> _removeFromFavorite() async {
    if (FirebaseAuth.instance.currentUser == null) {}
    try {
      await FirebaseFirestore.instance
          .collection(kUsers)
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .update({
        kFavoriteAds: FieldValue.arrayRemove([widget.adModel.id])
      });
      print('Removed from favorites');
      return true;
    } catch (e) {
      print('_removeFromFavorite: SWW: $e');
      return false;
    }
  }

  Future<bool> _checkIfFavorite() async {
    if (FirebaseAuth.instance.currentUser != null) {}
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(kUsers)
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .get();
      //TODO [] here
      List<dynamic> favorites = documentSnapshot.get(kFavoriteAds);
      print(favorites);
      print(widget.adModel.id);
      if (favorites.contains(widget.adModel.id)) {
        setState(() {
          isFavorite == true;
        });
        return true;
      }
      /*else {
        setState(() {
          isFavorite == false;
        });
      }*/
      if (favorites.contains(widget.adModel.id) == false) {
        setState(() {
          isFavorite==false;
        });
        return false;
      }
      return favorites.contains(widget.adModel.id);
    } catch (e) {
      print(
          '_checkIfFavorite: Something went wrong while checking if favorite: $e');
      return false;
    }
  }

  Future<bool> _addToFavorite() async {
    if (FirebaseAuth.instance.currentUser == null) {}
    try {
      await FirebaseFirestore.instance
          .collection(kUsers)
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .update({
        kFavoriteAds: FieldValue.arrayUnion([widget.adModel.id])
      });
      print('Added to favorite');
      return true;
    } catch (e) {
      print('Something went wrong while adding to favorite: $e');
      return false;
    }
  }

  void _favoritePressed() {
    if (isFavorite == true) {
      _removeFromFavorite().then((value) {
        setState(() {
          isFavorite = false;
        });
      });
    } else {
      _addToFavorite().then((value) {
        setState(() {
          isFavorite = true;
        });
      });
    }
  }
}
