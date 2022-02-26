import 'package:flutter/material.dart';
import 'package:bisell_olx_clone/Widgets/Buttons/progree_indicating_button.dart';
import 'package:bisell_olx_clone/Constants/constants.dart';

class InformativeBottomSheet extends StatefulWidget {
  final String? information;
  final String title ;
  final GestureTapCallback? onTap;

  const InformativeBottomSheet({Key? key, this.information, this.title = "Done", this.onTap})
      : super(key: key);

  @override
  _InformativeBottomSheetState createState() => _InformativeBottomSheetState();
}

class _InformativeBottomSheetState extends State<InformativeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration:const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Wrap(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kSizedBoxHeight10,
              kSizedBoxHeight10,
              Text(
                widget.title,
                style: kTextStyleHeadline,
              ),
              kSizedBoxHeight10,
              kSizedBoxHeight10,
              Text(widget.information!),
              kSizedBoxHeight10,
              kSizedBoxHeight10,
              ProgressIndicatingButton(
                title: "Okay",
                onTap: widget.onTap ?? () {},
                // onTap: widget.onTap == null ? () {} : widget.onTap,
              )
            ],
          )
        ],
      ),
    );
  }
}
