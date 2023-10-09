import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:book_indian_talents_app/model/chat_room.dart';
import 'package:book_indian_talents_app/model/message.dart';
import 'package:book_indian_talents_app/model/user_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';
import 'package:uuid/uuid.dart';
class FirebaseHelper {
  static var uuid = const Uuid();
  static Future<void> registerInFireStore(String userId, UserChat userChat) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(userChat.toMap());
  }
  static Future<Map<String, dynamic>> createChatRoom(String email) async {
    QuerySnapshot dataSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .where("email", isNotEqualTo: SessionManager.getUserEmail())
        .get();

    Map<String, dynamic> userMap =
        dataSnapshot.docs[0].data() as Map<String, dynamic>;

    UserChat searchedUser = UserChat.fromMap(userMap);

    //todo:------------------------------------
    ChatRoom? chatRoom;
    Map<String, dynamic> returnedMap = {};

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .where("participants.${SessionManager.getChatId()}", isEqualTo: true)
        .where("participants.${searchedUser.uid}", isEqualTo: true)
        .get();

    if (snapshot.docs.isNotEmpty) {
      // Fetch the existing one
      var docData = snapshot.docs[0].data();
      ChatRoom existingChatroom =
          ChatRoom.fromMap(docData as Map<String, dynamic>);

      chatRoom = existingChatroom;
    } else {
      // Create a new one
      ChatRoom newChatroom = ChatRoom(
        chatroomId: uuid.v1(),
        lastMessage: "",
        participants: {
          SessionManager.getChatId(): true,
          searchedUser.uid.toString(): true,
        },
      );

      await FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(newChatroom.chatroomId)
          .set(newChatroom.toMap());

      chatRoom = newChatroom;

      log("New Chatroom Created!");
    }

    returnedMap = {
      'target_user': searchedUser,
      'chat_room': chatRoom,
    };
    return returnedMap;
  }
  static Future<UserChat> getTargetUser(String email) async {
    QuerySnapshot dataSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .where("email", isNotEqualTo: SessionManager.getUserEmail())
        .get();

    Map<String, dynamic> userMap =
        dataSnapshot.docs[0].data() as Map<String, dynamic>;

    UserChat searchedUser = UserChat.fromMap(userMap);
    return searchedUser;
  }
  static void sendMessage(
      String message, UserChat targetUser, ChatRoom chatRoom,String type,String fileUrl) {
    MessageModel newMessage = MessageModel(
        messageid: uuid.v1(),
        sender: SessionManager.getChatId(),
        createdon: DateTime.now(),
        text: message,
        type: type,
        url: fileUrl,
        seen: false);

    FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoom.chatroomId)
        .collection("messages")
        .doc(newMessage.messageid)
        .set(newMessage.toMap());

    chatRoom.lastMessage = message;

    FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoom.chatroomId)
        .set(chatRoom.toMap());
  }
  static Future<UserChat?> getUserModelById(String uid) async {
    UserChat? userModel;

    DocumentSnapshot docSnap =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();

    if (docSnap.data() != null) {
      userModel = UserChat.fromMap(docSnap.data() as Map<String, dynamic>);
    }

    return userModel;
  }
  static Future<void> markMessageAsRead(String chatId, String messageId) async {
    final DocumentReference messageRef = FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(chatId)
        .collection('messages')
        .doc(messageId);

    await messageRef.update({'seen': true});
  }



}
