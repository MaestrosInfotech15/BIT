import 'package:book_indian_talents_app/components/custom_button_widget.dart';
import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/components/neumorphism_widget.dart';
import 'package:book_indian_talents_app/firebase/firebase_helper.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/helper/helper.dart';
import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:book_indian_talents_app/helper/size_config.dart';
import 'package:book_indian_talents_app/model/artist_detail.dart';
import 'package:book_indian_talents_app/model/chat_room.dart';
import 'package:book_indian_talents_app/model/talents.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:book_indian_talents_app/screens/artist_plan_screen.dart';
import 'package:book_indian_talents_app/screens/chat_screen.dart';
import 'package:book_indian_talents_app/screens/support_chat_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../components/custom_text_field_widget.dart';
import '../provider/api_controller.dart';
import '../widgets/show_video_widget.dart';

class TalentDetailScreen extends StatefulWidget {
  static const String id = 'talent_detail_screen';

  const TalentDetailScreen({super.key, required this.talentData});

  final TalentData talentData;

  @override
  State<TalentDetailScreen> createState() => _TalentDetailScreenState();
}

class _TalentDetailScreenState extends State<TalentDetailScreen> {
  bool listViewVisible = false;
  bool isFavorite = false;

  int carouselCount = 1;
  late Future<ArtistDetail> detailFuture;

  Future<ArtistDetail> getArtistDetail() async {
    return
      ApiHelper.getArtistDetail(widget.talentData.id!);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detailFuture = getArtistDetail();
    detailFuture = getArtistDetail();
    isFavorite=widget.talentData.favourite??false;
    print(widget.talentData.id!);
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
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(
          //     Icons.share,
          //   ),
          // )
        ],
      ),
      body: FutureBuilder<ArtistDetail>(
        future: detailFuture,
        builder: (context, response) {

          if (response.connectionState == ConnectionState.waiting) {
            return  Container();
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
                                    const Spacer(),
                                    Visibility(
                                      visible:response.data!.favourite!=null,
                                      child: InkWell(
                                        onTap: (){
                                          if(isFavorite){
                                             deleteFavorite(widget.talentData.id!);
                                          }else{
                                            addFavorite();
                                          }
                                        },
                                        child:  Padding(
                                          padding: const EdgeInsets.only(right: 10,top: 5),
                                          child: Icon(
                                            Icons.favorite,
                                            size: 20,
                                            color: isFavorite?Colors.red : Colors.grey,

                                            // Change color based on favorite status
                                          ),
                                        ),
                                      ),
                                    )
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
                      //todo: plan widget
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, ArtistPlanScreen.id,
                                arguments: widget.talentData);
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

                      const SizedBox(height: 15),

                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: CustomTextWidget(
                            text: response.data!.nick_name ?? '',
                            textColor: kAppColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 5),
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
                          response.data!.about ?? '' ,
                          trimLines: 2,
                          colorClickableText: kAppColor,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: '  Read more',
                          trimExpandedText: '  Show less',
                          moreStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w500,color:kAppColor),
                          lessStyle:TextStyle(fontSize: 10, fontWeight: FontWeight.w500,color:kAppColor) ,
                        ),

                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 15.0),
                Visibility(
                  visible: eventPhotos.isNotEmpty,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 15.0),
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
                        horizontal: 15.0, vertical: 15.0),
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
                              (index) => EventVideoWidget(videoUrl:  response.data!.path!+eventVideos[index].imgVdo!, id: eventVideos[index].id!, onclick: () {  },),





                                  //PastEventsWidget(
                              //                                 type: 'video',
                              //                                 eventPhotos: eventVideos[index],
                              //                                 path: response.data!.path!,
                              //                               ),
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              CustomTextWidget(
                                  text: 'Review and Rating',
                                  textColor: Colors.grey.shade600,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                                    text: reviewList[index].strtotime!,
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
      bottomNavigationBar: Container(
        height: 50,
        width: 120,
        decoration: const BoxDecoration(),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButtonWidget(
              radius: 20,
              text: 'Support Chat',
              onClick: () async {
                // Map<String, dynamic> data = await FirebaseHelper.createChatRoom(
                //     widget.talentData.email!);
                if (mounted) {
                  Navigator.pushNamed(context, SupportChatScreen.id);
                }
              },
              height: 45,
              width: 120,
            ),
          ],
        ),
      ),
    );
  }

  void addFavorite() {
    final apidata=Provider.of<ApiController>(context,listen: false);
    Map<String, String> body = {
      'user_id': SessionManager.getUserId(),
      'user_type': SessionManager.getLoginWith(),
      'fav_id': widget.talentData.id!,
      'fav_type': 'ARTIST'
    };

    Helper.showLoaderDialog(context, message: 'Adding....');
    ApiHelper.addFavorite(body).then((value) {
      Navigator.pop(context);

      if (value.apiStatus!.toLowerCase() == 'true') {
        setState(() {
          isFavorite=true;
        });
        apidata.updateFavoriteStatus(widget.talentData.name!,true);
        apidata.updateSearchStatus(widget.talentData.name!,true);
        Helper.showSnackBar(context, 'Added Successfully', Colors.green);

      } else {
        Helper.showSnackBar(context, value.result ?? 'Something went wrong', Colors.red);
      }
    });
  }


  void deleteFavorite(String id) {
    final apidata=Provider.of<ApiController>(context,listen: false);
    Helper.showLoaderDialog(context, message: 'deleting.......');
    Map<String, String> body = {
      'fav_id': id,
      'user_id': SessionManager.getUserId(),
    };
    print(body);
    ApiHelper.favouriteDelete(body).then((value) {
      Navigator.pop(context);
      if (value.apiStatus!.toLowerCase() == 'true') {
        Helper.showToastMessage('Remove', Colors.red);
        setState(() {
isFavorite=false;
        });
        apidata.updateFavoriteStatus(widget.talentData.name!,false);
        apidata.updateSearchStatus(widget.talentData.name!,false);
      } else {
        Helper.showToastMessage(value.result!, Colors.red);
      }
    });
  }
}

