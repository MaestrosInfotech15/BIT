import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../components/custom_button_widget.dart';
import '../components/custom_loader_widget.dart';
import '../components/custom_text_widget.dart';
import '../components/neumorphism_widget.dart';
import '../helper/constants.dart';
import '../helper/helper.dart';
import '../model/artist_history.dart';
import '../network/api_helper.dart';

class ArtistUpcomingFragement extends StatefulWidget {
  const ArtistUpcomingFragement({super.key});

  @override
  State<ArtistUpcomingFragement> createState() => _ArtistUpcomingFragementState();
}

class _ArtistUpcomingFragementState extends State<ArtistUpcomingFragement> {
  late Future<ArtistHistory> artisthistoryfuture;
  Future<ArtistHistory> artistBooking() async {
    return ApiHelper.artistBooking('UPCOMING');
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    artisthistoryfuture = artistBooking();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ArtistHistory>(
        future: artisthistoryfuture,
        builder: (context,response){
          if(response.connectionState==ConnectionState.waiting){
            return const CustomLoaderWidget();
          }
          if(response.data!.apiStatus!.toLowerCase()=='false'){
            return const Center(
              child: CustomTextWidget(text: 'No Booking Found', textColor: Colors.red),
            );
          }
          List<ArtistHistoryData>artisthistoryList=response.data!.data!;
          if(artisthistoryList.isEmpty){
            return const Center(child: CustomTextWidget(text: 'No Booking Found', textColor: Colors.red),
            );
          }
          return ListView.builder(
            itemCount: artisthistoryList.length,
            itemBuilder: (context,index){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(

                    margin:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    child: NeumorphismWidget(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                                    width: 65,
                                    height: 65,
                                    fit: BoxFit.cover,
                                    imageUrl: artisthistoryList[index].path!+(artisthistoryList[index].userImg??''),
                                    placeholder: (context, url) => const CustomLoaderWidget(),
                                    errorWidget: (context, url, error) => Image.asset(
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

                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomTextWidget(
                                      text: artisthistoryList[index].name!,
                                      textColor: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    CustomTextWidget(
                                      text: 'Start Date - '+artisthistoryList[index].startDate!,
                                      textColor: Colors.black,
                                      fontSize: 10,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    CustomTextWidget(
                                      text: 'End Date - '+artisthistoryList[index].endDate!,
                                      textColor: Colors.black,
                                      fontSize: 10,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    CustomTextWidget(
                                      text: 'Time - '+artisthistoryList[index].timeSlot!,
                                      textColor: Colors.black,
                                      fontSize: 10,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              color: Colors.green.shade600,
                              border: Border.all(color: greencolor),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: CustomTextWidget(
                                    text:  artisthistoryList[index].planName!,
                                    textColor: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                ClipRRect(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: CustomTextWidget(
                                      text: artisthistoryList[index].planDetails??'',
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
                                    text:  '₹${artisthistoryList[index].totalAmt}',
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
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              CustomButtonWidget(
                                text: 'Cancel',
                                onClick: () {
                                  cancelBooking(artisthistoryList[index].orderId!);
                                },
                                width: 70,
                                height: 35,
                                fontSize: 14,
                                btnColor: Colors.grey,
                                textColor: Colors.white,
                                radius:20,
                              ),
                              const Spacer(),
                              CustomButtonWidget(
                                text: 'Contact',
                                onClick: () {
                                  Helper.launchApp('tel:+91${artisthistoryList[index].contact}');
                                },
                                width: 70,
                                height: 35,
                                fontSize: 14,
                                btnColor: kAppColor,
                                textColor: Colors.white,
                                radius:20,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );

            },

          );

        },
      ),
    );
  }
  void cancelBooking(String id) {
    Helper.showLoaderDialog(context, message: 'deleting.......');
    Map<String, String> body = {
      'booking_id': id,
    };
    print(body);
    ApiHelper.cancelBooking(body).then((value) {
      Navigator.pop(context);
      if (value.apiStatus!.toLowerCase() == 'true') {
        Helper.showToastMessage('Successfully Cancel', Colors.green);
        setState(() {
          artisthistoryfuture = artistBooking();
        });
      } else {
        Helper.showToastMessage(value.result!, Colors.red);
      }
    });
  }
}
