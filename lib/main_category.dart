import 'package:flutter/material.dart';

class MainCategory {
  final String catName;
  final String catIconAddress;
  final Color bgColor;
  List<String>? subCategories;
  Map<String, dynamic>? sellOptions;

  MainCategory(
      {required this.catName,
      required this.catIconAddress,
      required this.bgColor,
      this.subCategories,
      this.sellOptions,
      });
}

List<MainCategory> ALL_CATEGORIES = [
  MainCategory(
      catName: 'Laptop',
      catIconAddress: 'assets/category_icons/laptop.svg',
      bgColor: Colors.red,
      subCategories: ['Laptop','Laptop Bags', 'Laptop Chargers', 'Laptop Batteries','Laptop Stand'],
      sellOptions: {
        'Laptop': [condition,techBrands,ramCapacityOption,storageOption,screenOption],
        'Laptop Bags':[condition,],
        'Laptop Chargers':[condition,],
        'Laptop Batteries':[condition,],
        'Laptop Stand':[condition],
      },
  ),
  MainCategory(
      catName: 'Casing',
      catIconAddress: 'assets/category_icons/casing.svg',
      bgColor: Colors.blue,
      subCategories: ['Desktop', 'Tower',],
      sellOptions: {
        'Desktop': [condition,rbg],
        'Tower':[condition,rbg],
      },
   ),
  MainCategory(
      catName: 'Storage',
      catIconAddress: 'assets/category_icons/storage.svg',
      bgColor: Colors.teal,
      subCategories: ['SSD', 'HDD', 'Flash','External Storage'],
      sellOptions: {
        'SSD':[condition,storageOption,techBrands],
        'HDD':[condition,storageOption,techBrands],
        'Flash':[condition,storageOption,techBrands],
        'External Storage': [condition,storageOption,techBrands],
      },
  ),
  MainCategory(
      catName: 'CPU',
      catIconAddress: 'assets/category_icons/cpu.svg',
      bgColor: Colors.amber,
      subCategories: ['AMD', 'Intel', 'Other'],
      sellOptions: {
        'AMD':[condition,processorSpeedOption,numberOfCores],
        'Intel':[condition,processorSpeedOption,numberOfCores],
        'Other':[condition,processorSpeedOption,numberOfCores],
      },
  ),
  MainCategory(
      catName: 'GPU',
      catIconAddress: 'assets/category_icons/gpu.svg',
      bgColor: Colors.brown,
      subCategories: ['Nvidia', 'AMD', 'ASUS','Intel','EVGA','Gigabyte','Sapphire','Zotac','Other'],
      sellOptions: {
        'Nvidia':[condition,graphicCardMemory,videoMemoryType,bitRateOption,rbg],
        'AMD':[condition,graphicCardMemory,videoMemoryType,bitRateOption,rbg],
        'ASUS':[condition,graphicCardMemory,videoMemoryType,bitRateOption,rbg],
        'Intel':[condition,graphicCardMemory,videoMemoryType,bitRateOption,rbg],
        'EVGA':[condition,graphicCardMemory,videoMemoryType,bitRateOption,rbg],
        'Gigabyte':[condition,graphicCardMemory,videoMemoryType,bitRateOption,rbg],
        'Sapphire':[condition,graphicCardMemory,videoMemoryType,bitRateOption,rbg],
        'Zotac':[condition,graphicCardMemory,videoMemoryType,bitRateOption,rbg],
        'Other':[condition,graphicCardMemory,videoMemoryType,bitRateOption,rbg],
      },
  ),
  MainCategory(
      catName: 'Headphone',
      catIconAddress: 'assets/category_icons/headphone.svg',
      bgColor: Colors.cyan,
      subCategories: ['Over Ear', 'On Ear', 'In Ear','Other'],
      sellOptions: {
        'Over Ear':[condition,brandOptions],
        'On Ear':[condition,brandOptions],
        'In Ear':[condition,brandOptions],
        'Other':[condition,brandOptions],
      },
  ),
  MainCategory(
      catName: 'Speakers',
      catIconAddress: 'assets/category_icons/speaker.svg',
      bgColor: Colors.deepOrange,
      subCategories: ['Wireless Speakers', 'Wired Speakers', ],
      sellOptions: {
        'Wireless Speakers':[condition,brandOptions],
        'Wired Speakers':[condition,brandOptions],
      },
  ),
  MainCategory(
      catName: 'RAM',
      catIconAddress: 'assets/category_icons/ram.svg',
      bgColor: Colors.green,
      subCategories: ['DDR2', 'DDR3', 'DDR4','Other'],
      sellOptions: {
        'DDR2':[condition,ramCapacityOption,_ramCompanyOption,_ramSpeedOption,_ramNumberOfChipsOption,rbg],
        'DDR3':[condition,ramCapacityOption,_ramCompanyOption,_ramSpeedOption,_ramNumberOfChipsOption,rbg],
        'DDR4':[condition,ramCapacityOption,_ramCompanyOption,_ramSpeedOption,_ramNumberOfChipsOption,rbg],
        'Other':[condition,ramCapacityOption,_ramCompanyOption,_ramSpeedOption,_ramNumberOfChipsOption,rbg],
      },
  ),
  MainCategory(
      catName: 'Mouse',
      catIconAddress: 'assets/category_icons/mouse.svg',
      bgColor: Colors.indigo,
      subCategories: ['Wired Mouse', 'Wireless Mouse',],
      sellOptions: {
        'Wired Mouse':[condition,_mouseCompanies,_isGamingMouse,],
        'Wireless Mouse':[condition,_mouseCompanies,_isGamingMouse,_batteryBackup,_powerSource,_isRechargeable],
      },
  ),
  MainCategory(
      catName: 'Monitor',
      catIconAddress: 'assets/category_icons/monitor.svg',
      bgColor: Colors.lime,
      subCategories: ['18.5\" - 19\"', '21.5\" - 22\"','23\" - 24\"','24.5\" - 25\"','27\" - 28\"','31\" - 32\"','34\"','35\"','49\"','55\"',],
      sellOptions: {
        '18.5\" - 19\"':[condition,_monitorCompaneis,_monitorAspectRatio,_monitorResolution,_monitorRefreshRate],
        '21.5\" - 22\"':[condition,_monitorCompaneis,_monitorAspectRatio,_monitorResolution,_monitorRefreshRate],
        '23\" - 24\"':[condition,_monitorCompaneis,_monitorAspectRatio,_monitorResolution,_monitorRefreshRate],
        '24.5\" - 25\"':[condition,_monitorCompaneis,_monitorAspectRatio,_monitorResolution,_monitorRefreshRate],
        '27\" - 28\"':[condition,_monitorCompaneis,_monitorAspectRatio,_monitorResolution,_monitorRefreshRate],
        '31\" - 32\"':[condition,_monitorCompaneis,_monitorAspectRatio,_monitorResolution,_monitorRefreshRate],
        '34\"':[condition,_monitorCompaneis,_monitorAspectRatio,_monitorResolution,_monitorRefreshRate],
        '35\"':[condition,_monitorCompaneis,_monitorAspectRatio,_monitorResolution,_monitorRefreshRate],
        '49\"':[condition,_monitorCompaneis,_monitorAspectRatio,_monitorResolution,_monitorRefreshRate],
        '55\"':[condition,_monitorCompaneis,_monitorAspectRatio,_monitorResolution,_monitorRefreshRate],
      },
  ),
];
var optionForLaptop={
  'laptop': [condition.options,],
  'bags':[condition,],
};
class Options{
  final String title;
  final List<String> options;
  final String? key;
  Options({this.key,required this.options, required this.title});
}
Options condition= Options(options: ['New', 'Used'], title: 'Condition',key: 'laptop');

