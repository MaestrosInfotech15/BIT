import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewUserWidget extends StatelessWidget {
  const NewUserWidget(
      {Key? key,
      required this.onClick,
      required this.firstTitle,
      required this.secondTitle})
      : super(key: key);

  final VoidCallback onClick;
  final String firstTitle, secondTitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: firstTitle,
                style: GoogleFonts.quicksand(
                  color: Theme.of(context).hintColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                )),
            TextSpan(
              text: secondTitle,
              style: GoogleFonts.quicksand(
                color: Theme.of(context).primaryColor,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
