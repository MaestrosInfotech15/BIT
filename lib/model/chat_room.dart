class ChatRoom {
  String? chatroomId;
  Map<String, dynamic>? participants;
  String? lastMessage;

  ChatRoom({this.chatroomId, this.participants, this.lastMessage});

  ChatRoom.fromMap(Map<String, dynamic> map) {
    chatroomId = map["chatroom_id"];
    participants = map["participants"];
    lastMessage = map["last_message"];
  }

  Map<String, dynamic> toMap() {
    return {
      "chatroom_id": chatroomId,
      "participants": participants,
      "last_message": lastMessage
    };
  }
}
