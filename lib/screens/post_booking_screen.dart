import 'dart:io';

import 'package:book_indian_talents_app/components/custom_text_field_widget.dart';
import 'package:book_indian_talents_app/provider/file_provider.dart';
import 'package:book_indian_talents_app/screens/talent_list_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../components/custom_button_widget.dart';
import '../components/custom_loader_widget.dart';
import '../components/custom_text_widget.dart';
import '../components/gallery_option_sheet_widget.dart';
import '../components/neumorphism_widget.dart';
import '../components/search_input_widget.dart';
import '../helper/constants.dart';
import '../helper/helper.dart';
import '../helper/session_manager.dart';
import '../helper/size_config.dart';
import '../model/booking_history.dart';
import '../network/api_helper.dart';
import '../widgets/filter_sheet_widget.dart';

class PastBookingScreen extends StatefulWidget {
  static const String id = 'past_booking_screen';

  const PastBookingScreen({super.key});

  @override
  State<PastBookingScreen> createState() => _PastBookingScreenState();
}

class _PastBookingScreenState extends State<PastBookingScreen> {
  late Future<BookingHistory> historyfuture;

  Future<BookingHistory> getHistory() async {
    return ApiHelper.getHistory('COMPLETE');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    historyfuture = getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: 'Past Booking',
          textColor: Theme.of(context).primaryColorLight,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15.0),
          Expanded(
              child: FutureBuilder<BookingHistory>(
                  future: historyfuture,
                  builder: (context, response) {
                    if (response.connectionState == ConnectionState.waiting) {
                      return const CustomLoaderWidget();
                    }
                    if (response.data!.apiStatus!.toLowerCase() == 'false') {
                      return const Center(
                        child: CustomTextWidget(
                            text: 'No Booking Found', textColor: Colors.red),
                      );
                    }
                    List<BookingHistoryData> bookinghistoryList =
                        response.data!.data!;
                    if (bookinghistoryList.isEmpty) {
                      return const Center(
                        child: CustomTextWidget(
                            text: 'No Booking Found', textColor: Colors.red),
                      );
                    }
                    return AlignedGridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      itemCount: bookinghistoryList.length,
                      itemBuilder: (context, index) {
                        return PastBookingWidget(
                            bookingHistoryData: bookinghistoryList[index]);
                      },
                    );
                  })),
        ],
      ),
    );
  }
}

class PastSheetWidget extends StatefulWidget {
  const PastSheetWidget({super.key, required this.bookingHistoryData});

  final BookingHistoryData bookingHistoryData;

  @override
  State<PastSheetWidget> createState() => _PastSheetWidget();
}

