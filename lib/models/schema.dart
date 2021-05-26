import 'package:moor/moor.dart';

import 'package:moor/ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'schema.g.dart';

@DataClassName("User")
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get fullName => text().withLength(min: 6, max: 32)();
  TextColumn get display => text().nullable()();
  TextColumn get email => text()();
  TextColumn get status => text()();
}

@DataClassName("Room")
class Rooms extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get display => text().nullable()();
  TextColumn get roomId => text()();
  DateTimeColumn get createdAt => dateTime()();
}

@DataClassName("Message")
class Messages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get messageId => text()();
  TextColumn get content => text().nullable()();
  TextColumn get senderId => text()();
  TextColumn get roomId => text()();
  DateTimeColumn get createdAt => dateTime()();
}
