import 'package:Habo/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  Future<void> testTime(context) async {
    TimeOfDay selectedTime;
    TimeOfDay initialTime =
        Provider.of<Bloc>(context, listen: false).getDailyNot;
    selectedTime = await showTimePicker(
        context: context,
        initialTime: (initialTime != null)
            ? initialTime
            : TimeOfDay(hour: 20, minute: 0));
    if (selectedTime != null)
      Provider.of<Bloc>(context, listen: false).setDailyNot = selectedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Settings',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          backgroundColor: Colors.transparent,
          iconTheme: Theme.of(context).iconTheme,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text("Theme"),
                trailing: DropdownButton<String>(
                  items: Provider.of<Bloc>(context)
                      .getThemeList
                      .map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(
                        value,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }).toList(),
                  value: Provider.of<Bloc>(context).getTheme,
                  onChanged: (value) {
                    Provider.of<Bloc>(context, listen: false).setTheme = value;
                  },
                ),
              ),
              ListTile(
                title: Text("First day of the week"),
                trailing: DropdownButton<String>(
                  alignment: Alignment.center,
                  items: Provider.of<Bloc>(context)
                      .getWeekStartList
                      .map((String value) {
                    return new DropdownMenuItem<String>(
                      alignment: Alignment.center,
                      value: value,
                      child: new Text(
                        value,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }).toList(),
                  value: Provider.of<Bloc>(context).getWeekStart,
                  onChanged: (value) {
                    Provider.of<Bloc>(context, listen: false).setWeekStart =
                        value;
                  },
                ),
              ),
              ListTile(
                title: Text("Notifications"),
                trailing: Switch(
                  value: Provider.of<Bloc>(context).getShowDailyNot,
                  onChanged: (value) {
                    Provider.of<Bloc>(context, listen: false).setShowDailyNot =
                        value;
                  },
                ),
              ),
              ListTile(
                enabled: Provider.of<Bloc>(context).getShowDailyNot,
                title: Text("Notification time"),
                trailing: InkWell(
                  onTap: () {
                    if (Provider.of<Bloc>(context, listen: false)
                        .getShowDailyNot) {
                      testTime(context);
                    }
                  },
                  child: Text(
                    Provider.of<Bloc>(context)
                            .getDailyNot
                            .hour
                            .toString()
                            .padLeft(2, '0') +
                        ":" +
                        Provider.of<Bloc>(context)
                            .getDailyNot
                            .minute
                            .toString()
                            .padLeft(2, '0'),
                    style: TextStyle(
                        color: (Provider.of<Bloc>(context).getShowDailyNot)
                            ? null
                            : Theme.of(context).disabledColor),
                  ),
                ),
              ),
              ListTile(
                title: Text("Sound effects"),
                trailing: Switch(
                  value: Provider.of<Bloc>(context).getSoundEffects,
                  onChanged: (value) {
                    Provider.of<Bloc>(context, listen: false).setSoundEffects =
                        value;
                  },
                ),
              ),
              ListTile(
                title: Text("Show month name"),
                trailing: Switch(
                  value: Provider.of<Bloc>(context).getShowMonthName,
                  onChanged: (value) {
                    Provider.of<Bloc>(context, listen: false).setShowMonthName =
                        value;
                  },
                ),
              ),
              ListTile(
                title: Text("About"),
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationIcon: Image.asset(
                      "assets/images/icon.png",
                      width: 55,
                      height: 55,
                    ),
                    applicationName: 'Habo',
                    applicationVersion:
                        Provider.of<Bloc>(context, listen: false)
                            .getPackageInfo
                            .version,
                    applicationLegalese: '©2021 Habo',
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyText2,
                            children: [
                              TextSpan(
                                style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline),
                                text: "Terms and Conditions\n",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    final url =
                                        'https://habo.space/terms.html#terms';
                                    if (await canLaunch(url)) {
                                      await launch(
                                        url,
                                        forceSafariVC: false,
                                      );
                                    }
                                  },
                              ),
                              TextSpan(
                                style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline),
                                text: "Privacy Policy\n",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    final url =
                                        'https://habo.space/terms.html#privacy';
                                    if (await canLaunch(url)) {
                                      await launch(
                                        url,
                                        forceSafariVC: false,
                                      );
                                    }
                                  },
                              ),
                              TextSpan(
                                style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline),
                                text: "Disclaimer\n",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    final url =
                                        'https://habo.space/terms.html#disclaimer';
                                    if (await canLaunch(url)) {
                                      await launch(
                                        url,
                                        forceSafariVC: false,
                                      );
                                    }
                                  },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
