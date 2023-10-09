import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchInputWidget extends StatelessWidget {
  const SearchInputWidget({
    Key? key,
    required this.hint,
    required this.onSearchText,
    required this.isEnable,
  }) : super(key: key);

  final String hint;
  final ValueChanged? onSearchText;
  final bool isEnable;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.0,
      child: TextField(
        onChanged: onSearchText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
          prefixIcon: const Icon(Icons.search),
          hintText: hint,
          hintStyle: GoogleFonts.quicksand(
              color: Colors.grey,
              fontSize: 15.0,
              fontWeight: FontWeight.normal),
          filled: true,
          enabled: isEnable,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade100, width: 0.5),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            // borderSide: BorderSide(color: Colors.grey.shade100),
          ),
        ),
      ),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    Key? key,
    required this.onClick,
    required this.onFilterClick,
  }) : super(key: key);

  final VoidCallback onClick;
  final VoidCallback onFilterClick;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: onClick,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 10.0,
                    offset: const Offset(4.0, 4.0),
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    blurRadius: 10.0,
                    offset: Offset(-4.0, -4.0),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 15.0),
                  Expanded(
                    child: CustomTextWidget(
                      text: 'Find Talent',
                      textColor: Theme.of(context).hintColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Icon(
                    Icons.mic_none_rounded,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 15.0),
        InkWell(
          onTap: onFilterClick,
          child: Container(
            height: 45.0,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: kAppBarColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: kAppBarColor.withOpacity(0.2),
                  blurRadius: 10.0,
                  offset: const Offset(4.0, 4.0),
                ),
                const BoxShadow(
                  color: Colors.white,
                  blurRadius: 10.0,
                  offset: Offset(-4.0, -4.0),
                ),
              ],
            ),
            child: Image.asset(
              '$kLogoPath/filter.png',
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
