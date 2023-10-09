import 'package:book_indian_talents_app/screens/address_book_screen.dart';
import 'package:book_indian_talents_app/screens/cancelled_booking_screen.dart';
import 'package:book_indian_talents_app/screens/choose_language_screen.dart';
import 'package:book_indian_talents_app/screens/my_rating_screen.dart';
import 'package:book_indian_talents_app/screens/ongoing_booking_screen.dart';
import 'package:book_indian_talents_app/screens/post_booking_screen.dart';
import 'package:book_indian_talents_app/screens/wallet_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/aboutus_screen.dart';
import '../screens/support_booking_screen.dart';

class BookingOption{
  String? title;
  String?page;
  IconData?image;
  BookingOption({this.title,this.image,this.page});
  static List<BookingOption>bookinglist=[
    BookingOption(title:'Upcoming Booking',image: CupertinoIcons.square_list_fill,page:'0'),
    BookingOption(title:'Ongoing Booking',image: CupertinoIcons.info,page: OngoingBookingScreen.id),
    BookingOption(title:'Past Booking',image: Icons.history,page: PastBookingScreen.id),
    BookingOption(title:'Cancelled Booking',image:Icons.cancel,page: CancelledBookingScreen.id),
    BookingOption(title:'Support ',image:Icons.headset_mic,page: SupportBookingScreen.id),
    BookingOption(title:'Address ',image: Icons.book,page: AddressBookScreen.id),

  ];
}
class AccountOption{
  String? title;
  String?page;
  IconData?image;
  AccountOption({this.title,this.image,this.page});
  static List<AccountOption>accountlist=[
    AccountOption(title:'About Me',image: CupertinoIcons.info,page: AboutUsScreen.id),
    AccountOption(title:'Choose Language',image: CupertinoIcons.globe,page: ChooseLanguageScreen.id),
    AccountOption(title:'My Reviews',image: CupertinoIcons.star,page: MyRatingScreen.id),
    AccountOption(title:'Share ',image: Icons.share,page: 'Share'),
    AccountOption(title:'Terms of Services ',image:Icons.shield,page: AboutUsScreen.id),
    AccountOption(title:'Privacy Policy ',image:Icons.shield,page: AboutUsScreen.id),
    AccountOption(title:'Refer & Earn History ',image:Icons.money,page: WalletScreen.id),
    AccountOption(title:'Logout ',image:Icons.power_settings_new,page: 'Logout'),
    AccountOption(title:'Delete Account',image:Icons.delete,page: 'Delete'),


  ];
}