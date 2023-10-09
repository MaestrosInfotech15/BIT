import 'package:book_indian_talents_app/components/custom_dialog_widget.dart';
import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/helper/helper.dart';
import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:book_indian_talents_app/model/booking_option.dart';
import 'package:book_indian_talents_app/provider/app_controller.dart';
import 'package:book_indian_talents_app/screens/artist_wallet_screen.dart';
import 'package:book_indian_talents_app/screens/chat_list_screen.dart';
import 'package:book_indian_talents_app/screens/favorite_screen.dart';
import 'package:book_indian_talents_app/screens/home_screen.dart';
import 'package:book_indian_talents_app/screens/login_screen.dart';
import 'package:book_indian_talents_app/screens/notification_screen.dart';
import 'package:book_indian_talents_app/screens/ongoing_booking_screen.dart';
import 'package:book_indian_talents_app/screens/support_chat_screen.dart';
import 'package:book_indian_talents_app/screens/update_artist_profile_screen.dart';
import 'package:book_indian_talents_app/screens/update_profile_screen.dart';
import 'package:book_indian_talents_app/screens/view_artist_profile_screen.dart';
import 'package:book_indian_talents_app/screens/wallet_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../components/neumorphism_widget.dart';
import '../model/show_profile.dart';
import '../network/api_helper.dart';
import '../screens/artist_notification_screen.dart';

class AccountFragment extends StatefulWidget {
  const AccountFragment({super.key});

  @override
  State<AccountFragment> createState() => _AccountFragmentState();
}

