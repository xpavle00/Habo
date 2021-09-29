import 'package:Habo/provider.dart';
import 'package:Habo/screens/home_screen.dart';
import 'package:Habo/screens/loading_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() => runApp(Habo());

class Habo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Bloc()),
      ],
      child: Consumer<Bloc>(
        builder: (context, counter, _) {
          final bloc = Provider.of<Bloc>(context);
          return MaterialApp(
            scaffoldMessengerKey: Provider.of<Bloc>(context).getScaffoldKey,
            theme: Provider.of<Bloc>(context).getSettings.getLight,
            darkTheme: Provider.of<Bloc>(context).getSettings.getDark,
            home: !bloc.getDataLoaded ? LoadingScreen() : HomeScreen(),
          );
        },
      ),
    );
  }
}
