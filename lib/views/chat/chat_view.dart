import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:hoolichat/providers/api.dart';
import 'package:hoolichat/widgets/inchat_notice.dart';
import 'package:hoolichat/widgets/message.dart' as Ms;
import 'package:hoolichat/widgets/message_box.dart';

import 'package:hoolichat/models/database_manager.dart';
import 'package:hoolichat/service_locator.dart';

import 'package:provider/provider.dart';

class ChatView extends StatefulWidget {
  ChatView({Key? key, required this.roomId}) : super(key: key);

  final String roomId;
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  var title = "Chat";
  final chatboxKey = 'chatboxKey';
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Room>(
        stream: locator<AppDatabase>().watchRoom(widget.roomId),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Container();
          else
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Beamer.of(context).beamBack();
                  },
                ),
                title: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 8, 5),
                      child: Hero(
                        tag: "roomIcon_${widget.roomId}",
                        child: ClipOval(
                            child: Image.network(
                          snapshot.data?.display ?? '',
                          width: 30,
                          height: 30,
                        )),
                      ),
                    ),
                    Text(snapshot.data?.title ?? "")
                  ],
                ),
                titleSpacing: 0,
                elevation: 0.0,
                backgroundColor: Theme.of(context).primaryColor,
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
              ),
              extendBodyBehindAppBar: false,
              body: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Theme.of(context).backgroundColor,
                      child: StreamBuilder<List<Message>>(
                          stream: locator<AppDatabase>()
                              .watchRoomMessages(widget.roomId),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData || snapshot.data?.length == 0)
                              return Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InchatNotice(
                                      label: 'No messages yet!',
                                    ),
                                  ],
                                ),
                              );
                            return ListView.builder(
                              itemCount: snapshot.data?.length ?? 0,
                              reverse: true,
                              itemBuilder: (context, index) {
                                if (index ==
                                    (snapshot.data?.length ?? (index + 2)) - 1)
                                  return Column(
                                    children: [
                                      InchatNotice(
                                        label: 'Today',
                                      ),
                                      Ms.Message(
                                        messageId:
                                            snapshot.data?[index].messageId ??
                                                '',
                                        content:
                                            snapshot.data?[index].content ?? '',
                                        key: ValueKey(
                                            snapshot.data?[index].messageId),
                                        userId:
                                            snapshot.data?[index].senderId ??
                                                '',
                                        last: index == 0 ||
                                            snapshot.data?[index].senderId !=
                                                snapshot
                                                    .data?[index - 1].senderId,
                                        own: snapshot.data?[index].senderId ==
                                            context.read<APIProvider>().userId,
                                      ),
                                    ],
                                  );
                                return Ms.Message(
                                  messageId:
                                      snapshot.data?[index].messageId ?? '',
                                  content: snapshot.data?[index].content ?? '',
                                  key:
                                      ValueKey(snapshot.data?[index].messageId),
                                  userId: snapshot.data?[index].senderId ?? '',
                                  last: index == 0 ||
                                      snapshot.data?[index].senderId !=
                                          snapshot.data?[index - 1].senderId,
                                  own: snapshot.data?[index].senderId ==
                                      context.read<APIProvider>().userId,
                                );
                              },
                            );
                          }),
                    ),
                  ),
                  MessageBox(
                    roomId: widget.roomId,
                  ),
                ],
              ),
            );
        });
  }
}
