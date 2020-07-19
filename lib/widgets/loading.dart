import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Image.asset('assets/images/icon.png',
          width: 72,),
          Text("Habo", style: Theme.of(context).textTheme.headline5,),
        ],
      )),
    ));
  }
}
