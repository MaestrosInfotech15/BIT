import 'package:book_indian_talents_app/model/categories.dart';
import 'package:book_indian_talents_app/model/sub_category.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';



import 'custom_text_widget.dart';

class StringDropDownWidget extends StatelessWidget {
  const StringDropDownWidget(
      {Key? key,
      required this.initialValue,
      required this.items,
      required this.onChange})
      : super(key: key);

  final String initialValue;
  final List<String> items;
  final ValueChanged onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
              color: Colors.white,
              blurRadius: 5.0,
              offset: -Offset(10.0, 10.0),
              inset: true
          ),
          BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 5.0,
              offset: Offset(10.0, 10),
              inset: true
          ),
        ],
      ),
      child: DropdownButton<String>(
        borderRadius: BorderRadius.circular(12.0),
        iconEnabledColor: Theme.of(context).primaryColorLight,
        dropdownColor: Colors.grey.shade100,
        isExpanded: true,
        value: initialValue,
        style: GoogleFonts.poppins(
            color: Theme.of(context).primaryColorLight,
            fontSize: 14,
            fontWeight: FontWeight.w400),
        underline: const SizedBox(),
        onChanged: onChange,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: CustomTextWidget(
              text: value,
              textColor: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          );
        }).toList(),
      ),
    );
  }
}


class CategoreyDropDownWidget extends StatelessWidget {
  const CategoreyDropDownWidget(
      {Key? key,
      required this.initialValue,
      required this.items,
      required this.onChange})
      : super(key: key);

  final CategoryData initialValue;
  final List<CategoryData> items;
  final ValueChanged onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
              color: Colors.white,
              blurRadius: 5.0,
              offset: -Offset(10.0, 10.0),
              inset: true
          ),
          BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 5.0,
              offset: Offset(10.0, 10),
              inset: true
          ),
        ],
      ),
      child: DropdownButton<CategoryData>(
        borderRadius: BorderRadius.circular(12.0),
        iconEnabledColor: Theme.of(context).primaryColorLight,
        dropdownColor: Colors.grey.shade100,
        isExpanded: true,
        value: initialValue,
        style: GoogleFonts.poppins(
            color: Theme.of(context).primaryColorLight,
            fontSize: 14,
            fontWeight: FontWeight.w400),
        underline: const SizedBox(),
        onChanged: onChange,
        items: items.map<DropdownMenuItem<CategoryData>>((CategoryData value) {
          return DropdownMenuItem<CategoryData>(
            value: value,
            child: CustomTextWidget(
              text: value.name!,
              textColor: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          );
        }).toList(),
      ),
    );
  }
}
class SubCategoreyDropDownWidget extends StatelessWidget {
  const SubCategoreyDropDownWidget(
      {Key? key,
      required this.initialValuesubcat,
      required this.items,
      required this.onChange})
      : super(key: key);

  final SubCategoryData initialValuesubcat;
  final List<SubCategoryData> items;
  final ValueChanged onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
              color: Colors.white,
              blurRadius: 5.0,
              offset: -Offset(10.0, 10.0),
              inset: true
          ),
          BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 5.0,
              offset: Offset(10.0, 10),
              inset: true
          ),
        ],
      ),
      child: DropdownButton<SubCategoryData>(
        borderRadius: BorderRadius.circular(12.0),
        iconEnabledColor: Theme.of(context).primaryColorLight,
        dropdownColor: Colors.grey.shade100,
        isExpanded: true,
        value: initialValuesubcat,
        style: GoogleFonts.poppins(
            color: Theme.of(context).primaryColorLight,
            fontSize: 14,
            fontWeight: FontWeight.w400),
        underline: const SizedBox(),
        onChanged: onChange,
        items: items.map<DropdownMenuItem<SubCategoryData>>((SubCategoryData value) {
          return DropdownMenuItem<SubCategoryData>(
            value: value,
            child: CustomTextWidget(
              text: value.subName!,
              textColor: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          );
        }).toList(),
      ),
    );
  }
}

