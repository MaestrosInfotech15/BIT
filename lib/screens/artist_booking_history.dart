import 'package:book_indian_talents_app/fragments/artist_cancelled_fragment.dart';
import 'package:book_indian_talents_app/fragments/artist_completed_fragment.dart';
import 'package:book_indian_talents_app/fragments/artist_ongoing_fragment.dart';
import 'package:book_indian_talents_app/fragments/artist_upcoming_fragment.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/custom_text_widget.dart';
import '../helper/constants.dart';

class ArtistBookingHistoryScreen extends StatefulWidget {
  static const String id = ' artist_booking_history_screen';

  const ArtistBookingHistoryScreen({super.key});

  @override
  State<ArtistBookingHistoryScreen> createState() =>
      _ArtistBookingHistoryScreenState();
}

class _ArtistBookingHistoryScreenState extends State<ArtistBookingHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _tabs = const [
    Tab(text: 'Upcoming'),
    Tab(text: 'Ongoing'),
    Tab(text: 'Cancelled'),
    Tab(text: 'Completed'),
  ];

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: 'Artist Booking History',
          textColor: Theme.of(context).primaryColorLight,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 45.0,
            padding: const EdgeInsets.all(3.0),
            margin:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TabBar(
              labelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, fontSize: 12),
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: true,
              controller: _tabController,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Theme.of(context).primaryColor),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: _tabs,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ArtistUpcomingFragement(),
                ArtistOngoingFragment(),
                ArtistCancelledFragment(),
                ArtistCompletedFragment(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
