import 'dart:io';
import 'package:bisell_olx_clone/Models/ad_model.dart';
import 'package:bisell_olx_clone/Provider/ad_provider.dart';
import 'package:bisell_olx_clone/Provider/user_provider.dart';
import 'package:bisell_olx_clone/Screens/landing_screen.dart';
import 'package:bisell_olx_clone/main_category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:bisell_olx_clone/Constants/constants.dart';
import 'package:uuid/uuid.dart';
import '../../Secure_Storage/secure_storage.dart';
import '../../Widgets/Buttons/progree_indicating_button.dart';
import '../../Widgets/verify_phone_number_bottom_sheet.dart';

class FinalizeAdScreen extends StatefulWidget {
  final MainCategory mainCategory;
  final String subCategory;
  final Map<String, dynamic> selectedDetails;

  const FinalizeAdScreen(
      {Key? key,
      required this.mainCategory,
      required this.subCategory,
      required this.selectedDetails})
      : super(key: key);

  @override
  _FinalizeAdScreenState createState() => _FinalizeAdScreenState();
}

class _FinalizeAdScreenState extends State<FinalizeAdScreen> {
  File? image1;
  File? image2;
  File? image3;
  final List<dynamic> imageUrls = [
    'https://blog.logrocket.com/wp-content/uploads/2021/09/create-customize-flutter-radio-buttons.png',
    'https://blog.logrocket.com/wp-content/uploads/2021/09/create-customize-flutter-radio-buttons.png',
    'https://blog.logrocket.com/wp-content/uploads/2021/09/create-customize-flutter-radio-buttons.png'
  ];
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  var imagePicker = ImagePicker();
  List<dynamic> imagesDownloadUrl = [];
  final String adId = const Uuid().v1();
  LocationStorage locationStorage = LocationStorage();
  String cityName = kUnknownCity;
  String stateName = kUnknownState;
  bool startLoading = false;

