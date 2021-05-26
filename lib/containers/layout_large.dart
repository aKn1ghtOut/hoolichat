import 'package:flutter/material.dart';

class LayoutLarge extends StatefulWidget {
  final Widget body;

  LayoutLarge({required this.body});

  @override
  _LayoutLargeState createState() => _LayoutLargeState();
}

class _LayoutLargeState extends State<LayoutLarge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hoolichat'),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
        elevation: 0.0,
        backgroundColor: Color(0xff111111),
      ),
      backgroundColor: Color(0xff111111),
      body: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Expanded(
                    child: Container(
                      child: Center(
                        child: Text(""),
                      ),
                    ),
                  ),
                  height: 90.0,
                  color: Color(0xff111111),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Expanded(
                            child: Container(
                              child: Center(
                                child: this.widget.body,
                              ),
                            ),
                          ),
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          decoration: BoxDecoration(
                              color: Color(0xff555555),
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
