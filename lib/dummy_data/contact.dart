class Contact {
  Contact(
      {required this.id,
      required this.email,
      required this.name,
      required this.display,
      required this.status})
      : super();

  String id;
  // Hive fields go here

  String name;

  String email;

  String display;

  String status;
}
