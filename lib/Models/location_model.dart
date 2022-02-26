import 'package:bisell_olx_clone/Constants/constants.dart';

class LocationModel {
  String? countryName;
  String? stateName;
  String? cityName;

  LocationModel({this.cityName, this.countryName, this.stateName});

  Map<String, dynamic> asMap() {
    return {
      kCountryName: countryName,
      kStateName: stateName,
      kCityName: cityName,
    };
  }
}
