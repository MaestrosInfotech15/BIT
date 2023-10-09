import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/app_controller.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AppController>(context);
    return Theme(
      data: ThemeData(
        splashColor: Colors.grey.shade200,
            highlightColor: Colors.transparent
      ),
      child: BottomNavigationBar(

        backgroundColor: Colors.white,
        elevation: 3.5,
        onTap: onTap,
        currentIndex: data.bottomSelectedIndex,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedLabelStyle: GoogleFonts.nunito(
          fontSize: 12.0,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).highlightColor,
        ),

        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,

        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                data.isArtistMode ? '$kLogoPath/dash_icon.png':'$kLogoPath/home.png',
                height: 30.0,
              ),
              label: data.isArtistMode ? 'Dashboard' : 'Home'),
           BottomNavigationBarItem(icon:Image.asset(
             '$kLogoPath/profile.png',
             height: 30.0,
           ), label:  'Profile'),
          BottomNavigationBarItem(icon:Image.asset(
            '$kLogoPath/booking.png',
            height: 30.0,
          ), label: 'My Booking'),
          BottomNavigationBarItem(
              icon: Image.asset(
                '$kLogoPath/refer_icon.png',
                height: 30.0,
              ), label: 'Refer'),
        ],
      ),
    );
  }
}

/*
Image.asset(
              '$kLogoPath/bottom_user.png',
              color: Colors.white,
              height: 25.0,
            )
 */
/*
Image.asset(
              '$kLogoPath/bottom_rupee.png',
              color: Colors.white,
              height: 30.0,
            )
 */
/*
  BottomNavigationBarItem(
            icon: Icon(data.isArtistMode ? Icons.dashboard : Icons.home_rounded,
                size: 30.0),
            label: data.isArtistMode ? 'Dashboard' : 'Home'),
         BottomNavigationBarItem(icon: Icon(data.isArtistMode ? Icons.person:Icons.book), label: data.isArtistMode ? 'Profile' : 'My Booking'),
        BottomNavigationBarItem(
            icon: Icon(Icons.currency_rupee_rounded), label: 'Refer'),
        BottomNavigationBarItem(icon: Icon(data.isArtistMode ? Icons.book:Icons.person), label: data.isArtistMode ? 'My Booking' : 'Profile'),

 */