import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/helper/helper.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:flutter/material.dart';

import '../components/custom_text_widget.dart';
import '../components/neumorphism_widget.dart';
import '../helper/constants.dart';
import '../model/user_notification.dart';

class NotificationScreen extends StatefulWidget {
  static const String id = 'notification_screen';

  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<UserNotification>userfuture;
  Future<UserNotification>getNotification()async{
    return ApiHelper.getNotification();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userfuture = getNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: 'Notification',
          textColor: Colors.black,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      body:FutureBuilder<UserNotification>(
        future: userfuture,
          builder: (context,response){
          if(response.connectionState==ConnectionState.waiting){
            return CustomLoaderWidget();
          }
          if(response.data!.apiStatus!.toLowerCase()=='false'){
            return Center(
              child: CustomTextWidget(text: 'No Notification found', textColor: Colors.red),
            );
          }
          List<UserNotificationData>usernotificationlist=response.data!.data!;
          if (usernotificationlist.isEmpty) {
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
                        text: usernotificationlist[index].title??'',
                        textColor: kAppColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      ClipRRect(
                        child: CustomTextWidget(
                          text:usernotificationlist[index].body??'',
                          textColor: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextWidget(
                        text: usernotificationlist[index].dateTime!,
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
          itemCount: usernotificationlist.length);
      })
    );
  }
}
