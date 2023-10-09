import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:book_indian_talents_app/screens/show_artist_plan_screen.dart';
import 'package:book_indian_talents_app/screens/talent_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';

import '../components/custom_loader_widget.dart';
import '../components/custom_text_widget.dart';
import '../helper/constants.dart';
import '../helper/helper.dart';
import '../model/artist_detail.dart';
import '../network/api_helper.dart';
import '../widgets/show_video_widget.dart';
import 'artist_plan_screen.dart';

class ViewArtistProfileScreen extends StatefulWidget {
  static const String id = 'view_artist_profile_screen';
  const ViewArtistProfileScreen({super.key});

  @override
  State<ViewArtistProfileScreen> createState() => _ViewArtistProfileScreenState();
}

class _ViewArtistProfileScreenState extends State<ViewArtistProfileScreen> {
  bool listViewVisible = false;

  int carouselCount = 1;
  late Future<ArtistDetail> detailFuture;

  Future<ArtistDetail> getArtistDetail() async {
    return ApiHelper.getArtistDetail(SessionManager.getUserId());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detailFuture = getArtistDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: 'Detail',
          textColor: Theme.of(context).hintColor,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),

      ),
      body: FutureBuilder<ArtistDetail>(
        future: detailFuture,
        builder: (context, response) {

          if (response.connectionState == ConnectionState.waiting) {
            return const CustomLoaderWidget();
          }

          if (response.data!.apiStatus!.toLowerCase() == 'false') {
            return const Center(
              child: CustomTextWidget(
                  text: 'No Data Found', textColor: Colors.red),
            );
          }

          List<EventPhotos> eventPhotos = response.data!.eventPhotos!;
          List<EventPhotos> eventVideos = response.data!.eventVideos!;
          List<ArtistDetailReview> reviewList = response.data!.review!;
          List<String> carouselImageList = response.data!.carousalImg ?? [];

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 15.0),
                        height: 300,
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 300,
                              child: PageView.builder(
                                onPageChanged: (index) {
                                  setState(() {
                                    carouselCount = index + 1;
                                  });
                                },
                                itemCount: carouselImageList.length,
                                itemBuilder: (context, index) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: response.data!.path! +
                                          carouselImageList[index],
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.broken_image),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0, vertical: 2.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(3.0),
                                          color: Colors.black.withOpacity(0.5)),
                                      child: CustomTextWidget(
                                        text:
                                        '$carouselCount/${carouselImageList.length}',
                                        textColor: Colors.white,
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),

                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight: Radius.circular(15.0),
                                      )),
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Visibility(
                                            visible: response.data!.instagram !=
                                                null,
                                            child: InkWell(
                                              onTap: () {
                                                if (response.data!.instagram!
                                                    .isNotEmpty) {
                                                  Helper.launchApp(response
                                                      .data!.instagram ??
                                                      '');
                                                }
                                              },
                                              child: Image.asset(
                                                '$kLogoPath/instagram.png',
                                                height: 20.0,
                                                width: 20.0,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 20.0),
                                          Visibility(
                                            visible:
                                            response.data!.facebook != null,
                                            child: InkWell(
                                              onTap: () {
                                                if (response.data!.facebook!
                                                    .isNotEmpty) {
                                                  Helper.launchApp(
                                                      response.data!.facebook ??
                                                          '');
                                                }
                                              },
                                              child: Image.asset(
                                                '$kLogoPath/facebook.png',
                                                height: 20.0,
                                                width: 20.0,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 20.0),
                                          Visibility(
                                            visible:
                                            response.data!.youtube != null,
                                            child: InkWell(
                                              onTap: () {
                                                if (response.data!.youtube!
                                                    .isNotEmpty) {
                                                  Helper.launchApp(
                                                      response.data!.youtube ??
                                                          '');
                                                }
                                              },
                                              child: Image.asset(
                                                '$kLogoPath/youtube.png',
                                                height: 20.0,
                                                width: 20.0,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 20.0),
                                          Visibility(
                                            visible:
                                            response.data!.linkedin != null,
                                            child: InkWell(
                                              onTap: () {
                                                if (response.data!.youtube!
                                                    .isNotEmpty) {
                                                  Helper.launchApp(
                                                      response.data!.youtube ??
                                                          '');
                                                }
                                              },
                                              child: Image.asset(
                                                '$kLogoPath/linkedin.png',
                                                height: 20.0,
                                                width: 20.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            )
                          ],
                        ),
                      ),
                        const SizedBox(height: 15),

                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: CustomTextWidget(
                            text: response.data!.nick_name ?? '',
                            textColor: kAppColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: CustomTextWidget(
                            text: 'About Me',
                            textColor: Colors.grey.shade600,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),

                      Padding(
                        padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 5),
                        child:
                        ReadMoreText(
                          response.data!.about ?? '',
                          trimLines: 2,
                          colorClickableText: kAppColor,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: '  Read more',
                          trimExpandedText: '  Show less',
                          moreStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w500,color:kAppColor),
                          lessStyle:TextStyle(fontSize: 10, fontWeight: FontWeight.w500,color:kAppColor) ,
                        ),

                      ),

                      //todo: plan widget
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, ShowArtistPlanScreen.id);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: kAppColor,
                              borderRadius:
                              BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: CustomTextWidget(
                                      text: 'View My Plan',
                                      textColor: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                Icon(
                                  listViewVisible
                                      ? Icons.keyboard_arrow_down
                                      : Icons.navigate_next,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15.0),
                Visibility(
                  visible: eventPhotos.isNotEmpty,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    color: Colors.grey.shade300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                            text: 'Events Photos',
                            textColor: Colors.grey.shade600,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                        const SizedBox(height: 15.0),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              eventPhotos.length,
                                  (index) => PastEventsWidget(
                                    type: 'photo',
                                eventPhotos: eventPhotos[index],
                                path: response.data!.path!,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                Visibility(
                  visible: eventVideos.isNotEmpty,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    color: Colors.grey.shade300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                            text: 'Event Videos',
                            textColor: Colors.grey.shade600,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                        const SizedBox(height: 10.0),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              eventVideos.length,
                                  (index) => EventVideoWidget(videoUrl:  response.data!.path!+eventVideos[index].imgVdo!, id:eventVideos[index].id!, onclick: () {  },),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                Visibility(
                  visible: reviewList.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: CustomTextWidget(
                        text: 'Review and Rating',
                        textColor: Colors.grey.shade600,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 20),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 15.0),
                        color: Colors.grey.shade100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  '$kLogoPath/boy.png',
                                  height: 40.0,
                                ),
                                const SizedBox(width: 10.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      CustomTextWidget(
                                          text: reviewList[index].giving_name ?? '',
                                          textColor: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                      RatingBar.builder(
                                        itemSize: 15,
                                        initialRating: double.parse(
                                            reviewList[index].rating ?? '0'),
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                CustomTextWidget(
                                    text: reviewList[index].strtotime??'',
                                    textColor: Colors.grey,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            ReadMoreText(
                              reviewList[index].comment ?? '',
                              trimLines: 2,
                              colorClickableText: kAppColor,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'Read more',
                              trimExpandedText: 'Show less',
                              moreStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w500,color:kAppColor),
                              lessStyle:TextStyle(fontSize: 10, fontWeight: FontWeight.w500,color:kAppColor) ,
                            ),


                            /*SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            eventVideos.length,
                            (index) =>  PastEventsWidget(eventPhotos: eventVideos[index]),
                          ),
                        ),
                      ),
                            const Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(right: 10.0, bottom: 20),
                                child: CustomTextWidget(
                                    text: 'More Feedback',
                                    textColor: kAppBarColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),*/
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: reviewList.length),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        },
      ),

    );
  }
}
