import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:flutter/material.dart';

import '../components/custom_loader_widget.dart';
import '../components/custom_text_widget.dart';
import '../helper/constants.dart';
import '../model/artist_notification.dart';

class ArtistNotificationScreen extends StatefulWidget {
  static const String id = 'artist_notification_screen';
  const ArtistNotificationScreen({super.key});

  @override
  State<ArtistNotificationScreen> createState() => _ArtistNotificationScreenState();
}

class _ArtistNotificationScreenState extends State<ArtistNotificationScreen> {
  late Future<ArtistNotification>artistfuture;
  Future<ArtistNotification>getArtistNotfi()async{
    return ApiHelper.getArtistNotfi();
  }
  void initState(){
    super.initState();
    artistfuture = getArtistNotfi();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: 'Artist Notification',
          textColor: Colors.black,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
        body:FutureBuilder<ArtistNotification>(
            future: artistfuture,
            builder: (context,response){
              if(response.connectionState==ConnectionState.waiting){
                return CustomLoaderWidget();
              }
              if(response.data!.apiStatus!.toLowerCase()=='false'){
                return Center(
                  child: CustomTextWidget(text: 'No Notification found', textColor: Colors.red),
                );
              }
              List<ArtistNotificationData>artistnotificationlist=response.data!.data!;
              if (artistnotificationlist.isEmpty) {
                return const Center(
                  child: CustomTextWidget(
                      text: 'No Notification found', textColor: Colors.red),
                );
              }
              return  ListView.builder(itemBuilder: (context,index){
                return Container(
                  margin: const EdgeInsets.only(left: 10.0,right: 10,top: 10,bottom: 5),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/beautician.png',
                          width: 75,
                          height: 75,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextWidget(
                              text: artistnotificationlist[index].title1??'',
                              textColor: kAppColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            ClipRRect(
                              child: CustomTextWidget(
                                text:artistnotificationlist[index].body1??'',
                                textColor: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            CustomTextWidget(
                              text: artistnotificationlist[index].dateTime!,
                              textColor: Colors.grey,
                              fontSize: 10,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },

                  shrinkWrap: true,
                  itemCount: artistnotificationlist.length);
            })
    );
  }
}
