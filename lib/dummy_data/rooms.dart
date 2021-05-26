import 'room.dart';

class RoomsDummy {
  List<Room> dummyRooms = [];
  RoomsDummy() {
    dummyRooms.addAll([
      Room(
          id: "fghj",
          title: "Room 2",
          createdAt: "Available",
          display: "https://picsum.photos/200/200"),
      Room(
          id: "GENERAL",
          title: "General",
          createdAt: "Available",
          display: "https://picsum.photos/200/200"),
      Room(
          id: "fgshj",
          title: "Room 2",
          createdAt: "Available",
          display: "https://picsum.photos/200/200"),
      Room(
          id: "GENdERAL",
          title: "General",
          createdAt: "Available",
          display: "https://picsum.photos/200/200"),
      Room(
          id: "fgghj",
          title: "Room 2",
          createdAt: "Available",
          display: "https://picsum.photos/200/200"),
      Room(
          id: "GEgNERAL",
          title: "General",
          createdAt: "Available",
          display: "https://picsum.photos/200/200"),
      Room(
          id: "fgyhj",
          title: "Room 2",
          createdAt: "Available",
          display: "https://picsum.photos/200/200"),
      Room(
          id: "GtENERAL",
          title: "General",
          createdAt: "Available",
          display: "https://picsum.photos/200/200"),
      Room(
          id: "fgyhwj",
          title: "Room 2",
          createdAt: "Available",
          display: "https://picsum.photos/200/200"),
      Room(
          id: "GtENwERAL",
          title: "General",
          createdAt: "Available",
          display: "https://picsum.photos/200/200"),
      Room(
          id: "fgyehj",
          title: "Room 2",
          createdAt: "Available",
          display: "https://picsum.photos/200/200"),
      Room(
          id: "GtENEeRAL",
          title: "General",
          createdAt: "Available",
          display: "https://picsum.photos/200/200"),
    ]);
  }

  List<Room> get getDummyRooms => dummyRooms;
}
