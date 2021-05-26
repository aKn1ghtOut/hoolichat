import 'package:flutter/material.dart';

import './rooms_tile.dart';

import 'package:hoolichat/models/database_manager.dart';
import 'package:hoolichat/service_locator.dart';

class RoomsList extends StatefulWidget {
  const RoomsList(
      {Key? key,
      required this.onSelectDisable,
      required this.onSelectEnable,
      required this.goToRoom})
      : super(key: key);

  final VoidCallback onSelectEnable, onSelectDisable;
  final Function(String) goToRoom;

  @override
  _RoomsListState createState() => _RoomsListState();
}

class _RoomsListState extends State<RoomsList> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Room>>(
        stream: locator<AppDatabase>().getRooms(),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return ListView.separated(
              itemCount: snapshot.data?.length ?? 0,
              shrinkWrap: false,
              itemBuilder: (BuildContext b, int i) => RoomsTile(
                key: ValueKey(snapshot.data?[i].roomId),
                lastBy: "",
                lastMessage: "Hey there no",
                roomId: snapshot.data?[i].roomId ?? "",
                title: snapshot.data?[i].title ?? "",
                display: snapshot.data?[i].display ?? "",
                lastAt: "now",
                onClick: (String roomId) {
                  print("Clicked room " + roomId);
                  this.widget.goToRoom(roomId);
                },
                onLongClick: (String roomid, int inc) {
                  this.setState(() {
                    selected += inc;
                    if (selected > 0)
                      this.widget.onSelectEnable();
                    else
                      this.widget.onSelectDisable();
                  });
                },
              ),
              separatorBuilder: (context, index) {
                return Divider();
              },
            );
          else
            return Container();
        });
  }
}
