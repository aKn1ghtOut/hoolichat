import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:hoolichat/navigation/chat_location.dart';
import 'package:hoolichat/providers/api.dart';
import 'package:hoolichat/views/auth_view.dart';
import 'package:provider/provider.dart';

import 'package:hoolichat/service_locator.dart';

import './utils/themes/light.dart';

import './containers/layout_large.dart';

void main() async {
  await setupLocator();
  Beamer.setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routerDelegate = BeamerDelegate(
      locationBuilder: SimpleLocationBuilder(routes: {
    '': (context) => const ContentBox(key: ValueKey('rootKey'))
  }));
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => APIProvider()),
      ],
      child: MaterialApp.router(
          title: 'HooliChat',
          theme: themeLight,
          backButtonDispatcher:
              BeamerBackButtonDispatcher(delegate: routerDelegate),
          debugShowCheckedModeBanner: false,
          routeInformationParser: BeamerParser(),
          routerDelegate: routerDelegate),
    );
  }
}

class ContentBox extends StatefulWidget {
  const ContentBox({Key? key}) : super(key: key);

  @override
  _ContentBoxState createState() => _ContentBoxState();
}

class _ContentBoxState extends State<ContentBox> {
  Widget? _layoutLarge, _layoutSmall;
  BeamerDelegate _beamerDelegate = BeamerDelegate(
      setBrowserTabTitle: true,
      locationBuilder: BeamerLocationBuilder(beamLocations: [ChatLocation()]));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _layoutLarge = LayoutLarge(
      body: Text(""),
    );
    _layoutSmall =
        Beamer(key: ValueKey('RootBeamer'), routerDelegate: _beamerDelegate);
  }

  @override
  Widget build(BuildContext context) {
    context.read<APIProvider>().init();

    return context.watch<APIProvider>().loggedIn
        ? Container(
            child: MediaQuery.of(context).size.width > 1000
                ? _layoutLarge
                : _layoutSmall,
          )
        : AuthView();
  }
}
