import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:flutter/material.dart';


class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.radius = 3.0
  }) : super(key: key);

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: SizedBox(

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              activeColor: kAppColor,
              checkColor: Colors.white,
              side:  BorderSide(color: Theme.of(context).primaryColor),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius)),
              value: value,
              onChanged: (bool? newValue) {
                onChanged(newValue!);
              },
            ),
            Flexible(
              child: CustomTextWidget(
                text: label,
                textColor: kTextColor,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}