Options brandOptions = Options(title: "Brand", options: [
//brandOptions being used for Speakers and headphones
  "Logitext",
  "DexPod",
  "Audionic",
  "M-Audio",
  "Anker",
  "Apple",
  "JBL",
  "Edifier"
]);


Options processorSpeedOption = Options(title: "Speed", options: [
  "1 - 1.59 Ghz",
  "1.60 - 1.79 Gzh",
  "1.80 - 1.99 Ghz",
  "2.0 - 2.49 Ghz",
  "2.5 - 2.9 Ghz",
  "3.0 - 3.49 Ghz",
  "3.5 - 3.99 Ghz",
  "4 Ghz & above",
  "Other"
]);

Options numberOfCores =
Options(title: "Cores", options: ["Single Core", "Dual Code", "Quad Core"]);

Options storageOption = Options(
  title: 'Storage',
  options: ['250 GB', '500 GB', '1 TB', '2 TB', "Other"],
);

Options techBrands = Options(
  //teachBrands is being used by Laptops and Storage
  title: 'Company',
  options: ['Apple', 'Accer', 'HP', 'Lenovo', 'Asus', 'MSI', 'Razer', "Other"],
);

Options rbg = Options(
  //RGB is being used by Casing, Graphic Card, RAM
  title: "RGB",
  options: ["Yes", "No"],
);
Options ramCapacityOption = Options(
  title: 'RAM Capacity',
  options: ['4 GB', '8 GB', '16 GB', '32 Gb', '64 GB', "Other"],
);
Options screenOption= Options(title : 'Screen Size', options: ['13\"', "15\"", "17\"", "Other"]);
Options bitRateOption = Options(title: "Bit Rate", options: [
  "64 bit",
  "128 bit",
  "160 bit",
  "192 bit",
  "256 bit",
  "384 bit",
  "Other"
]);
Options videoMemoryType = Options(
    title: "Video memory type",
    options: ["GDD5", "GDDR5X", "GDD6X", "GDD6", "Other"]);
