import 'package:flutter/material.dart';
import 'package:hoolichat/providers/api.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AuthView extends StatefulWidget {
  AuthView({Key? key}) : super(key: key);

  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  String side = 'login',
      email = '',
      password = '',
      fullname = '',
      username = '',
      phone = '',
      workspaceInput = '';
  bool newWorkspace = false;

  int sideIndex = 0, workspaceIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login/Register"),
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
        ),
        extendBodyBehindAppBar: false,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
            child: Column(
              children: [
                Center(
                  child: ToggleSwitch(
                    initialLabelIndex: workspaceIndex,
                    key: ValueKey('WorkspaceNewOldSwitcher'),
                    labels: ['Existing Workspace', 'New Workspace'],
                    activeBgColor: Theme.of(context).primaryColor,
                    inactiveBgColor: Theme.of(context).backgroundColor,
                    activeFgColor: Theme.of(context).backgroundColor,
                    inactiveFgColor: Theme.of(context).primaryColorDark,
                    changeOnTap: true,
                    minWidth: 150.0,
                    onToggle: (chosen) {
                      this.setState(() {
                        workspaceIndex = chosen;
                        newWorkspace = chosen == 0 ? false : true;
                      });
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  color: Colors.transparent,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: newWorkspace
                          ? 'Enter New Workspace Title'
                          : 'Enter Workspace ID',
                    ),
                    onChanged: (value) {
                      this.setState(() {
                        workspaceInput = value;
                      });
                    },
                  ),
                ),
                Center(
                  child: ToggleSwitch(
                    initialLabelIndex: sideIndex,
                    key: ValueKey('LoginRegisterToggle'),
                    labels: ['Login', 'Register'],
                    activeBgColor: Theme.of(context).primaryColor,
                    inactiveBgColor: Theme.of(context).backgroundColor,
                    activeFgColor: Theme.of(context).backgroundColor,
                    inactiveFgColor: Theme.of(context).primaryColorDark,
                    changeOnTap: true,
                    onToggle: (chosen) {
                      this.setState(() {
                        sideIndex = chosen;
                        side = chosen == 0 ? 'login' : 'register';
                      });
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  color: Colors.transparent,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email Address',
                    ),
                    onChanged: (value) {
                      this.setState(() {
                        email = value;
                      });
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  color: Colors.transparent,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                    onChanged: (value) {
                      this.setState(() {
                        password = value;
                      });
                    },
                  ),
                ),
                if (side == 'register')
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        color: Colors.transparent,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Full Name',
                          ),
                          onChanged: (value) {
                            this.setState(() {
                              fullname = value;
                            });
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        color: Colors.transparent,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Username',
                          ),
                          onChanged: (value) {
                            this.setState(() {
                              username = value;
                            });
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        color: Colors.transparent,
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: 'Phone number',
                          ),
                          onChanged: (value) {
                            this.setState(() {
                              phone = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ElevatedButton(
                  child: Text('Submit'),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor)),
                  onPressed: () {
                    if (side == 'login') {
                      context
                          .read<APIProvider>()
                          .login(email, password, workspaceInput, false,
                              failureCallback: (error) {
                        print(error);
                      });
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
