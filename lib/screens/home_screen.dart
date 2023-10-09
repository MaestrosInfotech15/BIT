import 'package:book_indian_talents_app/components/custom_dialog_widget.dart';
import 'package:book_indian_talents_app/components/home_bottom_bar.dart';
import 'package:book_indian_talents_app/firebase/firebase_helper.dart';
import 'package:book_indian_talents_app/fragments/booking_fragment.dart';
import 'package:book_indian_talents_app/fragments/home_fragment.dart';
import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:book_indian_talents_app/model/user_chat.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:book_indian_talents_app/provider/file_provider.dart';
import 'package:book_indian_talents_app/screens/artist_booking_history.dart';
import 'package:book_indian_talents_app/screens/login_screen.dart';
import 'package:book_indian_talents_app/screens/update_artist_profile_screen.dart';
import 'package:book_indian_talents_app/screens/update_profile_screen.dart';
import 'package:book_indian_talents_app/services/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../fragments/account_fragment.dart';
import '../fragments/refer_earn_fragment.dart';
import '../provider/api_controller.dart';
import '../provider/app_controller.dart';
import 'artist_dashboard_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _fragment = [
    const HomeFragment(),
    const AccountFragment(),
    const BookingFragment(),
    const ReferEarnFragment(),
  ];

  final _fragmentDashboard = [
    const ArtistDashboardScreen(),
    const AccountFragment(),
    const ArtistBookingHistoryScreen(),
    const ReferEarnFragment(),
  ];

  @override
  void initState() {
    Provider.of<FileProvider>(context,listen: false).initClear();
    // TODO: implement initState
    super.initState();
    showInAppNotification();
    checkLogin();

    if (SessionManager.getProfileUpdate()=='0') {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => showWelcomeDialog());
    }
  }

  void showInAppNotification() {
    FirebaseMessaging.onMessage.listen((message) {
      String body = message.data['body'];
      String title = message.data['title'];
      String image = message.data['image'];

      if (image.isEmpty) {
        NotificationService().showLocalNotification(
          id: notificationId,
          title: title,
          body: body,
          payload: notificationId.toString(),
        );
      } else {
        NotificationService().showLocalNotificationBigPicure(
            id: notificationId,
            title: title,
            body: body,
            payload: notificationId.toString(),
            imageUrl: image);
      }
    });
    notificationId++;
  }

  void showWelcomeDialog() {
    String message = '';
    if (SessionManager.getLoginWith().toString().toLowerCase() == "artist") {
      message =
          'Welcome "${SessionManager.getUserName()}" on BIT, We`re excited to have you on board! complete your profile it will boosts your visibility !';
    } else {
      message =
          'Welcome "${SessionManager.getUserName()}" to BIT! Complete your profile to find and hire the perfect talent !';
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return SuccessDialogWidget(
            title: 'erase',
            message: message,
            onClick: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, UpdateProfileScreen.id);
            },
            btnText: 'OK',
            image: 'welcome.json',
            height: 50,
          );
        });
  }


  Future<bool> _onWillPop() async {
    final data = Provider.of<AppController>(context,listen: false);
    if(data.bottomSelectedIndex!=0){
      data.onBottomSelectedIndex(0);
      return false;
    }
    return true ;
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AppController>(context);
    return WillPopScope(
      onWillPop:_onWillPop ,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: data.isArtistMode
            ? _fragmentDashboard[data.bottomSelectedIndex]
            : _fragment[data.bottomSelectedIndex],
        bottomNavigationBar: HomeBottomBar(
          onTap: (index) {
            /*if(data.isArtistMode){
              if(index==1){
                data.onBottomSelectedIndex(3);
              }else if(index==3){
                data.onBottomSelectedIndex(1);
              }
              return;
            }*/
            data.onBottomSelectedIndex(index);
          },
        ),
      ),
    );
  }

  void checkLogin() {
    Map<String, String> body = {
      'id': SessionManager.getUserId(),
      'type': SessionManager.getLoginWith()
    };

    ApiHelper.checkLogin(body).then((value) {
      if (value.apiStatus!.toLowerCase() == 'true') {
        if (value.data!.blockStatus!.toLowerCase() == '1') {
          SessionManager.logout();
          Navigator.pushNamedAndRemoveUntil(
              context, LoginScreen.id, (route) => false);
        }
      }
    });
  }
}
