import 'package:bisell_olx_clone/Constants/constants.dart';
import 'package:bisell_olx_clone/Models/location_model.dart';
import 'package:bisell_olx_clone/Secure_Storage/secure_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider extends ChangeNotifier {
  List<Placemark> placemarks = [];
  LocationModel location = LocationModel();
  LocationStorage locationStorage=LocationStorage();

  Future uploadLocationInfo(String country, String state, String city) async {
    location.countryName = country;
    location.cityName = city;
    location.stateName = state;
    locationStorage.saveLocation('user_city', city);
    locationStorage.saveLocation('user_state', state);
    if(FirebaseAuth.instance.currentUser!=null){
      var userId= FirebaseAuth.instance.currentUser!.uid.toString();
      await FirebaseFirestore.instance
          .collection('locations')
          .doc(userId)
          .set(location.asMap());
    }
  }

  getLocationInfo()async{
    if(FirebaseAuth.instance.currentUser!=null){
      var userId= FirebaseAuth.instance.currentUser!.uid.toString();
      DocumentSnapshot value= await FirebaseFirestore.instance.collection('locations').doc(userId).get();
      location.countryName=value.get(kCountryName);
      location.stateName=value.get(kStateName);
      location.cityName=value.get(kCityName);
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
       await Geolocator.requestPermission();
      // return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
        // return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future convertLatLangToAddress() async {
    Position position = await _determinePosition();
    if (kDebugMode) {
      print('latitude: ${position.latitude}');
      print('longitude: ${position.longitude}');
    }
    placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    await uploadLocationInfo(
        placemarks.first.country.toString(),
        placemarks.first.administrativeArea.toString(),
        placemarks.first.subAdministrativeArea.toString());
    notifyListeners();
  }
}
