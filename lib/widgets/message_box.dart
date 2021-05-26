import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import 'package:hoolichat/providers/api.dart';

class MessageBox extends StatefulWidget {
  const MessageBox({
    Key? key,
    required this.roomId,
  }) : super(key: key);

  final String roomId;

  @override
  _MessageBoxState createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  String messageText = '';
  final boxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      padding: EdgeInsets.all(10.0),
      color: Theme.of(context).backgroundColor,
      child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
          child: Material(
              color: Theme.of(context).primaryColorDark,
              child: Container(
                padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: Column(
                  children: [
                    Center(
                        child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          controller: boxController,
                          onChanged: (String msg) {
                            this.setState(() {
                              messageText = msg;
                            });
                          },
                          style: TextStyle(
                            color: Theme.of(context).backgroundColor,
                          ),
                          decoration: InputDecoration(
                            hintText: "What's the message",
                            hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .backgroundColor
                                  .withAlpha(122),
                            ),
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                          cursorColor: Theme.of(context).primaryColor,
                        )),
                        IconButton(
                          padding: EdgeInsets.only(right: 15),
                          onPressed: () {
                            context
                                .read<APIProvider>()
                                .sendMessage(messageText, widget.roomId);
                            boxController.clear();
                          },
                          icon: Icon(FontAwesomeIcons.solidPaperPlane),
                          color: Theme.of(context).backgroundColor,
                        )
                      ],
                    )),
                  ],
                ),
              ))),
    );
  }
}
