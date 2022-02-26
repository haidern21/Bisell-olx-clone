import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryItem extends StatelessWidget {
  final Color bgColor;
  final String catIconAddress;
  final String catName;
  const CategoryItem({required this.bgColor, required this.catIconAddress, required this.catName,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: bgColor,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(catIconAddress),
            ),
          ),
           Text(
            catName,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
        ],
      ),
    );
  }
}
