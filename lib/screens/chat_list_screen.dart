import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/firebase/firebase_helper.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:book_indian_talents_app/model/chat_room.dart';
import 'package:book_indian_talents_app/model/user_chat.dart';
import 'package:book_indian_talents_app/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatefulWidget {
  static const String id = 'chat_list_screen';

  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: 'Chats',
          textColor: Theme.of(context).primaryColorLight,
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chatrooms")
            .where("participants.${SessionManager.getChatId()}",
                isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              QuerySnapshot chatRoomSnapshot = snapshot.data as QuerySnapshot;

              return ListView.builder(
                itemCount: chatRoomSnapshot.docs.length,
                itemBuilder: (context, index) {
                  ChatRoom chatRoomModel = ChatRoom.fromMap(
                      chatRoomSnapshot.docs[index].data()
                          as Map<String, dynamic>);

                  Map<String, dynamic> participants =
                      chatRoomModel.participants!;

                  List<String> participantKeys = participants.keys.toList();
                  participantKeys.remove(SessionManager.getChatId());

                  return FutureBuilder(
                    future: FirebaseHelper.getUserModelById(participantKeys[0]),
                    builder: (context, userData) {
                      if (userData.connectionState == ConnectionState.done) {
                        if (userData.data != null) {
                          UserChat targetUser = userData.data as UserChat;

                          /*
                              return ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return ChatRoomPage(
                                        chatroom: chatRoomModel,
                                        firebaseUser: widget.firebaseUser,
                                        userModel: widget.userModel,
                                        targetUser: targetUser,
                                      );
                                    }),
                                  );
                                },
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(targetUser.profilepic.toString()),
                                ),
                                title: Text(targetUser.fullname.toString()),
                                subtitle: (chatRoomModel.lastMessage.toString() != "") ? Text(chatRoomModel.lastMessage.toString()) : Text("Say hi to your new friend!", style: TextStyle(
                                  color: Theme.of(context).colorScheme.secondary,
                                ),),
                              );
                              */

                          return InkWell(
                            onTap: () {
                              /* Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return ChatRoomPage(
                                    chatroom: chatRoomModel,
                                    firebaseUser: widget.firebaseUser,
                                    userModel: widget.userModel,
                                    targetUser: targetUser,
                                  );
                                }),
                              );
                              */
                              Map<String, dynamic> data = {
                                'chat_room': chatRoomModel,
                                'target_user': targetUser
                              };
                              Navigator.pushNamed(context, ChatScreen.id,
                                  arguments: data);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.grey.shade100,
                                  border: Border.all(
                                    color: kAppBarColor,
                                    width: 0.5,
                                  )),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: kAppBarColor,
                                    backgroundImage: NetworkImage(
                                        targetUser.profilePic.toString()),
                                  ),
                                  const SizedBox(width: 25.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomTextWidget(
                                          text: targetUser.fullName ?? '',
                                          textColor: Theme.of(context)
                                              .primaryColorLight,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        chatRoomModel.lastMessage.toString() !=
                                                ""
                                            ? CustomTextWidget(
                                                maxLine: 1,
                                                text: chatRoomModel.lastMessage
                                                    .toString(),
                                                textColor: kAppColor,
                                                fontSize: 12.0,
                                              )
                                            : const CustomTextWidget(
                                                text:
                                                    '',
                                                textColor: kAppColor,
                                                fontSize: 12.0,
                                              ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: false,
                                    child: Container(
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: const BoxDecoration(
                                          color: kAppBarColor,
                                          shape: BoxShape.circle),
                                      child: const Text(
                                        '5',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      } else {
                        return Container();
                      }
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(
                child: Text("No Chats"),
              );
            }
          } else {
            return const CustomLoaderWidget();
          }
        },
      ),
    );
  }
}