Options graphicCardMemory = Options(
    title: "Memory",
    options: ["1 GB", "2 GB", "4 GB", "8 GB", "16 GB", "Other"]);

Options _ramCompanyOption = Options(
  title: 'RAM Company',
  options: [
    'ADATA',
    'Corsair',
    'G.Skill',
    'Gigabyte',
    'HIKVision',
    'HP',
    'Kingston',
    'Other'
  ],
);

Options _ramSpeedOption = Options(title: "RAM Speed", options: [
  '1600 Mhz',
  '2666 Mhz',
  '3200 Mhz',
  '3600 Mhz',
  '3333 Mhz',
  'Other'
]);
Options _ramNumberOfChipsOption = Options(
  title: 'Number of Chips',
  options: ['1', '2', '3', '4', 'Other'],
);
Options _mouseCompanies = Options(title: 'Company', options: [
  'Apple',
  'HP',
  'IBM',
  'Logitech',
  'A4 Tech',
  'Razer',
  'Steelseries',
  'Cougar',
  'Philips'
]);

Options _isGamingMouse = Options(title: 'Gaming Mouse?', options: ['Yes', 'No']);
Options _batteryBackup = Options(
  title: 'Battery Backup',
  options: [
    'Less than 1 hour',
    '1 Hour',
    '3 Hours',
    '5 Hours',
    '8 Hours',
    'More than 8 hours',
    'Other'
  ],
);

Options _powerSource = Options(
    title: 'Power Source', options: ['Built-in Battery', 'External Cell']);
Options _isRechargeable = Options(title: 'Rechargeable', options: ['Yes', 'No']);
Options _monitorAspectRatio = Options(title: 'Aspect Ratio', options: [
  '1:1',
  '16:9',
  '21:9',
  '32:9',
  'Other',
]);

Options _monitorResolution = Options(title: 'Resolution', options: [
  'HD',
  'FHD',
  '2K',
  'UW',
  '4K',
]);
Options _monitorRefreshRate = Options(title: 'Refresh Rate', options: [
  '50 - 75Mhz',
  '100 Mhz',
  '120 Mhz',
  '144 Mhz',
  '164 Mhz',
  '240 Mhz',
  'Other'
]);

Options _monitorCompaneis = Options(title: 'Company', options: [
  'Apple',
  'AOC',
  'BenQ',
  'Dell',
  'Gigabyte',
  'HP',
  'MSI',
  'Philips',
  'Redragon',
  'Samsung',
  'Other'
]);