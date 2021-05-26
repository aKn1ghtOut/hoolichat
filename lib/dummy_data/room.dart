class Room {
  Room(
      {required this.createdAt,
      required this.display,
      required this.id,
      required this.title})
      : super();

  String id;
  // Hive fields go here

  String title;

  String display;

  String createdAt;
}
