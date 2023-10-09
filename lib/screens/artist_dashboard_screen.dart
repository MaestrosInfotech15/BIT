import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:book_indian_talents_app/model/artist_dash_item.dart';
import 'package:book_indian_talents_app/model/booking.dart';
import 'package:book_indian_talents_app/provider/api_controller.dart';
import 'package:book_indian_talents_app/provider/app_controller.dart';
import 'package:book_indian_talents_app/screens/artist_booking_history.dart';
import 'package:book_indian_talents_app/screens/artist_wallet_screen.dart';
import 'package:book_indian_talents_app/screens/update_artist_profile_screen.dart';
import 'package:book_indian_talents_app/screens/update_profile_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../components/custom_loader_widget.dart';
import '../components/custom_text_widget.dart';
import '../components/neumorphism_widget.dart';
import '../helper/constants.dart';
import '../model/booking_count.dart';
import '../model/show_profile.dart';
import '../model/total_wallet.dart';
import '../network/api_helper.dart';
import '../widgets/artist_dash_board_widget.dart';
import 'artist_notification_screen.dart';

class ArtistDashboardScreen extends StatefulWidget {
  const ArtistDashboardScreen({super.key});

  @override
  State<ArtistDashboardScreen> createState() => _ArtistDashboardState();
}

class _ArtistDashboardState extends State<ArtistDashboardScreen> {
  late Future<TotalWallet> walletfuture;
  late Future<BookingCount> bookingcountfuture;

  late Future<void> dashboardFuture;
  bool isProfile = false;
  String imagePath = '';
  String imageUri = '';

  Future<TotalWallet> totalamount() async {
    return ApiHelper.totalamount();
  }

  Future<BookingCount> getbookingcount() async {
    return ApiHelper.bookingCount();
  }

  Future<void> getdashboard() async {
    return Provider.of<ApiController>(context, listen: false).getDashboard();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    walletfuture = totalamount();
    dashboardFuture = getdashboard();
    bookingcountfuture = getbookingcount();
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
        print(imageUri + imagePath);
        SessionManager.setProfileImage(imageUri + imagePath);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final apidata = Provider.of<ApiController>(context);
    final data = Provider.of<AppController>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: 'Dashboard',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const SizedBox(height: 12),
          NeumorphismWidget(
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
                        imageUrl: data.profileImage,
                        errorWidget: (context, url, error) =>
                            Image.asset(
                              '$kLogoPath/boy.png',
                              width: 75,
                              height: 75,
                            ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          NeumorphismWidget(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/dashboard.png',
                  width: 25,
                  height: 25,
                ),
                SizedBox(
                  width: 5,
                ),
                CustomTextWidget(
                  text: 'My Earning',
                  textColor: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            CustomTextWidget(
                              text: 'Total earning',
                              textColor: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),

                            FutureBuilder<TotalWallet>(
                                future: walletfuture,
                                builder: (context, response) {
                                  if (response.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container(
                                      padding:const EdgeInsets.only(
                                          top: 15.0, bottom: 18) ,
                                      child: CustomTextWidget(
                                        text:
                                        '₹${0}',
                                        textColor: Colors.white,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 25.0,
                                      ),
                                    );
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15.0, bottom: 18),
                                    child: CustomTextWidget(
                                      text:
                                      '₹${response.data!
                                          .totalAmount ??0}',
                                      textColor: Colors.white,
                                      textAlign: TextAlign.center,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 25.0,
                                    ),
                                  );
                                }),

                          ],
                        ),
                        decoration: BoxDecoration(
                          color: kAppColor,
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)),
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                            context, ArtistWalletScreen.id);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10),
                        decoration: BoxDecoration(
                          color: kAppBarColor,
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)),
                        ),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            CustomTextWidget(
                              text: ' Upcoming bookings',
                              textColor: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                            FutureBuilder<BookingCount>(
                              future: bookingcountfuture,
                              builder: (context, response) {
                                if (response.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                    padding: EdgeInsets.only(
                                        top: 15.0, bottom: 18),
                                    child: const CustomTextWidget(
                                      text:
                                      '${0}',
                                      textColor: Colors.white,
                                      textAlign: TextAlign.start,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 25.0,
                                    ),
                                  );
                                }
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: 15.0, bottom: 18),
                                  child: CustomTextWidget(
                                    text:
                                    '${response.data!.bookingCount ?? 0}',
                                    textColor: Colors.white,
                                    textAlign: TextAlign.start,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25.0,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context,
                            ArtistBookingHistoryScreen.id);
                      },
                    ),
                  )
                ],
              ),
              // child: Row(
              //   children: [
              //     Expanded(
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           const SizedBox(height: 20.0),
              //           CustomTextWidget(
              //             text: 'Todays Earning',
              //             textColor: Colors.black,
              //             textAlign: TextAlign.center,
              //             fontWeight: FontWeight.w700,
              //             fontSize: 13.0,
              //           ),
              //           CustomTextWidget(
              //             text: '100',
              //             textColor: kAppColor,
              //             textAlign: TextAlign.center,
              //             fontWeight: FontWeight.w700,
              //             fontSize: 18.0,
              //           ),
              //           SizedBox(height: 20.0),
              //         ],
              //       ),
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         const SizedBox(height: 20.0),
              //         CustomTextWidget(
              //           text: 'Total Earning',
              //           textColor: Colors.black,
              //           textAlign: TextAlign.center,
              //           fontWeight: FontWeight.w700,
              //           fontSize: 13.0,
              //         ),
              //         CustomTextWidget(
              //           text: '100',
              //           textColor: kAppColor,
              //           textAlign: TextAlign.center,
              //           fontWeight: FontWeight.w700,
              //           fontSize: 18.0,
              //         ),
              //         SizedBox(height: 20.0),
              //       ],
              //     ),
              //   ],
              // ),
            ),
          ),

          ],
        ),
      ),
      SizedBox(height: 15),
      Padding(
        padding: const EdgeInsets.only(left: 9.0),
        child: CustomTextWidget(
          text: 'Account Details',
          textColor: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      AlignedGridView.count(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: ArtistDashItem.accountlist.length,
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemBuilder: (context, index) {
          return ArtistDashboardWidget(
            artistDashItem: ArtistDashItem.accountlist[index],
          );
        },
      ),
      /* FutureBuilder(
                future:dashboardFuture,
                builder: (context, snapshot) {
                if(snapshot.connectionState==ConnectionState.waiting){
                  return CustomLoaderWidget();
                }
                return AlignedGridView.count(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 25.0),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: apidata.artistDashList.length,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  itemBuilder: (context, index) {
                    return ArtistDashboardWidget(
                      artistDashItem:apidata.artistDashList[index],
                    );
                  },
                );
              },)

              */
      ],
    ),)
    ,
    )
    ,
    );
  }
}
