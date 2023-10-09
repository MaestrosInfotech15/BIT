import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../components/custom_loader_widget.dart';
import '../components/custom_text_widget.dart';
import '../components/neumorphism_widget.dart';
import '../helper/constants.dart';
import '../model/booking_history.dart';
import '../network/api_helper.dart';

class CancelledBookingScreen extends StatefulWidget {
  static const String id = 'cancelled_booking_screen';

  const CancelledBookingScreen({super.key});

  @override
  State<CancelledBookingScreen> createState() => _CancelledBookingScreenState();
}

class _CancelledBookingScreenState extends State<CancelledBookingScreen> {
  late Future<BookingHistory> historyfuture;

  Future<BookingHistory> getHistory() async {
    return ApiHelper.getHistory('CANCEL');
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
            text: 'Cancelled Booking ',
            textColor: Theme.of(context).primaryColorLight,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: FutureBuilder<BookingHistory>(
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
                    text: 'No Booking Found',
                    textColor: Colors.red,
                  ),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 15.0),
                        child: NeumorphismWidget(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: CachedNetworkImage(
                                        width: 75,
                                        height: 75,
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            bookinghistoryList[index].path! +
                                                (bookinghistoryList[index]
                                                        .artistImg ??
                                                    ''),
                                        placeholder: (context, url) =>
                                            const CustomLoaderWidget(),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          '$kLogoPath/boy.png',
                                          width: 75,
                                          height: 75,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        CustomTextWidget(
                                          text: bookinghistoryList[index].artistDetail!.nickName!,
                                          textColor: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        CustomTextWidget(
                                          text: bookinghistoryList[index]
                                                  .endDate! +
                                              ' ' +
                                              bookinghistoryList[index]
                                                  .timeSlot!,
                                          textColor: Colors.black,
                                          fontSize: 10,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, top: 10),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 3.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(25.0)),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 10,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          const SizedBox(width: 5.0),
                                          CustomTextWidget(
                                            text: bookinghistoryList[index]
                                                    .rating ??
                                                '',
                                            textColor:
                                                Theme.of(context).primaryColor,
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w600,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  color: Colors.green.shade600,
                                  border: Border.all(color: greencolor),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: CustomTextWidget(
                                        text:
                                            bookinghistoryList[index].planname!,
                                        textColor: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    ClipRRect(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: CustomTextWidget(
                                          text: bookinghistoryList[index]
                                              .details!,
                                          textColor: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: CustomTextWidget(
                                        text:
                                            '₹${bookinghistoryList[index].totalAmt}',
                                        textColor: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
                shrinkWrap: true,
                itemCount: bookinghistoryList.length,
              );
            }));
  }
}
