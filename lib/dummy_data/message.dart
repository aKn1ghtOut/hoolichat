class Message {
  Message(
      {required this.content,
      required this.id,
      required this.roomId,
      required this.sender,
      required this.timestamp});

  String id;
  // Hive fields go here

  String sender;

  String content;

  String timestamp;

  String roomId;
}
