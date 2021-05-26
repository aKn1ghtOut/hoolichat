import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:hoolichat/views/chat/chat_view.dart';
import 'package:hoolichat/views/chat/rooms_view.dart';

class ChatLocation extends BeamLocation {
  ChatLocation({BeamState? state}) : super(state);

  List<String> get pathBlueprints => [
        "",
        "/room/:roomId",
      ];

  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
            child: RoomsView(),
            title: "Chat Page",
            key: ValueKey('home'),
            type: BeamPageType.cupertino),
        if (state.pathParameters.containsKey("roomId"))
          BeamPage(
              key: ValueKey('chatViewPage-${state.pathParameters['roomId']}'),
              child: ChatView(
                key: ValueKey('chatView-${state.pathParameters['roomId']}'),
                roomId: state.pathParameters['roomId'] ?? '',
              ))
      ];
}
