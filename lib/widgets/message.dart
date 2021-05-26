import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:hoolichat/models/database_manager.dart';
import 'package:hoolichat/service_locator.dart';

class Message extends StatelessWidget {
  const Message(
      {Key? key,
      required this.userId,
      required this.messageId,
      this.own = false,
      this.last = false,
      this.content =
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."})
      : super(key: key);

  final String content, userId, messageId;
  final bool own, last;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          !this.own ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        CupertinoContextMenu(
          actions: <Widget>[
            CupertinoContextMenuAction(
              child: const Text('Delete'),
              onPressed: () {
                locator<AppDatabase>().deleteMessage(messageId);
              },
            ),
          ],
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: min(MediaQuery.of(context).size.width - 80, 400),
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  this.own ? 0 : 10, 5, this.own ? 20 : 0, this.last ? 10 : 5),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    decoration: BoxDecoration(
                      //border: Border.all(color: Color(0x33000000)),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: this.last
                            ? (this.own
                                ? Radius.circular(20)
                                : Radius.circular(2))
                            : Radius.circular(20),
                        bottomRight: this.last
                            ? (!this.own
                                ? Radius.circular(20)
                                : Radius.circular(2))
                            : Radius.circular(20),
                      ),
                      color: this.own
                          ? Color(
                              0xfffafafa) //Theme.of(context).backgroundColor
                          : Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      this.content,
                      style: TextStyle(
                          color: !this.own
                              ? Theme.of(context).backgroundColor
                              : Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          fontFamily: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.fontFamily ??
                              "",
                          decoration: TextDecoration.none),
                    ),
                  ),
                  if (this.last)
                    StreamBuilder<User>(
                        stream: locator<AppDatabase>().watchUser(userId),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return Container();
                          return Text(
                            snapshot.data?.fullName ?? '',
                            style: Theme.of(context).textTheme.bodyText1,
                          );
                        })
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
