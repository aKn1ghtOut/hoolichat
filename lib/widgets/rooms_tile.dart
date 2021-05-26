import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RoomsTile extends StatefulWidget {
  final String title, lastMessage, display, lastAt, roomId, lastBy;
  final void Function(String) onClick;
  final void Function(String, int) onLongClick;
  const RoomsTile({
    Key? key,
    required this.lastBy,
    required this.lastMessage,
    required this.roomId,
    required this.lastAt,
    required this.display,
    required this.onClick,
    required this.onLongClick,
    required this.title,
  }) : super(key: key);

  @override
  _RoomsTileState createState() => _RoomsTileState();
}

class _RoomsTileState extends State<RoomsTile> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      borderRadius: BorderRadius.circular(20.0),
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
          selected: this.selected,
          mouseCursor: SystemMouseCursors.click,
          contentPadding:
              EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
          leading: Hero(
            tag: "roomIcon_${widget.roomId}",
            child: ClipOval(
              child: Image.network(this.widget.display),
            ),
          ),
          focusColor: Theme.of(context).accentColor,
          onTap: () {
            widget.onClick(this.widget.roomId);
          },
          onLongPress: () => this.setState(() {
            selected = !selected;
            this.widget.onLongClick(widget.roomId, selected ? 1 : -1);
          }),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    "${widget.lastBy}: ",
                    style:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.lastMessage,
                    style: TextStyle(fontSize: 12.0),
                  )
                ],
              )
            ],
          ),
          trailing: Text(this.widget.lastAt),
        ),
      ),
    );
  }
}
