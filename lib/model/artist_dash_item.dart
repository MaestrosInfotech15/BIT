import 'package:book_indian_talents_app/model/artist_info.dart';
import 'package:book_indian_talents_app/screens/artist_booking_history.dart';
import 'package:book_indian_talents_app/screens/artist_wallet_screen.dart';
import 'package:book_indian_talents_app/screens/update_artist_carousel_screen.dart';
import 'package:book_indian_talents_app/screens/update_artist_profile_screen.dart';
import 'package:flutter/material.dart';

import '../screens/artist_add_event_videos_screen.dart';
import '../screens/artist_bank_details_screen.dart';
import '../screens/show_artist_plan_screen.dart';
import '../screens/update_artist_basic_info_screen.dart';
import '../screens/update_availability_screen.dart';

class ArtistDashItem {
  String? title;
  String? subtitle;
  Color? color;
  String? page;
  String? image;
  IconData? icon;

  ArtistDashItem(
      {this.title,
      this.subtitle,
      this.image,
      this.page,
      this.color,
      this.icon});

  static List<ArtistDashItem> accountlist = [
    ArtistDashItem(
        title: 'Basic Info',
        subtitle: '455',
        image: 'assets/images/rupess.png',
        color: Colors.blue.shade400,
        icon: Icons.currency_rupee_rounded,
        page: UpdateArtistBasicInfoScreen.id),
   /* ArtistDashItem(
        title: 'Social info',
        subtitle: '',
        image: 'assets/images/info.png',
        color: Colors.green.shade400,
        icon: Icons.facebook,
        page: UpdateArtistBasicInfoScreen.id),

    */
    ArtistDashItem(
        title: 'Profile Images',
        subtitle: '',
        image: 'assets/images/add_carousel.png',
        color: Colors.purple.shade400,
        icon: Icons.view_carousel_rounded,
        page: UpdateArtistCarouselScreen.id),
    ArtistDashItem(
        title: 'Service & Charges',
        subtitle: '',
        image: 'assets/images/planning.png',
        color: Colors.red.shade400,
        icon: Icons.diamond_rounded,
        page: ShowArtistPlanScreen.id),
    ArtistDashItem(
        title: 'Add Events Photo/Video',
        subtitle: '',
        image: 'assets/images/all_event.png',
        color: Colors.yellow.shade700,
        icon: Icons.add_a_photo,
        page: ArtistAddEventVideoScreen.id),
    ArtistDashItem(
        title: 'Bank Details',
        subtitle: '',
        image: 'assets/images/bank.png',
        color: Colors.orange.shade400,
        icon: Icons.money,
        page: ArtistBankDetailsScreen.id),
    ArtistDashItem(
        title: 'Contact Details',
        subtitle: '',
        image: 'assets/images/call.png',
        color: Colors.brown.shade400,
        icon: Icons.contact_mail,
        page: 'contact'),
    ArtistDashItem(
        title: 'Available Date',
        subtitle: '',
        image: 'assets/images/availability.png',
        color: Colors.pink.shade400,
        icon: Icons.event_note_rounded,
        page: UpdateAvailabilityScreen.id),
   /* ArtistDashItem(
        title: 'My Booking',
        subtitle: '',
        image: 'assets/images/availability.png',
        color: Colors.orange.shade400,
        icon: Icons.history,
        page: ArtistBookingHistoryScreen.id),

    */
    ArtistDashItem(
        title: 'Withdraw Money',
        subtitle: '',
        image: 'assets/images/availability.png',
        color: Colors.deepPurple.shade400,
        icon: Icons.currency_rupee,
        page: ArtistWalletScreen.id),
  ];


}
