import 'package:flutter/material.dart';
import 'package:bisell_olx_clone/Constants/constants.dart';
class RoundedStrokeButton extends StatelessWidget {
  final String? label;
  final Widget? icon;
  final GestureTapCallback? onClick;
  final Widget? image;

   const RoundedStrokeButton({Key? key,  this.label, this.icon, this.onClick, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(kButtonCornerRadius),
          border: Border.all(color: Colors.black),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.center,
              width: 30,
              height: 30,
              child: (icon == null) ? image : icon,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                label!,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
