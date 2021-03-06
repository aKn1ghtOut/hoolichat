import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hoolichat/providers/api.dart';
import 'package:hoolichat/widgets/rooms_list.dart';

import 'package:provider/provider.dart';
import 'package:share/share.dart';

class RoomsView extends StatefulWidget {
  RoomsView([Key? key]) : super(key: key);

  @override
  _RoomsViewState createState() => _RoomsViewState();
}

class _RoomsViewState extends State<RoomsView> {
  bool selectionOn = false;

  String selectedTitle = '';

  void setSelectedOn() {
    if (!this.selectionOn)
      this.setState(() {
        selectionOn = true;
      });
  }

  void setSelectedOff() {
    if (this.selectionOn)
      this.setState(() {
        selectionOn = false;
      });
  }

  void setTitle(String value) {
    setState(() {
      selectedTitle = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hoolichat'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.read<APIProvider>().logout();
          },
          icon: Icon(FontAwesomeIcons.powerOff),
        ),
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Share.share(
                    'Join my Hoolichat server today. Use Workspace ID:' +
                        context.read<APIProvider>().workspaceId +
                        ' at signup!');
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('New Room'),
            content: TextField(
              onChanged: (String msg) {
                setState(() {
                  selectedTitle = msg;
                });
              },
              decoration: InputDecoration(hintText: 'Room title'),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  context.read<APIProvider>().newRoom(selectedTitle);
                  Navigator.pop(context, 'OK');
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).accentColor,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        height: this.selectionOn ? 30 : 0,
                        decoration: BoxDecoration(
                            color: this.selectionOn
                                ? Colors.black
                                : Color(0x00000000)),
                        child: Row(
                          children: [],
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            child: RoomsList(
                              onSelectDisable: this.setSelectedOff,
                              onSelectEnable: this.setSelectedOn,
                              goToRoom: (String roomId) {
                                Beamer.of(context)
                                    // ignore: unnecessary_brace_in_string_interps
                                    .beamToNamed('/room/${roomId}');
                              },
                            ),
                          ),
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
