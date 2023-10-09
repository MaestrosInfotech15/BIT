//todo: light theme colors
import 'package:flutter/material.dart';
const kAppColor = Color(0xFFef1c26); //####ffba01
const kAppcremColor = Color(0xFFffe4df); //####ffba01
const kAppBarColor = Color(0xFFffba01); //####ffba01
const kScaffoldColor = Colors.white;
const kTextColor = Color(0xFF191a1f); //Color(0xFFeeeeee); //#383049
const kSubTextColor = Color(0xFF5F5F61);
const kErrorColor = Color(0xFFFF594D);
const kButtonColor = Color(0xFFef1c26);
const kBottomBarColor = Colors.white;
const kBottomBarIconColor = Color(0xFF10847E);
const kLightGreyColor = Color(0xFFD9D9D9);
const greencolor = Color(0xff083412);
const kCardColor = Colors.grey;
//todo: dark theme color
const kDarkAppColor = Color(0xFF112031); //
const kDarkScaffoldColor = Color(0xFF112031); //#221F40
const kDarkTextColor = Colors.white;
const kDarkSubTextColor = Color(0xFFe3e7eb);
const kDarkErrorColor = Color(0xFFFF594D); //#
const kDarkButtonColor = Color(0xFF10847E);
const kDarkBottomBarColor = Color(0xFF112031);
const kDarkBottomBarIconColor = Colors.white;
const kDarkDividerColor = Color(0xE5112031);

//todo: selected PDF card color
const kSelectedPdf = Color(0xFFE5EAF6);

Map<int, Color> kColorsMap = {
  50: const Color.fromRGBO(255, 92, 87, .1),
  100: const Color.fromRGBO(255, 92, 87, .2),
  200: const Color.fromRGBO(255, 92, 87, .3),
  300: const Color.fromRGBO(255, 92, 87, .4),
  400: const Color.fromRGBO(255, 92, 87, .5),
  500: const Color.fromRGBO(255, 92, 87, .6),
  600: const Color.fromRGBO(255, 92, 87, .7),
  700: const Color.fromRGBO(255, 92, 87, .8),
  800: const Color.fromRGBO(255, 92, 87, .9),
  900: const Color.fromRGBO(213, 43, 59, 1.0),
};

final otpInputDecoration = InputDecoration(
  // fillColor: Colors.grey.shade100,
  // filled: true,
  contentPadding: const EdgeInsets.symmetric(vertical: 15),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide.none,
  );
}
const kAppPlayStore =
    'https://play.google.com/store/apps/details?id=';
const kLogoPath = 'assets/icons';
const kImagePath = 'assets/images';
const kTitle =
    'A PORSCHE 964 CARRERA RS 3.8 IS THE HERO OF THE NEW TRANSFORMERS MOVIE';
const kRestDesc =
    'Upload your prescription which you receive from your doctor to buy medicine at your door steps';
const kabout =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not onlyLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only";

const stateList = [
  'Select State',
  'Andhra Pradesh',
  'Arunachal Pradesh',
  'Assam',
  'Bihar',
  'Chhattisgarh',
  'Goa',
  'Gujarat',
  'Haryana',
  'Himachal Pradesh',
  'Jharkhand',
  'Karnataka',
  'Kerala',
  'Madhya Pradesh',
  'Maharashtra',
  'Manipur',
  'Meghalaya',
  'Mizoram',
  'Nagaland',
  'Odisha',
  'Punjab',
  'Rajasthan',
  'Sikkim',
  'Tamil Nadu',
  'Telangana',
  'Tripura',
  'Uttar Pradesh',
  'Uttarakhand',
  'West Bengal',
  'Andaman and Nicobar Islands',
  'Chandigarh',
  'Dadra and Nagar Haveli and Daman and Diu',
  'Lakshadweep',
  'Delhi',
  'Puducherry',
  'Jammu and Kashmir',
  'Ladakh'
];
