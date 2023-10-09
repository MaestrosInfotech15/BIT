import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../components/custom_loader_widget.dart';
import '../components/custom_text_widget.dart';
import '../helper/constants.dart';
import '../model/show_rating.dart';
import '../network/api_helper.dart';

class MyRatingScreen extends StatefulWidget {
  static const String id = 'my_rating_screen';

  const MyRatingScreen({super.key});

  @override
  State<MyRatingScreen> createState() => _MyRatingScreenState();
}

class _MyRatingScreenState extends State<MyRatingScreen> {
  late Future<ShowRating> ratingfuture;

  Future<ShowRating> getRating() async {
    return ApiHelper.getRating();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ratingfuture = getRating();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: kAppBarColor,
          title: CustomTextWidget(
            text: 'My Reviews',
            textColor: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: FutureBuilder<ShowRating>(
            future: ratingfuture,
            builder: (context, response){
              if(response.connectionState==ConnectionState.waiting){
                return CustomLoaderWidget();
              }
              if(response.data!.apiStatus!.toLowerCase()=='false'){
                return Center(
                  child: CustomTextWidget(text: 'No Booking Found', textColor: Colors.red),
                );
              }
              List<ShowRatingData>ratingyList=response.data!.data!;
              if(ratingyList.isEmpty){
                return Center(child: CustomTextWidget(text: 'No Rating Found', textColor: Colors.red),
                );
              }
          return  ListView.separated(
              itemBuilder: (context, index,){
                Divider();
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 12.0, top: 10),
                              child:  ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: CachedNetworkImage(
                                  width: 65,
                                  height: 65,
                                  fit: BoxFit.cover,
                                  imageUrl: ratingyList[index].path!+(ratingyList[index].userImg??''),
                                  placeholder: (context, url) => const CustomLoaderWidget(),
                                  errorWidget: (context, url, error) => Image.asset(
                                    '$kLogoPath/boy.png',
                                    width: 65,
                                    height: 65,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, top: 15),
                                    child: CustomTextWidget(
                                        text: ratingyList[index].name!,
                                        textColor: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 5),
                                    child: RatingBar.builder(
                                      itemSize: 15,
                                      initialRating: double.parse(ratingyList[index].rating??'0'),
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(right: 10.0, top: 10),
                              child: CustomTextWidget(
                                  text: ratingyList[index].dateTime!,
                                  textColor: Colors.grey,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 20, top: 10,bottom: 10),
                          child: CustomTextWidget(
                              text: ratingyList[index].comment!,
                              textColor: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context,index){
                return Divider();
              },
              shrinkWrap: true,
              itemCount: ratingyList.length);
        },
         ));
  }
}
