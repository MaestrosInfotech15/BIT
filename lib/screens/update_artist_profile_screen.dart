import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/components/neumorphism_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:book_indian_talents_app/model/artist_detail.dart';
import 'package:book_indian_talents_app/model/artist_info.dart';
import 'package:book_indian_talents_app/model/show_addplan.dart';
import 'package:book_indian_talents_app/model/show_carousel.dart';
import 'package:book_indian_talents_app/screens/artist_booking_history.dart';
import 'package:book_indian_talents_app/screens/artist_notification_screen.dart';
import 'package:book_indian_talents_app/screens/update_artist_basic_info_screen.dart';
import 'package:book_indian_talents_app/screens/update_artist_carousel_screen.dart';
import 'package:book_indian_talents_app/screens/upload_bank_details_screen.dart';
import 'package:book_indian_talents_app/widgets/add_event_bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../components/custom_button_widget.dart';
import '../components/custom_text_field_widget.dart';
import '../helper/helper.dart';
import '../helper/size_config.dart';
import '../model/bank_details.dart';
import '../network/api_helper.dart';
import '../widgets/add_plan_widget.dart';
import '../widgets/show_bank_details_widget.dart';
import '../widgets/show_plan_widget.dart';
import '../widgets/show_video_widget.dart';

class UpdateArtistProfileScreen extends StatefulWidget {
  static const String id = 'update_artist_profile_screen';

  const UpdateArtistProfileScreen({super.key});

  @override
  State<UpdateArtistProfileScreen> createState() =>
      _UpdateArtistProfileScreenState();
}

class _UpdateArtistProfileScreenState extends State<UpdateArtistProfileScreen> {

  late Future<ShowAddPlan> showPlanfuture;
  late Future<ArtistInfo> basicInfoFuture;
  late Future<ShowCarousel> carouselFuture;
  late Future<ArtistDetail> artistInfoFuture;
  late Future<BankDetails> bankdetailsfuture;

 // DateRangePickerController _datesMultipleController = DateRangePickerController();
  List<String> carouselImageList = [];
  List<DateTime> selectedDates = [];
  List<String> selectedDateStrings = [];
  String selectedDateText = '';
  String selectedDatesAsString='';
  bool isdate = false;
  Future<ShowAddPlan> showplan() async {
    return ApiHelper.showPlan(SessionManager.getUserId());
  }

  Future<ArtistInfo> getArtistInfo() async {
    return ApiHelper.getArtistBasicInfo();
  }

  Future<ShowCarousel> getCarouselImages() async {
    return ApiHelper.getCarouselImages();
  }

  Future<ArtistDetail> getArtistDetail() async {
    return ApiHelper.getArtistDetail(SessionManager.getUserId());
  }

