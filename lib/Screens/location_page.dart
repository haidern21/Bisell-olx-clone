import 'package:bisell_olx_clone/Provider/location_provider.dart';
import 'package:bisell_olx_clone/Screens/landing_screen.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String? countryValue = 'Pakistan';
  String? stateValue;
  String? cityValue;
  bool startSaving = false;
  bool startLocation = false;

  @override
  Widget build(BuildContext context) {
    LocationProvider locationProvider = Provider.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Locations',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        startLocation = true;
                      });
                      await locationProvider.convertLatLangToAddress();
                      setState(() {
                        startLocation = false;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LandingPage()));
                    },
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          const Icon(Icons.gps_fixed_outlined),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            startLocation == false
                                ? 'Use Current Location'
                                : 'Getting Location.....',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        'Choose Location',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CSCPicker(
                    defaultCountry: DefaultCountry.Pakistan,
                    onCountryChanged: (value) {
                      setState(() {
                        countryValue = DefaultCountry.Pakistan.name;
                      });
                    },
                    onStateChanged: (value) {
                      setState(() {
                        stateValue = value;
                      });
                    },
                    onCityChanged: (value) {
                      setState(() {
                        cityValue = value;
                      });
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: InkWell(
                  onTap: () async {
                    setState(() {
                      startSaving = true;
                    });
                    await locationProvider.uploadLocationInfo(
                        countryValue!, stateValue!, cityValue!);
                    setState(() {
                      startSaving = false;
                    });
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LandingPage()),
                        (route) => false);
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: startSaving == false
                        ? const Center(
                            child: Text(
                              'Save Locations',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