class _AccountFragmentState extends State<AccountFragment> {
  bool isArtistMode = false;
  bool isProfile = false;
  String imagePath = '';
  String imageUri = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }
  void getProfile() {
    setState(() {
      isProfile = true;
    });
    ApiHelper.getProfile().then((value) {
      setState(() {
        isProfile = false;
      });
      if (value.apiStatus!.toLowerCase() == 'true') {
        ShowProfileData showProfileData = value.data!;
        imagePath = showProfileData.images ?? '';
        imageUri = value.path!;

        SessionManager.setProfileImage(imageUri + imagePath);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AppController>(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],

      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: 'Profile',
          textColor: Theme
              .of(context)
              .primaryColorLight,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, ArtistNotificationScreen.id);
              },
              icon: const Icon(
                Icons.circle_notifications_rounded,
                color: kAppColor,
                size: 35.0,
              ))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  final data = await Navigator.pushNamed(
                      context, UpdateProfileScreen.id);

                  if (data != null) {
                    if (data == true) {
                      setState(() {
                        getProfile();
                      });
                    }
                  }
                },
                child: NeumorphismWidget(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextWidget(
                              text: '${SessionManager.getUserName()}',
                              textColor: kAppColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            CustomTextWidget(
                              text: '${SessionManager.getUserEmail()}',
                              textColor: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                            const SizedBox(height: 3),
                            CustomTextWidget(
                              text: '${SessionManager.getMobile()}',
                              textColor: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: CachedNetworkImage(
                              width: 75,
                              height: 75,
                              fit: BoxFit.cover,
                              imageUrl:  SessionManager.getProfileImage(),
                              errorWidget: (context, url, error) => Image.asset(
                                '$kLogoPath/boy.png',
                                width: 75,
                                height: 75,
                              ),
                            ),
                          ),
                          const CustomTextWidget(
                            text: 'Edit ',
                            textColor: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: false,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, UpdateArtistProfileScreen.id);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: kAppBarColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.person, color: Colors.black87),
                        SizedBox(width: 10),
                        Expanded(
                          child: CustomTextWidget(
                            text: 'Update Artist Profile',
                            textColor: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.navigate_next_rounded,
                            color: Colors.black87),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Visibility(
                visible: SessionManager.getLoginWith() == 'ARTIST',
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: kAppBarColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.person_pin, color: Colors.black),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: CustomTextWidget(
                          text: 'User Mode/Artist',
                          textColor: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Switch(
                        value: data.isArtistMode,
                        onChanged: (check) {
                          // setState(() {
                          //   isArtistMode = check;
                          // });
                          data.setArtistMode(check);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        focusColor: Colors.white,
                        trackOutlineColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Visibility(
                    visible: SessionManager.getLoginWith()=='ARTIST',
                    child: Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, ArtistWalletScreen.id);
                        },
                        child: const AccountOptionWidget(
                            title: 'Wallet\n', iconData: Icons.wallet),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, FavoriteScreen.id);
                      },
                      child: const AccountOptionWidget(
                        title: 'Favorite\n',
                        iconData: Icons.favorite_border,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, NotificationScreen.id);
                      },
                      child: const AccountOptionWidget(
                        title: 'Notification\n',
                        iconData: Icons.notifications_none,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Visibility(
                    visible: SessionManager.getLoginWith() == 'ARTIST',
                    child: Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, ViewArtistProfileScreen.id);
                        },
                        child: const AccountOptionWidget(
                          title: 'Artist\n'
                              'Profile',
                          iconData: Icons.person,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              NeumorphismWidget(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      return BookingWidgets(
                        bookingOption: BookingOption.bookinglist[index],
                      );
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: BookingOption.bookinglist.length),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                  itemBuilder: (context, index) {
                    return AccountsWidget(
                      accountOption: AccountOption.accountlist[index],
                    );
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: AccountOption.accountlist.length),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountsWidget extends StatefulWidget {
  const AccountsWidget({
    super.key,
    required this.accountOption,
  });

  final AccountOption accountOption;

  @override
  State<AccountsWidget> createState() => _AccountsWidgetState();
}

class _AccountsWidgetState extends State<AccountsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: NeumorphismWidget(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: ListTile(
          leading: Icon(widget.accountOption.image),
          title: CustomTextWidget(
              text: widget.accountOption.title!,
              textColor: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600),
          trailing: const Icon(Icons.navigate_next, color: Colors.grey),
          onTap: () {
            if (widget.accountOption.page == 'Logout') {
              showDialog(
                  context: context,
                  builder: (context) => QuestionDialogWidget(
                      title: 'Logout',
                      message: 'Do you Want to Logout?',
                      onClick: () {
                        Provider.of<AppController>(context, listen: false)
                            .onBottomSelectedIndex(0);
                        SessionManager.setArtistMode(false);
                        SessionManager.logout();
                        Navigator.pushNamedAndRemoveUntil(
                            context, LoginScreen.id, (route) => false);
                      },
                      btnText: 'Yes'));

              return;
            }
            if (widget.accountOption.page == 'Share') {
              Share.share('check out my website https://example.com');
              return;
            }
            if (widget.accountOption.page == 'Delete') {
              showDialog(
                  context: context,
                  builder: (context) => QuestionDialogWidget(
                      title: 'Delete',
                      message: 'Delete Account?',
                      onClick: () {
                        deleteUser();
                      },
                      btnText: 'Yes'));

              return;
            }
            Navigator.pushNamed(context, widget.accountOption.page!,
                arguments: widget.accountOption.title);
          },
        ),
      ),
    );
  }

  void deleteUser() {
    ApiHelper.deleteuser().then((value) {
      Navigator.pop(context);
      if (value.apiStatus!.toLowerCase() == 'true') {
        Helper.showToastMessage('Successfully Delete', Colors.green);
        Provider.of<AppController>(context, listen: false)
            .onBottomSelectedIndex(0);

        SessionManager.setArtistMode(false);
        SessionManager.logout();
        Navigator.pushNamedAndRemoveUntil(
            context, LoginScreen.id, (route) => false);
      } else {
        Helper.showToastMessage(value.result!, Colors.red);
      }
    });
  }
}

class BookingWidgets extends StatelessWidget {
  const BookingWidgets({
    super.key,
    required this.bookingOption,
  });

  final BookingOption bookingOption;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AppController>(context);
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: ListTile(
            leading: Icon(bookingOption.image),
            title: CustomTextWidget(
                text: bookingOption.title!,
                textColor: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600),
            trailing: const Icon(Icons.navigate_next, color: Colors.grey),
            onTap: () {
              if (bookingOption.page == '0') {
                data.onBottomSelectedIndex(2);
                return;
              }
              Navigator.pushNamed(context, bookingOption.page!);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 55),
          child: Divider(
            color: Colors.grey.shade400,
          ),
        ),
      ],
    );
  }
}

class AccountOptionWidget extends StatelessWidget {
  const AccountOptionWidget({
    super.key,
    required this.title,
    required this.iconData,
  });

  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return NeumorphismWidget(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Icon(
            iconData,
            color: kAppColor,
          ),
          const SizedBox(height: 10.0),
          CustomTextWidget(
            textAlign: TextAlign.center,
            text: title,
            textColor: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 10,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
