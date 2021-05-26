import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'package:hoolichat/models/database_manager.dart';
import 'package:hoolichat/service_locator.dart';

class APIProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String? _jwtToken, _userId, _workspaceId;
  Socket? messages;
  bool _loggedIn = false, _loaded = false;

  bool get loggedIn => _loggedIn;
  String get jwtToken => _jwtToken ?? '';
  String get workspaceId => _workspaceId ?? '';
  String get userId => _userId ?? '';
  bool get loaded => _loaded;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('jwtToken', jwtToken));
    properties.add(StringProperty('userId', userId));
    properties.add(StringProperty('workspaceId', workspaceId));
  }

  String domain = 'https://hooliapi.snu-labyrinth.tech/';

  void init() {
    if (!_loggedIn)
      SharedPreferences.getInstance().then((sharedPreferences) {
        _jwtToken = sharedPreferences.getString("authToken");
        if (_jwtToken != null) {
          _loggedIn = true;
          _workspaceId = sharedPreferences.getString("workspaceId");
          _userId = sharedPreferences.getString("_userId");
          //checkLogin();
          socketInit();
          reloadRoomsAndUsers();
        }
        _loaded = true;
        notifyListeners();
      });
  }

  void checkLogin() {
    http.get(Uri.parse(domain + 'workspace'),
        headers: {'Authorization': jwtToken}).then((value) {
      if (value.statusCode == 200)
        _loggedIn = true;
      else
        _loggedIn = false;
    });
  }

  void reloadRoomsAndUsers() {
    http.get(Uri.parse(domain + 'workspace/' + workspaceId), headers: {
      'Authorization': jwtToken,
    }).then((resp) {
      print(resp.body);
      print(domain + 'workspace/' + workspaceId);
      if (resp.statusCode == 200) {
        Map<String, dynamic> data = json.decode(resp.body);
        List<dynamic> rooms = data['rooms'];
        List<dynamic> users = data['users'];
        var db = locator<AppDatabase>();
        rooms.forEach((element) {
          db.addRoom(element);
        });
        users.forEach((element) {
          db.addUser(element);
        });
      }
    });
  }

  void sendMessage(String message, String roomId) {
    var data = {'room': roomId, 'user': jwtToken, 'msg': message};
    print(data);
    print(messages?.connected);
    messages?.emit('post-message', data);
  }

  void login(
      String email, String password, String workspaceid, bool newWorkspace,
      {Function(String)? failureCallback}) {
    var bodyUsed = json.encode(<String, String>{
      'email': email,
      'password': password,
    });
    http
        .post(Uri.parse(domain + 'auth/login'),
            headers: {"Content-Type": "application/json"}, body: bodyUsed)
        .then((response) {
      print(response.statusCode);
      if (response.statusCode == 202) {
        Map<String, dynamic> respBody = json.decode(response.body);
        String tempToken = respBody['token'];
        Map<String, dynamic> userInfo = respBody['userInfo'];
        print("Workspace id received: " + tempToken);
        if (newWorkspace) {
          http
              .post(
            Uri.parse(domain + 'workspace/'),
            headers: {
              "Content-Type": "application/json",
              'Authorization': tempToken
            },
            body: json.encode({'name': workspaceid}),
          )
              .then((resp) {
            Map<String, dynamic> workDet = json.decode(resp.body);
            if (resp.statusCode == 201) {
              SharedPreferences.getInstance().then((sp) {
                sp.setString("authToken", tempToken);
                sp.setString("workspaceId", workDet['_id']);
                sp.setString("_userId", userInfo['_id'].toString());

                _loggedIn = true;
                _jwtToken = tempToken;
                _userId = userInfo['_id'];
                _workspaceId = workDet['_id'];

                reloadRoomsAndUsers();

                notifyListeners();
              });
            } else
              failureCallback!("Invalid Workspace ID");
          });
        } else {
          print("Workspace id received: " + tempToken);
          http.patch(
            Uri.parse(domain + 'workspace/add-user/' + workspaceid),
            headers: {
              "Content-Type": "application/json",
              'Authorization': tempToken
            },
          ).then((resp) {
            if (resp.statusCode == 201 || resp.statusCode == 409) {
              SharedPreferences.getInstance().then((sp) {
                sp.setString("authToken", tempToken);
                sp.setString("workspaceId", workspaceid);
                sp.setString("_userId", userInfo['_id'].toString());

                _loggedIn = true;
                _jwtToken = tempToken;
                _userId = userInfo['_id'];
                _workspaceId = workspaceid;

                reloadRoomsAndUsers();

                notifyListeners();
              });
            } else
              failureCallback!("Invalid Workspace ID");
          });
        }
      } else
        failureCallback!('Invalid username/password.');
    });
  }

  void socketInit() {
    messages = io(domain, <String, dynamic>{
      'transports': ['websocket'],
      'forceNew': true
    }); //WebSocketChannel.connect(Uri.parse(domain));
    messages?.on('newMessage', (data) {
      print('here');
      this.streamListener(data);
    });
    messages?.on('test-message', (data) {
      print(data);
    });
    messages?.onConnect((_) {
      print('connected');
    });
    messages?.on('message-error', (error) {
      print(error);
    });
  }

  void newRoom(String title) {
    var _body = json.encode({
      'workspace': workspaceId,
      'name': title,
      'description': title,
    });
    print(_body);
    http
        .post(Uri.parse(domain + 'room'),
            headers: {
              'Authorization': jwtToken,
              "Content-Type": "application/json",
            },
            body: _body)
        .then((resp) {
      print(resp.statusCode.toString() + resp.body);
      if (resp.statusCode == 201) {
        reloadRoomsAndUsers();
      }
    });
  }

  void register(String email, String password, String fullname, String username,
      String phone, String workspaceid, bool newWorkspace,
      {Function(String)? failureCallback}) {
    var bodyUsed = json.encode({
      'email': email,
      'password': password,
      'username': username,
      'full_name': fullname,
      'phone': phone
    });
    http
        .post(
      Uri.parse(domain + 'auth/register'),
      headers: {
        "Content-Type": "application/json",
      },
      body: bodyUsed,
    )
        .then((response) {
      if (response.statusCode == 201) {
        print(response.body);
        Map<String, dynamic> respBody = json.decode(response.body);
        String tempToken = respBody['token'];
        Map<String, dynamic> userInfo = respBody['userInfo'];
        print("Workspace id received: " + tempToken);
        if (newWorkspace) {
          http
              .post(
            Uri.parse(domain + 'workspace/'),
            headers: {
              "Content-Type": "application/json",
              'Authorization': tempToken
            },
            body: json.encode({'name': workspaceid}),
          )
              .then((resp) {
            Map<String, dynamic> workDet = json.decode(resp.body);
            if (resp.statusCode == 201) {
              SharedPreferences.getInstance().then((sp) {
                sp.setString("authToken", tempToken);
                sp.setString("workspaceId", workDet['_id']);
                sp.setString("_userId", userInfo['_id'].toString());

                _loggedIn = true;
                _jwtToken = tempToken;
                _userId = userInfo['_id'];
                _workspaceId = workDet['_id'];

                reloadRoomsAndUsers();

                notifyListeners();
              });
            } else
              failureCallback!("Invalid Workspace ID");
          });
        } else {
          http.post(
            Uri.parse(domain + 'workspace/' + workspaceid),
            headers: {
              "Content-Type": "application/json",
              'Authorization': tempToken,
            },
          ).then((resp) {
            print(resp.body);
            if (resp.statusCode == 200) {
              SharedPreferences.getInstance().then((sp) {
                sp.setString("authToken", tempToken);
                sp.setString("workspaceId", workspaceid);
                sp.setString("_userId", userInfo['_id'] ?? '');

                _loggedIn = true;
                _jwtToken = tempToken;
                _userId = userInfo['_id'];

                reloadRoomsAndUsers();

                notifyListeners();
              });
            } else
              failureCallback!("Invalid Workspace ID");
          });
        }
      } else
        failureCallback!('Invalid user details.');
    });
  }

  void logout() {
    SharedPreferences.getInstance().then((sharedPreferences) {
      _jwtToken = '';
      sharedPreferences.remove("authToken");
      _loggedIn = false;
      _workspaceId = '';
      sharedPreferences.remove("workspaceId");
      _userId = '';
      sharedPreferences.remove("_userId");
      _loaded = true;
      notifyListeners();
      locator<AppDatabase>().logout();
    });
  }

  void streamListener(event) {
    print(event);
    Map<String, dynamic> data = event;
    locator<AppDatabase>().addMessage(data);
  }
}