  Future getLocation() async {
    String tempCity =
        await locationStorage.getLocation('user_city') ?? kUnknownCity;
    String tempState =
        await locationStorage.getLocation('user_state') ?? kUnknownState;
    if (tempCity.isEmpty || tempState.isEmpty) {
      tempCity = kUnknownCity;
      tempState = kUnknownState;
    }
    if (tempCity.isNotEmpty && tempState.isNotEmpty) {
      cityName = tempCity;
      stateName = tempState;
    }
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(FirebaseAuth.instance.currentUser==null){}
    final String posterId = FirebaseAuth.instance.currentUser!.uid.toString();
    AdProvider adProvider = Provider.of(context);
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();
    bool isPhoneNumberVerified =
        userProvider.user.isPhoneNumberVerified ?? false;
    String phoneNumber=userProvider.user.phoneNumber??kDummyPhoneNumber;
    AdModel adModel = AdModel();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finalize Ad Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 7,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Add Images',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            SizedBox(
              height: 120,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      var pickedFile = await imagePicker.getImage(
                          source: ImageSource.gallery, imageQuality: 20);
                      setState(() {
                        image1 = File(pickedFile!.path);
                      });
                    },
                    child: Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width / 3 - 15,
                      child: image1 == null
                          ? const Icon(
                              Icons.add,
                              size: 30,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                image1!,
                                fit: BoxFit.cover,
                              ),
                            ),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 2)),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      var pickedFile = await imagePicker.getImage(
                          source: ImageSource.gallery, imageQuality: 20);
                      setState(() {
                        image2 = File(pickedFile!.path);
                      });
                    },
                    child: Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width / 3 - 15,
                      child: image2 == null
                          ? const Icon(
                              Icons.add,
                              size: 30,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                image2!,
                                fit: BoxFit.cover,
                              ),
                            ),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 2)),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      var pickedFile = await imagePicker.getImage(
                          source: ImageSource.gallery, imageQuality: 20);
                      setState(() {
                        image3 = File(pickedFile!.path);
                      });
                    },
                    child: Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width / 3 - 15,
                      child: image3 == null
                          ? const Icon(
                              Icons.add,
                              size: 30,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                image3!,
                                fit: BoxFit.cover,
                              ),
                            ),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 2)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: title,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  label: Text('Title'),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: price,
                decoration: const InputDecoration(
                  hintText: 'Price',
                  label: Text('Price'),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: description,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  label: Text('Description'),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: ElevatedButton(
                  child: startLoading == false
                      ? const Text('Post Ad')
                      : const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                  onPressed: () async {
                    if (image1 == null ||
                        price.text.isEmpty ||
                        title.text.isEmpty ||
                        description.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please fill the required fields')));
                    }
                    if (kDebugMode) {
                      print(stateName + cityName);
                    }

                    if (isPhoneNumberVerified != true) {
                      return showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                            title: Column(
                              children: [
                                const Text(
                                    'You have to verify your phone number first'),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.2,
                                      child: TextFormField(
                                        initialValue: '+92',
                                        keyboardType: TextInputType.phone,
                                        maxLength: 3,
                                        enabled: false,
                                        decoration: const InputDecoration(
                                          labelText: 'Country',
                                          counterStyle: TextStyle(
                                            height: double.minPositive,
                                          ),
                                          counterText: "",
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: isPhoneNumberVerified==true
                                          ? MediaQuery.of(context).size.width * 0.70
                                          : (MediaQuery.of(context).size.width * 0.55) -
                                          32,
                                      child: TextFormField(
                                        initialValue: phoneNumber,
                                        keyboardType: TextInputType.phone,
                                        enabled:
                                        isPhoneNumberVerified == false ? true : false,
                                        onChanged: (value) {
                                          setState(() {
                                            phoneNumber = value;
                                            if (kDebugMode) {
                                              print(phoneNumber);
                                            }
                                          });
                                        },
                                        maxLength: 10,
                                        decoration: const InputDecoration(
                                          // labelText: 'Phone Number',
                                          counterStyle: TextStyle(
                                            height: double.minPositive,
                                          ),
                                          counterText: "",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () => Navigator.of(context).pop()),
                              TextButton(
                                  child: const Text('Verify Now'),
                                  onPressed:()async{
                                    await _verifyPhoneNumberClicked(context,phoneNumber);
                                }),
                            ]),
                      );
                    }
                    if (isPhoneNumberVerified == true) {
                      if (image1 != null &&
                          price.text.isNotEmpty &&
                          title.text.isNotEmpty &&
                          description.text.isNotEmpty) {
                        try {
                          setState(() {
                            startLoading = true;
                          });
                          await uploadImagesAndGetDownloadLink();
                          adModel.price = price.text;
                          adModel.id = adId;
                          adModel.subCategory = widget.subCategory;
                          adModel.imagesUrl = imagesDownloadUrl;
                          adModel.posterId = posterId;
                          adModel.details = widget.selectedDetails;
                          adModel.description = description.text;
                          adModel.dateTime = DateTime.now();
                          adModel.phoneNumber ='+92'+phoneNumber;
                          adModel.mainCategory = widget.mainCategory.catName;
                          adModel.title = title.text;
                          adModel.posterState = stateName;
                          adModel.posterCity = cityName;
                          if (kDebugMode) {
                            print(stateName + cityName);
                          }
                          await adProvider.uploadDataToFirestore(adModel);
                          await Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LandingPage()),
                              (route) => false);
                        } on FirebaseException catch (e) {
                          setState(() {
                            startLoading = false;
                          });
                          if (kDebugMode) {
                            print(e);
                          }
                        }
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future uploadImagesAndGetDownloadLink() async {
    try {
      if (image1 == null) {}
      if (image1 != null) {
        var reference1 =
            FirebaseStorage.instance.ref('$kAdImagesBucket/$image1');
        await reference1.putFile(image1!);
        String download1 = await reference1.getDownloadURL();
        if (kDebugMode) {
          print('Image1 DOWNLOAD URL:$download1');
        }
        imagesDownloadUrl.insert(0, download1);
      }
      if (image2 != null) {
        var reference2 =
            FirebaseStorage.instance.ref('$kAdImagesBucket/$image2');
        await reference2.putFile(image2!);
        String download2 = await reference2.getDownloadURL();
        if (kDebugMode) {
          print('Image1 DOWNLOAD URL:$download2');
        }
        imagesDownloadUrl.insert(1, download2);
      }
      if (image3 != null) {
        var reference3 =
            FirebaseStorage.instance.ref('$kAdImagesBucket/$image3');
        await reference3.putFile(image3!);
        String download3 = await reference3.getDownloadURL();
        if (kDebugMode) {
          print('Image1 DOWNLOAD URL:$download3');
        }
        imagesDownloadUrl.insert(2, download3);
      }
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    if (kDebugMode) {
      print(imagesDownloadUrl);
    }
  }
  _verifyPhoneNumberClicked(BuildContext context,String phoneNumber) async {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        var verifyButtonState = GlobalKey<ProgressIndicatingButtonState>();
        //edited by haider
        return VerifyPhoneNumberBottomSheet(
          verifyButtonState: verifyButtonState,
          phoneNumber: "+92"+phoneNumber,
          currentUser: FirebaseAuth.instance.currentUser,
        );
        // else {
        //   return null;
        // }
      },
    );
  }
}
