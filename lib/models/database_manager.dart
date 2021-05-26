import 'dart:io';

import 'package:hoolichat/models/schema.dart';
import 'package:moor/moor.dart';
import 'package:moor/ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database_manager.g.dart';

LazyDatabase openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Users, Rooms, Messages])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  Future removeAllUsers() {
    return (delete(users)..where((u) => u.id.isBiggerThanValue(-1))).go();
  }

  Future removeAllMessages() {
    return (delete(messages)..where((m) => m.id.isBiggerThanValue(-1))).go();
  }

  Future removeAllRooms() {
    return (delete(rooms)..where((r) => r.id.isBiggerThanValue(-1))).go();
  }

  Future logout() {
    return Future.wait([
      removeAllMessages(),
      removeAllRooms(),
      removeAllUsers(),
    ]);
  }

  Stream<List<Message>> watchRoomMessages(String roomId) {
    return (select(messages)
          ..where((m) => m.roomId.equals(roomId))
          ..orderBy([
            (m) =>
                OrderingTerm(expression: m.createdAt, mode: OrderingMode.desc)
          ])
          ..limit(50))
        .watch();
  }

  Stream<Room> watchRoom(String roomId) {
    return (select(rooms)..where((m) => m.roomId.equals(roomId))).watchSingle();
  }

  Stream<User> watchUser(String userId) {
    return (select(users)..where((m) => m.userId.equals(userId))).watchSingle();
  }

  Stream<List<Room>> getRooms() {
    return (select(
            rooms) /*.join([leftOuterJoin(messages, rooms.roomId.equalsExp(messages.roomId))])*/)
        .watch();
  }

  Future addUser(Map<String, dynamic> data) async {
    var exists = (await (select(users)
                  ..where((tbl) => tbl.userId.equals(data['_id'])))
                .get())
            .length >
        0;
    if (!exists)
      return (into(users).insert(UsersCompanion(
        fullName: Value(data['full_name']),
        userId: Value(data['_id']),
        display: Value('https://picsum.photos/200/200'),
        email: Value(data['email']),
        status: Value(data['phone']),
      )));
  }

  Future addRoom(Map<String, dynamic> data) async {
    var exists = (await (select(rooms)
                  ..where((tbl) => tbl.roomId.equals(data['_id'])))
                .get())
            .length >
        0;
    if (!exists)
      return (into(rooms).insert(RoomsCompanion(
        title: Value(data['name']),
        roomId: Value(data['_id']),
        display: Value('https://picsum.photos/200/200'),
        createdAt: Value(DateTime.now()),
      )));
  }

  Future addMessage(Map<String, dynamic> data) async {
    var exists = (await (select(messages)
                  ..where((tbl) => tbl.messageId.equals(data['_id'])))
                .get())
            .length >
        0;
    if (!exists)
      return (into(messages).insert(MessagesCompanion(
        content: Value(data['text']),
        roomId: Value(data['room']),
        messageId: Value(data['_id']),
        senderId: Value(data['user']),
        createdAt: Value(DateTime.now()),
      )));
  }

  void deleteMessage(String messageId) {
    (delete(messages)..where((tbl) => tbl.messageId.equals(messageId))).go();
  }
}