class PastEventsWidget extends StatelessWidget {
  const PastEventsWidget({
    super.key,
    required this.eventPhotos,
    required this.path,
    required this.type,
  });

  final EventPhotos eventPhotos;
  final String path;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        border: Border.all(color: Colors.black),
      ),
      child: InkWell(
        onTap: () {
          if(type=='video'){
            showDialog(
                context: context,
                builder: (context) {
                  return ShowVideoWidget(
                    videoUrl:path + eventPhotos.imgVdo!,
                  );
                });
          }

        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child:type=='photo'? CachedNetworkImage(
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
            imageUrl:path + eventPhotos.imgVdo!,
            errorWidget: (context, url, error) => const Icon(Icons.broken_image),
          ):FutureBuilder<Uint8List>(
            future: Helper.generateThumbnail(
                path + eventPhotos.imgVdo!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting){
                return CustomLoaderWidget();
              }
              return Image.memory(
                snapshot.data!,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              );
            },
          )
        ),
      ),
    );
  }
}

class SocialIconsWidget extends StatelessWidget {
  const SocialIconsWidget({super.key, required this.text, required this.icon});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 15,
        ),
        const SizedBox(width: 5.0),
        CustomTextWidget(
          text: text,
          fontSize: 12.0,
          textColor: Colors.white,
        )
      ],
    );
  }
}

/*
 Visibility(
                        visible: listViewVisible,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                margin: const EdgeInsets.only(
                                    left: 15, right: 15, top: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CustomTextWidget(
                                      text: 'Plan Name 1',
                                      textColor: kAppColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const CustomTextWidget(
                                      text: kRestDesc,
                                      textColor: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          const Expanded(
                                            child: CustomTextWidget(
                                              text: '₹2000.00',
                                              textColor: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(
                                              5.0,
                                            ),
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            width: 90,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(30)),
                                              color: Colors.white,
                                              border:
                                                  Border.all(color: kAppColor),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        const BookDialogWidget());
                                              },
                                              child: const CustomTextWidget(
                                                text: 'Book Now',
                                                textColor: kAppColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            shrinkWrap: true,
                            itemCount: 5),
                      ),
 */
