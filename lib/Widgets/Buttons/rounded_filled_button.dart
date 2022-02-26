import 'package:bisell_olx_clone/Constants/constants.dart';
import 'package:flutter/material.dart';

class RoundedFilledButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final GestureTapCallback? onButtonClick;
  final Widget? image;

  const RoundedFilledButton({Key? key, this.label, this.icon, this.onButtonClick, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onButtonClick,
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(kButtonCornerRadius),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.center,
              width: 30,
              height: 30,
              child: (icon == null)
                  ? image
                  : Icon(
                icon,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                label!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
