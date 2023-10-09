import 'package:book_indian_talents_app/model/artist_history.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../components/custom_button_widget.dart';
import '../components/custom_loader_widget.dart';
import '../components/custom_text_widget.dart';
import '../components/neumorphism_widget.dart';
import '../helper/constants.dart';
import '../network/api_helper.dart';
import '../screens/post_booking_screen.dart';

class ArtistCompletedFragment extends StatefulWidget {
  const ArtistCompletedFragment({super.key});

  @override
  State<ArtistCompletedFragment> createState() => _ArtistCompletedFragmentState();
}

class _ArtistCompletedFragmentState extends State<ArtistCompletedFragment> {
  late Future<ArtistHistory> artisthistoryfuture;
  Future<ArtistHistory> artistBooking() async {
    return ApiHelper.artistBooking('COMPLETE');
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
            List<ArtistHistoryData>bookinghistoryList=response.data!.data!;
            if(bookinghistoryList.isEmpty){
              return const Center(child: CustomTextWidget(text: 'No Booking Found', textColor: Colors.red),
              );
            }
            return AlignedGridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(left: 10,right: 10),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              itemCount: bookinghistoryList.length,
              itemBuilder: (context, index) {

                return PastBookingWidget(artistHistoryData:bookinghistoryList[index]);
              },
            );
          }),

    );
  }
}
class PastBookingWidget extends StatelessWidget {
  const PastBookingWidget({

    super.key,required this.artistHistoryData,
  });
  final ArtistHistoryData artistHistoryData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: NeumorphismWidget(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 5.0),
              const SizedBox(
                width: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  width: 65,
                  height: 65,
                  fit: BoxFit.cover,
                  imageUrl: artistHistoryData.path!+(artistHistoryData.userImg??''),
                  placeholder: (context, url) => const CustomLoaderWidget(),
                  errorWidget: (context, url, error) => Image.asset(
                    '$kLogoPath/boy.png',
                    width: 65,
                    height: 65,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              CustomTextWidget(
                text: artistHistoryData.name!,
                textColor: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 5.0),
              CustomTextWidget(
                text: 'Dancer',
                textColor: Theme.of(context).hintColor,
                fontSize: 12.0,
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
                    text: '₹${artistHistoryData.totalAmt}',
                    textColor: Theme.of(context).primaryColorLight,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              const SizedBox(height: 5.0),

            ],
          ),
        ),
      ),
    );
  }
}
