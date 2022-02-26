import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bisell_olx_clone/Constants/constants.dart';

class ResponsiveButton extends StatefulWidget {
  final GestureTapCallback onTap;
  final String label;
  final bool enabled;

  @override
  ResponsiveButtonState createState() => ResponsiveButtonState();

  const ResponsiveButton({Key? key,required this.onTap, required this.label, this.enabled= false})
      : super(key: key);
}

class ResponsiveButtonState extends State<ResponsiveButton> {
  bool isEnabled=false;

  void enableButton() {
      if (kDebugMode) {
        print('Button enabled');
      }
    setState(() {
      isEnabled = true;
    });
  }

  void disableButton() {
    // if (kDebugMode) {
    //   print('Button disabled');
    // }
    setState(() {
      isEnabled = false;
    });
  }

  @override
  void initState() {
    super.initState();
    isEnabled = widget.enabled;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: isEnabled ? Colors.blue : Colors.grey,
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          child: Center(
            child: Text(
              widget.label,
              style: kTextStyleButton,
            ),
          ),
        ),
      ),
    );
  }
}
