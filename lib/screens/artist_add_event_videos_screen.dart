import 'dart:typed_data';

import 'package:book_indian_talents_app/components/neumorphism_widget.dart';
import 'package:book_indian_talents_app/helper/helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_button_widget.dart';
import '../components/custom_loader_widget.dart';
import '../components/custom_text_widget.dart';
import '../helper/constants.dart';
import '../helper/session_manager.dart';
import '../model/artist_detail.dart';
import '../network/api_helper.dart';
import '../provider/api_controller.dart';
import '../widgets/add_event_bottom_sheet.dart';
import '../widgets/show_video_widget.dart';

class ArtistAddEventVideoScreen extends StatefulWidget {
  static const String id = 'artist_add_event_videos_screen';

  const ArtistAddEventVideoScreen({super.key});

  @override
  State<ArtistAddEventVideoScreen> createState() =>
      _ArtistAddEventVideoScreenState();
}

class _ArtistAddEventVideoScreenState extends State<ArtistAddEventVideoScreen> {
  late Future<ArtistDetail> artistInfoFuture;

  Future<ArtistDetail> getArtistDetail() async {
    return ApiHelper.getArtistDetail(SessionManager.getUserId());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    artistInfoFuture = getArtistDetail();
  }

  bool isvideo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: 'Event Videos ',
          textColor: Colors.black,
          fontWeight: FontWeight.w700,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CustomButtonWidget(
              text: 'Add',
              textColor: Colors.white,
              width: 100,
              height: 30,
              radius: 20,
              fontSize: 12,
              onClick: () {
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
            ),
          ),
        ],
      ),
      body: FutureBuilder<ArtistDetail>(
          future: artistInfoFuture,
          builder: (context, response) {
            if (response.connectionState == ConnectionState.waiting) {
              return const CustomLoaderWidget();
            }

            if (response.data!.apiStatus!.toLowerCase() == 'false') {
              return const Center(
                child: CustomTextWidget(
                    text: 'No Image Uploaded', textColor: Colors.red),
              );
            }

            List<EventPhotos> eventPhotos = response.data!.eventPhotos!;
            List<EventPhotos> eventVideos = response.data!.eventVideos!;

            if (eventPhotos.isEmpty && eventVideos.isEmpty) {
              return const Center(
                child: CustomTextWidget(
                    text: 'No Photos/Videos Uploaded', textColor: Colors.red),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    child: CustomTextWidget(
                      text: eventPhotos.isEmpty ? '' : 'Photos',
                      textColor: Theme.of(context).primaryColorLight,
                      fontSize: 16.0,
                      textDecoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      eventPhotos.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Column(
                          children: [
                            ClipRRect(
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
                            const SizedBox(height: 5.0),
                            InkWell(
                              onTap: () {
                                deleteArtistVidio(eventPhotos[index].id!);
                              },
                              child: const CustomTextWidget(
                                text: 'Remove',
                                textColor: Colors.red,
                                fontSize: 12.0,
                                textDecoration: TextDecoration.underline,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: CustomTextWidget(
                    text: eventVideos.isEmpty ? '' : 'Videos',
                    textColor: Theme.of(context).primaryColorLight,
                    fontSize: 16.0,
                    textDecoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(height: 10.0),
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      eventVideos.length,
                      (index) => EventVideoWidget(
                          videoUrl:
                              response.data!.path! + eventVideos[index].imgVdo!,
                          type: 'Dashboard',
                          id: eventVideos[index].id!, onclick: () {
                        deleteArtistVidio(eventVideos[index].id!);
                      },),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  void deleteArtistVidio(String id) {
    Helper.showLoaderDialog(context, message: 'remove.......');
    Map<String, String> body = {
      'id': id,
    };
    print(body);
    ApiHelper.deleteArtistVidio(body).then((value) {
      Navigator.pop(context);
      if (value.apiStatus!.toLowerCase() == 'true') {
        Helper.showToastMessage('Remove', Colors.red);
        setState(() {
          artistInfoFuture = getArtistDetail();
        });
      } else {
        Helper.showToastMessage(value.result!, Colors.red);
      }
    });
  }
}
//Padding(
//                         padding: const EdgeInsets.only(right: 10.0),
//                         child: InkWell(
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(8.0),
//                             child: FutureBuilder<Uint8List>(
//                               future: Helper.generateThumbnail(
//                                   response.data!.path! +
//                                       eventVideos[index].imgVdo!),
//                               builder: (context, snapshot) {
//                                 if (snapshot.connectionState == ConnectionState.waiting){
//                                   return CustomLoaderWidget();
//                                 }
//                                   return Image.memory(
//                                     snapshot.data!,
//                                     width: 100,
//                                     height: 100,
//                                     fit: BoxFit.cover,
//                                   );
//                               },
//                             ),
//                           ),
//                           onTap: () {
//                             showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return ShowVideoWidget(
//                                     videoUrl: response.data!.path! +
//                                         eventVideos[index].imgVdo!,
//                                   );
//                                 });
//                           },
//                         ),
//                       ),
