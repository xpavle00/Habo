import 'package:Habo/provider.dart';
import 'package:Habo/widgets/text_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditHabitPage extends StatefulWidget {
  EditHabitPage(
      {Key key,
      this.id,
      this.title,
      this.twoDayRule,
      this.cue,
      this.routine,
      this.reward,
      this.showReward,
      this.advanced,
      this.notification,
      this.notTime})
      : super(key: key);

  final int id;
  final String title;
  final bool twoDayRule;
  final String cue;
  final String routine;
  final String reward;
  final bool showReward;
  final bool advanced;
  final bool notification;
  final TimeOfDay notTime;

  @override
  _EditHabitPageState createState() => _EditHabitPageState();
}

class _EditHabitPageState extends State<EditHabitPage> {
  TextEditingController title = TextEditingController();
  TextEditingController cue = TextEditingController();
  TextEditingController routine = TextEditingController();
  TextEditingController reward = TextEditingController();
  TimeOfDay notTime = TimeOfDay(hour: 12, minute: 0);
  bool twoDayRule = false;
  bool showReward = false;
  bool advanced = false;
  bool notification = false;

  Future<void> testTime(context) async {
    TimeOfDay selectedTime;
    TimeOfDay initialTime = notTime;
    selectedTime = await showTimePicker(
        context: context,
        initialTime: (initialTime != null)
            ? initialTime
            : TimeOfDay(hour: 20, minute: 0));
    if (selectedTime != null) {
      setState(() {
        notTime = selectedTime;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    title.text = widget.title;
    cue.text = widget.cue;
    routine.text = widget.routine;
    reward.text = widget.reward;
    twoDayRule = widget.twoDayRule;
    showReward = widget.showReward;
    advanced = widget.advanced;
    notification = widget.notification;
    notTime = widget.notTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Edit Habit'),
            backgroundColor: Colors.transparent,
            iconTheme: Theme.of(context).iconTheme,
            textTheme: Theme.of(context).textTheme,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                tooltip: 'Delete',
                onPressed: () {
                  Navigator.of(context).pop();
                  Provider.of<Bloc>(context, listen: false)
                      .deleteHabit(widget.id);
                },
              ),
            ]),
        floatingActionButton: Builder(builder: (BuildContext context) {
          return FloatingActionButton(
            onPressed: () {
              if (title.text.length != 0) {
                Provider.of<Bloc>(context, listen: false).editHabit(
                    widget.id,
                    title.text.toString(),
                    twoDayRule,
                    cue.text.toString(),
                    routine.text.toString(),
                    reward.text.toString(),
                    showReward,
                    advanced,
                    notification,
                    notTime);
                Navigator.of(context).pop();
              } else {
                Scaffold.of(context).showSnackBar(SnackBar(
                  duration: Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                  content: Text("The habit title can not be empty."),
                ));
              }
            },
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 35.0,
            ),
          );
        }),
        body: Builder(builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  TextContainer(
                    title: title,
                    hint: 'Excercise',
                    label: 'Habit',
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                          onChanged: (bool value) {
                            setState(() {
                              twoDayRule = value;
                            });
                          },
                          value: twoDayRule,
                        ),
                        Text("Use Two day rule"),
                        Tooltip(
                          child: Icon(
                            Icons.info,
                            color: Colors.grey,
                            size: 18,
                          ),
                          message:
                              "With two day rule, you can miss one day and do not lose a streak if the next day is successful.",
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: ExpansionTile(
                      title: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text(
                          "Advanced habit building",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      initiallyExpanded: advanced,
                      onExpansionChanged: (bool value) {
                        advanced = value;
                      },
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                            child: Text(
                              "This section helps you better define your habits. You should define cue, routine, and reward for every habit.",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        TextContainer(
                          title: cue,
                          hint: 'At 7:00AM',
                          label: 'Cue',
                        ),
                        ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 25),
                            title: Text("Notifications"),
                            trailing: Switch(
                                value: notification,
                                onChanged: (value) {
                                  notification = value;
                                  setState(() {});
                                })),
                        ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 25),
                            enabled: notification,
                            title: Text("Notification time"),
                            trailing: InkWell(
                              onTap: () {
                                if (Provider.of<Bloc>(context, listen: false)
                                    .getShowDailyNot) {
                                  testTime(context);
                                }
                              },
                              child: Text(
                                notTime.hour.toString().padLeft(2, '0') +
                                    ":" +
                                    notTime.minute.toString().padLeft(2, '0'),
                                style: TextStyle(
                                    color: (notification)
                                        ? null
                                        : Theme.of(context).disabledColor),
                              ),
                            )),
                        TextContainer(
                          title: routine,
                          hint: 'Do 50 pushups',
                          label: 'Routine',
                        ),
                        TextContainer(
                          title: reward,
                          hint: '15 min. of video games',
                          label: 'Reward',
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                onChanged: (bool value) {
                                  setState(() {
                                    showReward = value;
                                  });
                                },
                                value: showReward,
                              ),
                              Text("Show reward"),
                              Tooltip(
                                child: Icon(
                                  Icons.info,
                                  color: Colors.grey,
                                  size: 18,
                                ),
                                message:
                                    "The remainder of the reward after a successful routine.",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }
}
