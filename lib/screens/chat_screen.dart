import 'dart:io';

import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/components/gallery_option_sheet_widget.dart';
import 'package:book_indian_talents_app/firebase/firebase_helper.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/helper/helper.dart';
import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:book_indian_talents_app/model/chat_room.dart';
import 'package:book_indian_talents_app/model/message.dart';
import 'package:book_indian_talents_app/model/user_chat.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:book_indian_talents_app/provider/file_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {

  static const String id = 'chat_screen';
  const ChatScreen({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  UserChat? userChat;
  ChatRoom? chatRoom;

  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userChat = widget.data['target_user'];
    chatRoom = widget.data['chat_room'];
    Provider.of<FileProvider>(context, listen: false).selectedFilePath = '';
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<FileProvider>(context);
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
                imageUrl: userChat!.profilePic.toString(),
                placeholder: (context, url) => const CustomLoaderWidget(),
                errorWidget: (context, url, error) =>
                    const Icon(CupertinoIcons.profile_circled, size: 30),
                width: 35.0,
                height: 35.0,
              ),
            ),
            const SizedBox(width: 10),
            CustomTextWidget(
              text: userChat!.fullName.toString(),
              textColor: Theme.of(context).primaryColorLight,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            )
          ],
        ),
      ),
      body: Column(
        children: [
          //todo: This is where the chats will go
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("chatrooms")
                    .doc(chatRoom!.chatroomId)
                    .collection("messages")
                    .orderBy("createdon", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      QuerySnapshot dataSnapshot =
                          snapshot.data as QuerySnapshot;

                      return ListView.builder(
                        reverse: true,
                        itemCount: dataSnapshot.docs.length,
                        itemBuilder: (context, index) {
                          MessageModel currentMessage = MessageModel.fromMap(
                              dataSnapshot.docs[index].data()
                                  as Map<String, dynamic>);

                          return Column(
                            crossAxisAlignment: currentMessage.sender !=
                                    SessionManager.getChatId()
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: currentMessage.sender !=
                                            SessionManager.getChatId()
                                        ? 15.0
                                        : 60,
                                    right: currentMessage.sender !=
                                            SessionManager.getChatId()
                                        ? 60.0
                                        : 15,
                                    bottom: 2.0,
                                    top: 2.0),
                                decoration: BoxDecoration(
                                    color: currentMessage.sender !=
                                            SessionManager.getChatId()
                                        ? Colors.white
                                        : Colors.white,
                                    borderRadius: currentMessage.sender !=
                                            SessionManager.getChatId()
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
                                  crossAxisAlignment: currentMessage.sender !=
                                          SessionManager.getChatId()
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                                  children: [
                                    getMessageWidget(currentMessage),
                                    CustomTextWidget(
                                      text: '',
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
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                            "An error occured! Please check your internet connection."),
                      );
                    } else {
                      return const Center(
                        child: Text("Say hi to your new friend"),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),

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
                getProfileWidget(),
                SizedBox(height: 10.0),
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
                            suffixIcon: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return const GalleryOptionSheetWidget();
                                    });
                              },
                              icon: const Icon(
                                Icons.image,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    InkWell(
                      onTap: () {
                        sendMessage();
                      },
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

  Widget getMessageWidget(MessageModel currentMessage) {
    if (currentMessage.type.toString() == 'IMAGE') {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment:currentMessage.sender !=
              SessionManager.getChatId() ? CrossAxisAlignment.start:CrossAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: '${currentMessage.url}',
                placeholder: (context, url) => const CustomLoaderWidget(),
                errorWidget: (context, url, error) => const Icon(
                  CupertinoIcons.profile_circled,
                  size: 40,
                ),
                width: 150.0,
                height: 150.0,
              ),
            ),
            SizedBox(height: 5.0),
            Visibility(
              visible: currentMessage.text!.isNotEmpty,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                decoration: BoxDecoration(
                    color: currentMessage.sender != SessionManager.getChatId()
                        ? Colors.grey.shade200
                        : kAppBarColor.withOpacity(0.8),
                    borderRadius:
                        currentMessage.sender != SessionManager.getChatId()
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                              )
                            : const BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0),
                              )),
                child: CustomTextWidget(
                  text: currentMessage.text.toString(),
                  textColor: Theme.of(context).primaryColorLight,
                  fontSize: 13,
                ),
              ),
            )
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
          color: currentMessage.sender != SessionManager.getChatId()
              ? Colors.grey.shade200
              : kAppBarColor.withOpacity(0.8),
          borderRadius: currentMessage.sender != SessionManager.getChatId()
              ? const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                )),
      child: CustomTextWidget(
        text: currentMessage.text.toString(),
        textColor: Theme.of(context).primaryColorLight,
        fontSize: 13,
      ),
    );
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

  void sendMessage() async {
    String msg = messageController.text.trim();
    final data = Provider.of<FileProvider>(context, listen: false);

    if (data.selectedFilePath.isEmpty) {
      if (msg.isEmpty) {
        Helper.showToastMessage('Enter message', Colors.red);
        return;
      }
      messageController.clear();
      FirebaseHelper.sendMessage(msg, userChat!, chatRoom!, 'TEXT', '');
    } else {
      if (msg.isEmpty) {
        msg = "";
      }
      messageController.clear();
      uploadPhoto(msg);
    }
  }

  void uploadPhoto(String message) {
    final data = Provider.of<FileProvider>(context, listen: false);
    Helper.showLoaderDialog(context, message: 'Upload media...');

    ApiHelper.uploadCarouselImage(data.selectedFilePath).then((value) {
      Navigator.pop(context);
      if (value.apiStatus!.toLowerCase() == 'true') {
        String fileUrl = value.path! + value.image!;
        FirebaseHelper.sendMessage(
            message, userChat!, chatRoom!, 'IMAGE', fileUrl);
        data.removeImage();
      }
    });
  }
}
/*
     return Row(
                            mainAxisAlignment: (currentMessage.sender ==
                                    SessionManager.getChatId())
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: (currentMessage.sender ==
                                            SessionManager.getChatId())
                                        ? Colors.amber
                                        : Colors.grey.shade200,
                                    borderRadius: currentMessage.sender !=
                                        SessionManager.getChatId()
                                        ? const BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            topRight: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0),
                                          )
                                        : const BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            topRight: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0),
                                          ),
                                  ),
                                  child: Expanded(
                                    child: CustomTextWidget(
                                      text: currentMessage.text.toString(),
                                      textColor:
                                          Theme.of(context).primaryColorLight,
                                      fontSize: 12,
                                    ),
                                  )),
                            ],
                          );
 */
