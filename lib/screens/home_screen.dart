import 'package:Habo/helpers.dart';
import 'package:Habo/provider.dart';
import 'package:Habo/widgets/calendar_column.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Habo",
            style: Theme.of(context).textTheme.headline5,
          ),
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.bar_chart,
                semanticLabel: 'Statistics',
              ),
              color: Colors.grey[400],
              tooltip: 'Statistics',
              onPressed: () {
                Provider.of<Bloc>(context, listen: false).hideSnackBar();
                navigateToStatisticsPage(context);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.settings,
                semanticLabel: 'Settings',
              ),
              color: Colors.grey[400],
              tooltip: 'Settings',
              onPressed: () {
                Provider.of<Bloc>(context, listen: false).hideSnackBar();
                navigateToSettingsPage(context);
              },
            ),
          ],
        ),
        body: CalendarColumn(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<Bloc>(context, listen: false).hideSnackBar();
            navigateToCreatePage(context);
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
            semanticLabel: 'Add',
            size: 35.0,
          ),
        ),
      ),
    );
  }
}