  Future<BankDetails> viewBankDetails() async {
    return ApiHelper.getbankDetails();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showPlanfuture = showplan();
    basicInfoFuture = getArtistInfo();
    carouselFuture = getCarouselImages();
    artistInfoFuture = getArtistDetail();
    bankdetailsfuture = viewBankDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: 'Dashboard',
          textColor: Theme.of(context).primaryColorLight,
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
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 25.0),
            Visibility(
              visible: false,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: kAppColor),
                child: Row(
                  children: [
                    const SizedBox(width: 10.0),
                    const Expanded(
                      child: CustomTextWidget(
                        text: 'Artist Booking History',
                        textColor: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            side: const BorderSide(
                                color: Colors.white, width: 0.5),
                            minimumSize: const Size(80.0, 30.0)),
                        onPressed: () async {
                          final data = await Navigator.pushNamed(
                              context, ArtistBookingHistoryScreen.id);

                          if (data != null) {
                            if (data == true) {
                              setState(() {
                                basicInfoFuture = getArtistInfo();
                              });
                            }
                          }
                        },
                        child: const CustomTextWidget(
                          text: 'View',
                          textColor: Colors.white,
                          fontSize: 12.0,
                        )),
                    const SizedBox(width: 10.0)
                  ],
                ),
              ),
            ),
            NeumorphismWidget(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.0),
                  Container(
                    decoration: const BoxDecoration(
                        color: kAppColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16.0),
                          topLeft: Radius.circular(16.0),
                        )),
                    child: Row(
                      children: [
                        const SizedBox(width: 10.0),
                        const Expanded(
                          child: CustomTextWidget(
                            text: 'Basic Charges',
                            textColor: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                                side: const BorderSide(
                                    color: Colors.white, width: 0.5),
                                minimumSize: const Size(80.0, 30.0)),
                            onPressed: () async {
                              final data = await Navigator.pushNamed(
                                  context, UpdateArtistBasicInfoScreen.id);

                              if (data != null) {
                                if (data == true) {
                                  setState(() {
                                    basicInfoFuture = getArtistInfo();
                                  });
                                }
                              }
                            },
                            child: const CustomTextWidget(
                              text: 'Edit',
                              textColor: Colors.white,
                              fontSize: 12.0,
                            )),
                        const SizedBox(width: 10.0)
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  FutureBuilder<ArtistInfo>(
                    future: basicInfoFuture,
                    builder: (context, response) {
                      if (response.connectionState == ConnectionState.waiting) {
                        return const CustomLoaderWidget();
                      }
                      ArtistInfoData info = response.data!.data!;
                      return Column(
                        children: [
                          BasicInfoWidget(
                            text:
                                '₹${info.fee ?? 'Update Fees'.replaceAll('₹', '')}',
                            image: 'bottom_rupee.png',
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
            const SizedBox(height: 25.0),
            NeumorphismWidget(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.0),
                  Container(
                    decoration: const BoxDecoration(
                        color: kAppColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16.0),
                          topLeft: Radius.circular(16.0),
                        )),
                    child: Row(
                      children: [
                        const SizedBox(width: 10.0),
                        const Expanded(
                          child: CustomTextWidget(
                            text: 'Basic Info',
                            textColor: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                                side: const BorderSide(
                                    color: Colors.white, width: 0.5),
                                minimumSize: const Size(80.0, 30.0)),
                            onPressed: () async {
                              final data = await Navigator.pushNamed(
                                  context, UpdateArtistBasicInfoScreen.id);

                              if (data != null) {
                                if (data == true) {
                                  setState(() {
                                    basicInfoFuture = getArtistInfo();
                                  });
                                }
                              }
                            },
                            child: const CustomTextWidget(
                              text: 'Edit',
                              textColor: Colors.white,
                              fontSize: 12.0,
                            )),
                        const SizedBox(width: 10.0)
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  FutureBuilder<ArtistInfo>(
                    future: basicInfoFuture,
                    builder: (context, response) {
                      if (response.connectionState == ConnectionState.waiting) {
                        return const CustomLoaderWidget();
                      }
                      ArtistInfoData info = response.data!.data!;
                      return Column(
                        children: [
                          // BasicInfoWidget(
                          //   text:
                          //       '₹${info.fee ?? 'Update Fees'.replaceAll('₹', '')}',
                          //   image: 'bottom_rupee.png',
                          // ),
                          const SizedBox(height: 15.0),
                          BasicInfoWidget(
                            text: info.instagram ?? 'Update Info',
                            image: 'instagram.png',
                          ),
                          const SizedBox(height: 15.0),
                          BasicInfoWidget(
                            text: info.facebook ?? 'Update Info',
                            image: 'facebook.png',
                          ),
                          const SizedBox(height: 15.0),
                          BasicInfoWidget(
                            text: info.youtube ?? 'Update Info',
                            image: 'youtube.png',
                          ),
                          const SizedBox(height: 15.0),
                          BasicInfoWidget(
                            text: info.linkedin ?? 'Update Info',
                            image: 'linkedin.png',
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),

            const SizedBox(height: 25.0),
            //todo: Add carousel image
            NeumorphismWidget(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: kAppColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16.0),
                          topLeft: Radius.circular(16.0),
                        )),
                    child: Row(
                      children: [
                        const SizedBox(width: 10.0),
                        const Expanded(
                          child: CustomTextWidget(
                            text: 'Add Carousel Images',
                            textColor: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                                side: const BorderSide(
                                    color: Colors.white, width: 0.5),
                                minimumSize: const Size(80.0, 30.0)),
                            onPressed: () async {
                              final data = await Navigator.pushNamed(
                                  context, UpdateArtistCarouselScreen.id,
                                  arguments: carouselImageList);

                              if (data != null) {
                                if (data == true) {
                                  setState(() {
                                    carouselFuture = getCarouselImages();
                                  });
                                }
                              }
                            },
                            child: const CustomTextWidget(
                              text: 'Add Images',
                              textColor: Colors.white,
                              fontSize: 12.0,
                            )),
                        const SizedBox(width: 10.0)
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  FutureBuilder<ShowCarousel>(
                      future: carouselFuture,
                      builder: (context, response) {
                        if (response.connectionState ==
                            ConnectionState.waiting) {
                          return const CustomLoaderWidget();
                        }

                        if (response.data!.apiStatus!.toLowerCase() ==
                            'false') {
                          return const Center(
                            child: CustomTextWidget(
                                text: 'No Image Uploaded',
                                textColor: Colors.red),
                          );
                        }

                        carouselImageList = response.data!.data!;
                        if (carouselImageList.isEmpty) {
                          return const Center(
                            child: CustomTextWidget(
                                text: 'No Image Uploaded',
                                textColor: Colors.red),
                          );
                        }

                        return SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              response.data!.data!.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: CachedNetworkImage(
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    imageUrl: response.data!.path! +
                                        carouselImageList[index],
                                    placeholder: (context, url) =>
                                        const CustomLoaderWidget(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.broken_image),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
            const SizedBox(height: 25.0),
            //todo: Add Plan container
            NeumorphismWidget(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: kAppColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16.0),
                          topLeft: Radius.circular(16.0),
                        )),
                    child: Row(
                      children: [
                        const SizedBox(width: 10.0),
                        const Expanded(
                          child: CustomTextWidget(
                            text: 'All Plans',
                            textColor: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                                side: const BorderSide(
                                    color: Colors.white, width: 0.5),
                                minimumSize: const Size(80.0, 30.0)),
                            onPressed: () {
                              showDialog(
                                      context: context,
                                      builder: (context) =>
                                          const AddPlanDialogWidget())
                                  .then((value) {
                                if (value != null) {
                                  if (value == true) {
                                    setState(() {
                                      showPlanfuture = showplan();
                                    });
                                  }
                                }
                              });
                            },
                            child: const CustomTextWidget(
                              text: 'Add Plan',
                              textColor: Colors.white,
                              fontSize: 12.0,
                            )),
                        const SizedBox(width: 10.0),
                      ],
                    ),
                  ),
                  FutureBuilder<ShowAddPlan>(
                      future: showPlanfuture,
                      builder: (context, response) {
                        if (response.connectionState ==
                            ConnectionState.waiting) {
                          return const CustomLoaderWidget();
                        }
                        if (response.data!.apiStatus!.toLowerCase() ==
                            'false') {
                          return const Center(
                            child: CustomTextWidget(
                                text: 'No Plan added', textColor: Colors.red),
                          );
                        }
                        List<ShowPlanData> showPlanlist = response.data!.data!;

                        if (showPlanlist.isEmpty) {
                          return const Center(
                            child: CustomTextWidget(
                                text: 'No Plan added', textColor: Colors.red),
                          );
                        }

                        return ListView.separated(
                          separatorBuilder: (context, index) => const Divider(),
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ShowPlanWidget(
                              showPlanData: showPlanlist[index],
                              onTap: () {
                                deleteArtistPlan(showPlanlist[index].id!);
                              },
                            );
                          },
                          shrinkWrap: true,
                          itemCount: showPlanlist.length,
                        );
                      })
                ],
              ),
            ),
            const SizedBox(height: 25.0),
            //todo: Add Events
            NeumorphismWidget(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: kAppColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16.0),
                          topLeft: Radius.circular(16.0),
                        )),
                    child: Row(
                      children: [
                        const SizedBox(width: 10.0),
                        const Expanded(
                          child: CustomTextWidget(
                            text: 'Add Event Videos/Photos',
                            textColor: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                                side: const BorderSide(
                                    color: Colors.white, width: 0.5),
                                minimumSize: const Size(80.0, 30.0)),
                            onPressed: () async {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return const AddEventBottomSheet();
                                },
                              ).then((value) {
                                if (value != null) {
                                  if (value == true) {
                                    setState(() {
                                      artistInfoFuture = getArtistDetail();
                                    });
                                  }
                                }
                              });
                            },
                            child: const CustomTextWidget(
                              text: 'Add',
                              textColor: Colors.white,
                              fontSize: 12.0,
                            )),
                        const SizedBox(width: 10.0)
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  FutureBuilder<ArtistDetail>(
                      future: artistInfoFuture,
                      builder: (context, response) {
                        if (response.connectionState ==
                            ConnectionState.waiting) {
                          return const CustomLoaderWidget();
                        }

                        if (response.data!.apiStatus!.toLowerCase() ==
                            'false') {
                          return const Center(
                            child: CustomTextWidget(
                                text: 'No Image Uploaded',
                                textColor: Colors.red),
                          );
                        }

                        List<EventPhotos> eventPhotos =
                            response.data!.eventPhotos!;
                        List<EventPhotos> eventVideos =
                            response.data!.eventVideos!;

                        if (eventPhotos.isEmpty && eventVideos.isEmpty) {
                          return const Center(
                            child: CustomTextWidget(
                                text: 'No Photos/Videos Uploaded',
                                textColor: Colors.red),
                          );
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: CustomTextWidget(
                                text: eventPhotos.isEmpty ? '' : 'Photos',
                                textColor: Theme.of(context).primaryColorLight,
                                fontSize: 16.0,
                                textDecoration: TextDecoration.underline,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            SingleChildScrollView(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  eventPhotos.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: CachedNetworkImage(
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        imageUrl: response.data!.path! +
                                            eventPhotos[index].imgVdo!,
                                        placeholder: (context, url) =>
                                            const CustomLoaderWidget(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.broken_image),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Divider(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: CustomTextWidget(
                                text: eventVideos.isEmpty ? '' : 'Videos',
                                textColor: Theme.of(context).primaryColorLight,
                                fontSize: 16.0,
                                textDecoration: TextDecoration.underline,
                              ),
                            ),
                            SingleChildScrollView(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  eventVideos.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: InkWell(
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: CachedNetworkImage(
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          imageUrl: response.data!.path! +
                                              eventVideos[index].imgVdo!,
                                          placeholder: (context, url) =>
                                              const CustomLoaderWidget(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.broken_image),
                                        ),
                                      ),
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return ShowVideoWidget(
                                                videoUrl: response.data!.path! +
                                                    eventVideos[index].imgVdo!,
                                              );
                                            });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
            //todo: Add Bank
            const SizedBox(height: 25.0),
            NeumorphismWidget(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: kAppColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16.0),
                          topLeft: Radius.circular(16.0),
                        )),
                    child: Row(
                      children: [
                        const SizedBox(width: 10.0),
                        const Expanded(
                          child: CustomTextWidget(
                            text: 'Bank Details',
                            textColor: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                                side: const BorderSide(
                                    color: Colors.white, width: 0.5),
                                minimumSize: const Size(80.0, 30.0)),
                            onPressed: () {
                              Navigator.pushNamed(
                                      context, UploadBankDetailsScreen.id)
                                  .then((value) {
                                if (value != null) {
                                  if (value == true) {
                                    setState(() {
                                      showPlanfuture = showplan();
                                    });
                                  }
                                }
                              });
                            },
                            child: const CustomTextWidget(
                              text: 'Add Bank Details',
                              textColor: Colors.white,
                              fontSize: 12.0,
                            )),
                        const SizedBox(width: 10.0),
                      ],
                    ),
                  ),
                  FutureBuilder<BankDetails>(
                      future: bankdetailsfuture,
                      builder: (context, response) {
                        if (response.connectionState ==
                            ConnectionState.waiting) {
                          return const CustomLoaderWidget();
                        }
                        if (response.data!.apiStatus!.toLowerCase() ==
                            'false') {
                          return const Center(
                            child: CustomTextWidget(
                                text: 'No Bank Details', textColor: Colors.red),
                          );
                        }
                        List<BankDetailsData> showbanklist =
                            response.data!.data!;
                        if (showbanklist.isEmpty) {
                          return const Center(
                            child: CustomTextWidget(
                                text: 'No Bank Details', textColor: Colors.red),
                          );
                        }

                        return ListView.separated(
                          separatorBuilder: (context, index) => const Divider(),
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ShowBankDetailsWidget(
                              showBankDetails: showbanklist[index],
                              onTap: () {
                                deleteBank(showbanklist[index].id!);
                              },
                            );
                          },
                          shrinkWrap: true,
                          itemCount: showbanklist.length,
                        );
                      })
                ],
              ),
            ),
            //todo: Contact Detail
            const SizedBox(height: 25.0),
            NeumorphismWidget(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: kAppColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16.0),
                          topLeft: Radius.circular(16.0),
                        )),
                    child: Row(
                      children: [
                        const SizedBox(width: 10.0),
                        const Expanded(
                          child: CustomTextWidget(
                            text: 'Contact Details',
                            textColor: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                                side: const BorderSide(
                                    color: Colors.white, width: 0.5),
                                minimumSize: const Size(80.0, 30.0)),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) =>
                                      ContectDetailsWidget())
                                  .then((value) {});
                            },
                            child: const CustomTextWidget(
                              text: 'Add Contact',
                              textColor: Colors.white,
                              fontSize: 12.0,
                            )),
                        const SizedBox(width: 10.0),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          text: 'Mobile Number :7854824856',
                          textColor: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        CustomTextWidget(
                          text: 'Alternate Number :7894561235 ',
                          textColor: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        CustomTextWidget(
                          text: 'Email Id :test@gmail.com',
                          textColor: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        CustomTextWidget(
                          text: 'Alternate Email Id  :testing@gmail.com ',
                          textColor: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 25.0),
            NeumorphismWidget(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: kAppColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16.0),
                          topLeft: Radius.circular(16.0),
                        )),
                    child: Row(
                      children: [
                        const SizedBox(width: 10.0),
                        const Expanded(
                          child: CustomTextWidget(
                            text: 'Available Dates',
                            textColor: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        isdate
                            ? CustomLoaderWidget()
                        :TextButton(
                            style: TextButton.styleFrom(
                                side: const BorderSide(
                                    color: Colors.white, width: 0.5),
                                minimumSize: const Size(80.0, 30.0)),
                            onPressed: () {
                             submitDate();
                            },
                            child: const CustomTextWidget(
                              text: 'Update Availability',
                              textColor: Colors.white,
                              fontSize: 12.0,
                            )),
                        const SizedBox(width: 10.0),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SfDateRangePicker(
                      initialSelectedDate: DateTime.now(),
                      enablePastDates: false,
                      selectionMode: DateRangePickerSelectionMode.multiple,
                      onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                        setState(() {
                          // selectedDates = args.value;
                          selectedDates=args.value;
                           selectedDatesAsString = selectedDates
                              .map((date) => date.toLocal().toString().split(' ')[0])
                              .join(',');

                          print(selectedDatesAsString);
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  void deleteArtistPlan(String id) {
    Helper.showLoaderDialog(context, message: 'deleting.......');
    Map<String, String> body = {
      'plan_id': id,
    };
    ApiHelper.deleteArtistPlan(body).then((value) {
      Navigator.pop(context);
      if (value.apiStatus!.toLowerCase() == 'true') {
        Helper.showToastMessage('Successfully Delete', Colors.green);
        setState(() {
          showPlanfuture = showplan();
        });
      } else {
        Helper.showToastMessage(value.result!, Colors.red);
      }
    });
  }

  void deleteBank(String id) {
    Helper.showLoaderDialog(context, message: 'deleting.......');
    Map<String, String> body = {
      'bank_id': id,
    };
    ApiHelper.deleteBankdetails(body).then((value) {
      Navigator.pop(context);
      if (value.apiStatus!.toLowerCase() == 'true') {
        Helper.showToastMessage('Successfully Delete', Colors.green);
        setState(() {
          showPlanfuture = showplan();
        });
      } else {
        Helper.showToastMessage(value.result!, Colors.red);
      }
    });
  }
  void submitDate() {
    Map<String, dynamic> body = {
      'artist_id': SessionManager.getUserId(),
      'date': selectedDatesAsString,
    };
    print(body);
    setState(() {
      isdate=true;
    });
    ApiHelper.AddartistSlote(body).then((value) {

      if (value.apiStatus!.toLowerCase() == 'true') {
        Helper.showToastMessage(
            'Add artist slot', Colors.green);
        setState(() {

        });
      } else {
        Helper.showToastMessage('filed to Request', Colors.red);
      }
    });
  }
}

class ContectDetailsWidget extends StatefulWidget {
  const ContectDetailsWidget({
    super.key,
  });

  @override
  State<ContectDetailsWidget> createState() => _ContectDetailsWidgetState();
}

class _ContectDetailsWidgetState extends State<ContectDetailsWidget> {
  TextEditingController NumberController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController AlternateEmailController = TextEditingController();
  TextEditingController AlternateNumberController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcontact();
  }
  bool iscontact = false;
  void getcontact(){
    setState(() {
      iscontact=true;
    });
    ApiHelper.getcontact().then((value){
      setState(() {
        iscontact=false;
        NumberController.text=value.data!.mobile??'';
        EmailController.text=value.data!.email??'';
        AlternateEmailController.text=value.data!.alternateEmail??'';
        AlternateNumberController.text=value.data!.alternateMobile??'';
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey.shade200),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: SizeConfig.width(),
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                decoration: BoxDecoration(color: kAppColor.withOpacity(0.2)),
                child: CustomTextWidget(
                  text: 'Contact Details ',
                  textAlign: TextAlign.center,
                  textColor: Theme.of(context).primaryColorLight,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFieldWidget(
                      hintText: 'Enter Phone Number',
                      controller: NumberController,
                      inputType: TextInputType.number,
                      maxLength: 10,
                      inputAction: TextInputAction.next,
                      prefixIcon: Icons.mobile_screen_share_sharp,
                    ),
                    const SizedBox(height: 15.0),
                    CustomTextFieldWidget(
                      hintText: 'Enter Alternate Phone number',
                      controller: AlternateNumberController,
                      inputType: TextInputType.number,
                      maxLength: 10,
                      inputAction: TextInputAction.done,
                      prefixIcon: Icons.mobile_screen_share_sharp,
                    ),
                    const SizedBox(height: 15.0),
                    CustomTextFieldWidget(
                      hintText: 'Enter Email id',
                      controller: EmailController,
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.done,
                      prefixIcon: Icons.email,
                    ),
                    const SizedBox(height: 15.0),
                    CustomTextFieldWidget(
                      hintText: 'Enter Alternate Email id',
                      controller: AlternateEmailController,
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.done,
                      prefixIcon: Icons.email,
                    ),
                    const SizedBox(height: 25.0),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Center(
                child:iscontact
                ?CustomLoaderWidget()
                :
                CustomButtonWidget(
                  radius: 25,
                  width: 150,
                  text: 'Save',
                  onClick: () {
                    addContact();
                  },
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
  void addContact(){
    String number=NumberController.text.trim();
    String alnumber=AlternateNumberController.text.trim();
    String email=EmailController.text.trim();
    String alemail=AlternateEmailController.text.trim();
    if(number.isEmpty){
      Helper.showToastMessage('Enter Number', Colors.red);
      return;
    }
    if(alnumber.isEmpty){
      Helper.showToastMessage('Enter Alternate Number ', Colors.red);
      return;
    }

    if (!Helper.isEmailValid(email)) {
      Helper.showToastMessage('Enter your Valid email', Colors.red);
      return;
    }
    if(!Helper.isEmailValid(alemail)){
      Helper.showToastMessage('Enter Valid Alternate Email ', Colors.red);
      return;
    }
    Map<String,dynamic>body={
      'user_id':SessionManager.getUserId(),
      'user_type': SessionManager.getLoginWith(),
      'mobile': number,
      'alternate_mobile': alnumber,
      'email': email,
      'alternate_email': alemail,
    };
    setState(() {
      iscontact=true;
    });
    ApiHelper.addContect(body).then((value) {
      setState(() {
        iscontact=false;
      });
      if(value.apiStatus!.toLowerCase()=='true'){
        Helper.showSnackBar(context, 'Contact Add Successfully', Colors.green);
        Navigator.pop(context,true);

      }else{
        Helper.showSnackBar(context, 'Failed', Colors.red);
      }

    });
  }

}

class BasicInfoWidget extends StatelessWidget {
  const BasicInfoWidget({super.key, required this.image, required this.text});

  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Image.asset(
            '$kLogoPath/$image',
            height: 20,
          ),
          const SizedBox(width: 10.0),
          Expanded(
              child: CustomTextWidget(
            text: text,
            textColor: Colors.black54,
            fontSize: 12.0,
          ))
        ],
      ),
    );
  }
}