class _PastSheetWidget extends State<PastSheetWidget> {
  TextEditingController meassageController = TextEditingController();
  bool isAdd = false;
  String imagePath = '';
  String imageUri = '';
  double star = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 30),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.90,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
            color: Colors.white),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 15.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                  color: kAppcremColor,
                ),
                child: const Center(
                  child: CustomTextWidget(
                      text: 'Submit Feedback',
                      textColor: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CachedNetworkImage(
                            width: 75,
                            height: 75,
                            fit: BoxFit.cover,
                            imageUrl: widget.bookingHistoryData.path! +
                                (widget.bookingHistoryData.artistImg ?? ''),
                            placeholder: (context, url) =>
                                const CustomLoaderWidget(),
                            errorWidget: (context, url, error) => Image.asset(
                              '$kLogoPath/boy.png',
                              width: 75,
                              height: 75,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextWidget(
                              text: widget
                                  .bookingHistoryData.artistDetail!.nickName!,
                              textColor: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                            ),
                            CustomTextWidget(
                              text: widget.bookingHistoryData.startDate!,
                              textColor: Colors.black54,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(height: 5.0),
                            Center(
                              child: RatingBar.builder(
                                itemSize: 15,
                                initialRating:  double.parse(widget.bookingHistoryData.rating!),
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                ignoreGestures: true,
                                itemCount: 5,
                                itemPadding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ), onRatingUpdate: (double value) {

                              },

                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Divider(),
                    Center(
                      child: RatingBar.builder(
                        itemSize: 25,
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                        const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            star = rating;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    DescriptionTextField(
                        hintText: 'Write Message',
                        controller: meassageController,
                        inputType: TextInputType.multiline,
                        inputAction: TextInputAction.newline,
                        prefixIcon: Icons.ice_skating)
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const GalleryOptionSheetWidget();
                        });
                  },
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    color: kAppColor,
                    radius: const Radius.circular(10),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          getProfileWidget(),
                          const SizedBox(height: 5),
                          const CustomTextWidget(
                              text: 'Upload your Profile Image',
                              fontWeight: FontWeight.w700,
                              fontSize: 14.0,
                              textColor: Colors.black),
                          TextButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return const GalleryOptionSheetWidget();
                                  });
                            },
                            child: const CustomTextWidget(
                                text: 'Browse',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                textColor: kAppColor,
                                textDecoration: TextDecoration.underline),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: isAdd
                    ? CustomLoaderWidget()
                    : CustomButtonWidget(
                        width: 130,
                        radius: 30,
                        text: 'Submit',
                        onClick: () {
                          addReview();
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getProfileWidget() {
    final data = Provider.of<FileProvider>(context);

    if (data.selectedFilePath.isNotEmpty) {
      imagePath = '';
    }

    if (imagePath.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
            height: 75.0, width: 75.0, fit: BoxFit.cover, imageUri + imagePath),
      );
    }

    if (data.selectedFilePath.isEmpty) {
      return const Icon(Icons.drive_folder_upload, color: kAppColor, size: 35);
    }

    // if (data.isFileUpload) {
    //   return const CircularProgressIndicator();
    // }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.file(
        File(data.selectedFilePath),
        height: 75.0,
        width: 75.0,
        fit: BoxFit.cover,
      ),
    );
  }

  void addReview() {
    final data = Provider.of<FileProvider>(context, listen: false);
    String comment = meassageController.text.trim();
    if (comment.isEmpty) {
      Helper.showToastMessage('Enter Comment', Colors.red);
      return;
    }
    Map<String, String> body = {
      'user_id': widget.bookingHistoryData.artistDetail!.id!,
      'user_type': SessionManager.getLoginWith(),
      'giving_id': SessionManager.getUserId(),
      'rating': '$star',
      'giving_type': SessionManager.getLoginWith(),
      'comment': comment
    };
    print(body);

    setState(() {
      isAdd = true;
    });
    ApiHelper.addReview(body, data.selectedFilePath).then((value) {
      setState(() {
        isAdd = false;
      });
      if (value.apiStatus!.toLowerCase() == 'true') {
        Helper.showSnackBar(context, 'Add  Successfully', Colors.green);
        Navigator.pop(context, true);
      } else {
        Helper.showSnackBar(context, 'Failed to add ', Colors.red);
      }
    });
  }
}

class PastBookingWidget extends StatefulWidget {
  const PastBookingWidget({
    super.key,
    required this.bookingHistoryData,
  });

  final BookingHistoryData bookingHistoryData;

  @override
  State<PastBookingWidget> createState() => _PastBookingWidgetState();
}

class _PastBookingWidgetState extends State<PastBookingWidget> {
  @override
  Widget build(BuildContext context) {
    return NeumorphismWidget(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: InkWell(
        child: Column(
          children: [
            const SizedBox(height: 5.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 10,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 5.0),
                      CustomTextWidget(
                        text: widget.bookingHistoryData.rating ?? '',
                        textColor: Theme.of(context).primaryColor,
                        fontSize: 10.0,
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    width: 75,
                    height: 75,
                    fit: BoxFit.cover,
                    imageUrl: widget.bookingHistoryData.path! +
                        (widget.bookingHistoryData.artistImg ?? ''),
                    placeholder: (context, url) => const CustomLoaderWidget(),
                    errorWidget: (context, url, error) => Image.asset(
                      '$kLogoPath/boy.png',
                      width: 75,
                      height: 75,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            CustomTextWidget(
              text: widget.bookingHistoryData.artistDetail!.nickName!,
              textColor: Colors.black,
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 5.0),
            CustomTextWidget(
              text: widget.bookingHistoryData.startDate!,
              textColor: Colors.black,
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 5.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextWidget(
                  text: 'Starts at',
                  textColor: Theme.of(context).hintColor,
                  fontSize: 12.0,
                ),
                const SizedBox(width: 7.0),
                CustomTextWidget(
                  text: '₹${widget.bookingHistoryData.totalAmt!}',
                  textColor: Theme.of(context).primaryColorLight,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            CustomButtonWidget(
              text: 'Write Review',
              onClick: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return PastSheetWidget(
                        bookingHistoryData: widget.bookingHistoryData);
                  },
                );
              },
              fontSize: 12.0,
              radius: 25.0,
              width: 120.0,
              height: 35.0,
            )
          ],
        ),
      ),
    );
  }
}
