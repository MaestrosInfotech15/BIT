import 'dart:async';
import 'dart:io';

import 'package:book_indian_talents_app/model/support_chat.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_loader_widget.dart';
import '../components/custom_text_widget.dart';
import '../components/gallery_option_sheet_widget.dart';
import '../helper/constants.dart';
import '../helper/helper.dart';
import '../helper/session_manager.dart';
import '../network/api_helper.dart';
import '../provider/file_provider.dart';

class SupportChatScreen extends StatefulWidget {
  static const String id = 'support_chat_screen';

  const SupportChatScreen({super.key});

  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  TextEditingController messageController = TextEditingController();
  late Future<SupportChat> supportfuture;

  bool isFirstTime = false;

  Timer? _timer;

  Future<SupportChat> getSupportChat(Map<String, dynamic> body) async {
    return ApiHelper.getSupportChat(body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String, dynamic> body = {
      'user_id': SessionManager.getUserId(),
      'type': 'USER'
    };
    supportfuture = getSupportChat(body);

  }

  void refershPage(){
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
    setState(() {
      Map<String, dynamic> body = {
        'user_id': SessionManager.getUserId(),
        'type': 'USER'
      };
      supportfuture = getSupportChat(body);
    });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(_timer!=null){
      _timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        elevation: 0,
        leadingWidth: 20.0,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: 'userChat!.profilePic.toString()',
                placeholder: (context, url) => const CustomLoaderWidget(),
                errorWidget: (context, url, error) =>
                    const Icon(CupertinoIcons.profile_circled, size: 30),
                width: 35.0,
                height: 35.0,
              ),
            ),
            const SizedBox(width: 10),
            CustomTextWidget(
              text: 'Support Chat',
              textColor: Theme.of(context).primaryColorLight,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder<SupportChat>(
                  future: supportfuture,
                  builder: (context, response) {
                    if (!isFirstTime) {
                      if (response.connectionState == ConnectionState.waiting) {
                        return const CustomLoaderWidget();
                      }
                      isFirstTime = true;
                      refershPage();
                    }

                    if (response.data!.apiStatus!.toLowerCase() == 'false') {
                      return const Center(
                          child: CustomTextWidget(
                              text: 'Say hi', textColor: Colors.red));
                    }

                    List<SupportChatData> chatList = response.data!.data!;
                    if (chatList.isEmpty) {
                      return const Center(
                          child: CustomTextWidget(
                              text: 'Say hi', textColor: Colors.red));
                    }




                    return ListView.builder(
                      reverse: true,
                      itemCount: chatList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: chatList[index].type != 'USER'
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: chatList[index].type != 'USER'
                                      ? 15.0
                                      : 60,
                                  right: chatList[index].type != 'USER'
                                      ? 60.0
                                      : 15,
                                  bottom: 2.0,
                                  top: 2.0),
                              decoration: BoxDecoration(
                                  color: chatList[index].type != 'USER'
                                      ? Colors.white
                                      : Colors.white,
                                  borderRadius: chatList[index].type != 'USER'
                                      ? const BorderRadius.only(
                                          topLeft: Radius.circular(8.0),
                                          topRight: Radius.circular(8.0),
                                          bottomRight: Radius.circular(8.0),
                                        )
                                      : const BorderRadius.only(
                                          topLeft: Radius.circular(8.0),
                                          topRight: Radius.circular(8.0),
                                          bottomLeft: Radius.circular(8.0),
                                        )),
                              child: Column(
                                crossAxisAlignment:
                                    chatList[index].type != 'USER'
                                        ? CrossAxisAlignment.start
                                        : CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 8.0),
                                    decoration: BoxDecoration(
                                        color: chatList[index].type != 'USER'
                                            ? Colors.grey.shade200
                                            : kAppBarColor.withOpacity(0.8),
                                        borderRadius: 'currentMessage.sender' !=
                                                SessionManager.getChatId()
                                            ? const BorderRadius.only(
                                                topLeft: Radius.circular(10.0),
                                                topRight: Radius.circular(10.0),
                                                bottomRight:
                                                    Radius.circular(10.0),
                                              )
                                            : const BorderRadius.only(
                                                topLeft: Radius.circular(10.0),
                                                topRight: Radius.circular(10.0),
                                                bottomLeft:
                                                    Radius.circular(10.0),
                                              )),
                                    child: CustomTextWidget(
                                      text: chatList[index].msg!,
                                      textColor:
                                          Theme.of(context).primaryColorLight,
                                      fontSize: 13,
                                    ),
                                  ),
                                  CustomTextWidget(
                                    text: Helper.timeAgoCustom(
                                        chatList[index].dateTime!),
                                    textColor: Colors.grey,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10.0,
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    );
                  })),
          //lock ho gye
          //hello ho gya ha
          //image isko comment rhne do.ok
          Container(
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 3.0,
              ),
            ]),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                //getProfileWidget(),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: Colors.grey,
                            )),
                        child: TextField(
                          controller: messageController,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type Here...",
                            // suffixIcon: IconButton(
                            //   onPressed: () {
                            //     // showModalBottomSheet(
                            //     //     context: context,
                            //     //     builder: (context) {
                            //     //       return const GalleryOptionSheetWidget();
                            //     //     });
                            //   },
                            //   icon: const Icon(
                            //     Icons.image,
                            //     color: Colors.grey,
                            //   ),
                            // ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    InkWell(
                      onTap: send,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13.0, vertical: 13.0),
                        decoration: BoxDecoration(
                          color: kAppBarColor,
                          borderRadius: BorderRadius.circular(
                            5.0,
                          ),
                        ),
                        child: const Icon(Icons.near_me, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void send() {
    String msg = messageController.text.trim();

    if (msg.isEmpty) {
      Helper.showToastMessage('Enter message', Colors.red);
      return;
    }
    messageController.clear();

    Map<String, dynamic> body = {
      'user_id': SessionManager.getUserId(),
      'type': 'USER',
      'msg': msg
    };

    setState(() {
      supportfuture = getSupportChat(body);
    });
  }

  Widget getProfileWidget() {
    final data = Provider.of<FileProvider>(context);

    if (data.selectedFilePath.isEmpty) {
      return Container();
    }
    return Stack(
      children: [
        Image.file(
          File(data.selectedFilePath),
          height: 75.0,
          width: 75.0,
          fit: BoxFit.cover,
        ),
        Positioned(
          right: 0,
          child: InkWell(
            onTap: () {
              data.removeImage();
            },
            child: const Icon(
              Icons.cancel,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
