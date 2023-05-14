import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/habits/habits_manager.dart';
import 'package:habo/model/habit_data.dart';
import 'package:habo/navigation/routes.dart';
import 'package:habo/notifications.dart';
import 'package:habo/widgets/text_container.dart';
import 'package:provider/provider.dart';

class EditHabitScreen extends StatefulWidget {
  static MaterialPage page(HabitData? data) {
    return MaterialPage(
      name: (data != null) ? Routes.editHabitPath : Routes.createHabitPath,
      key: (data != null)
          ? ValueKey(Routes.editHabitPath)
          : ValueKey(Routes.createHabitPath),
      child: EditHabitScreen(habitData: data),
    );
  }

  const EditHabitScreen({Key? key, required this.habitData}) : super(key: key);

  final HabitData? habitData;

  @override
  State<EditHabitScreen> createState() => _EditHabitScreenState();
}

class _EditHabitScreenState extends State<EditHabitScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController cue = TextEditingController();
  TextEditingController routine = TextEditingController();
  TextEditingController reward = TextEditingController();
  TextEditingController sanction = TextEditingController();
  TextEditingController accountant = TextEditingController();
  TimeOfDay notTime = const TimeOfDay(hour: 12, minute: 0);
  bool twoDayRule = false;
  bool showReward = false;
  bool advanced = false;
  bool notification = false;
  bool showSanction = false;

  Future<void> setNotificationTime(context) async {
    TimeOfDay? selectedTime;
    TimeOfDay initialTime = notTime;
    selectedTime =
        await showTimePicker(context: context, initialTime: initialTime);
    if (selectedTime != null) {
      setState(() {
        notTime = selectedTime!;
      });
    }
  }

  void showSmallTooltip(BuildContext context, String title, String desc) {
    AwesomeDialog(
      context: context,
      dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      dialogType: DialogType.info,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: title,
      desc: desc,
    ).show();
  }

  void showAdvancedTooltip(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      dialogType: DialogType.info,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 28),
        child: Column(
          children: [
            const Text(
              "Habit loop",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: const <TextSpan>[
                  TextSpan(
                    text:
                        'Habit Loop is a psychological model describing the process of habit formation. It consists of three components: Cue, Routine, and Reward. The Cue triggers the Routine (habitual action), which is then reinforced by the Reward, creating a loop that makes the habit more ingrained and likely to be repeated.\n\n',
                  ),
                  TextSpan(
                    text: 'Cue',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        ' is the trigger that initiates your habit. It could be a specific time, location, feeling, or an event.\n\n',
                  ),
                  TextSpan(
                    text: 'Routine',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        ' is the action you take in response to the cue. This is the habit itself.\n\n',
                  ),
                  TextSpan(
                    text: 'Reward',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        ' is the benefit or positive feeling you experience after performing the routine. It reinforces the habit.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).show();
  }

  @override
  void initState() {
    super.initState();
    if (widget.habitData != null) {
      title.text = widget.habitData!.title;
      cue.text = widget.habitData!.cue;
      routine.text = widget.habitData!.routine;
      reward.text = widget.habitData!.reward;
      twoDayRule = widget.habitData!.twoDayRule;
      showReward = widget.habitData!.showReward;
      advanced = widget.habitData!.advanced;
      notification = widget.habitData!.notification;
      notTime = widget.habitData!.notTime;
      sanction.text = widget.habitData!.sanction;
      showSanction = widget.habitData!.showSanction;
      accountant.text = widget.habitData!.accountant;
    }
  }

  @override
  void dispose() {
    title.dispose();
    cue.dispose();
    routine.dispose();
    reward.dispose();
    sanction.dispose();
    accountant.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (widget.habitData != null) ? 'Edit Habit' : 'Create Habit',
        ),
        backgroundColor: Colors.transparent,
        iconTheme: Theme.of(context).iconTheme,
        actions: <Widget>[
          if (widget.habitData != null)
            IconButton(
              icon: const Icon(
                Icons.delete,
                semanticLabel: 'Delete',
              ),
              color: HaboColors.red,
              tooltip: 'Delete',
              onPressed: () {
                Navigator.of(context).pop();
                if (widget.habitData != null) {
                  Provider.of<HabitsManager>(context, listen: false)
                      .deleteHabit(widget.habitData!.id!);
                }
              },
            ),
        ],
      ),
      floatingActionButton: Builder(builder: (BuildContext context) {
        return FloatingActionButton(
          onPressed: () {
            if (title.text.isNotEmpty) {
              if (widget.habitData != null) {
                Provider.of<HabitsManager>(context, listen: false).editHabit(
                  HabitData(
                    id: widget.habitData!.id,
                    title: title.text.toString(),
                    twoDayRule: twoDayRule,
                    cue: cue.text.toString(),
                    routine: routine.text.toString(),
                    reward: reward.text.toString(),
                    showReward: showReward,
                    advanced: advanced,
                    notification: notification,
                    notTime: notTime,
                    position: widget.habitData!.position,
                    events: widget.habitData!.events,
                    sanction: sanction.text.toString(),
                    showSanction: showSanction,
                    accountant: accountant.text.toString(),
                  ),
                );
              } else {
                Provider.of<HabitsManager>(context, listen: false).addHabit(
                  title.text.toString(),
                  twoDayRule,
                  cue.text.toString(),
                  routine.text.toString(),
                  reward.text.toString(),
                  showReward,
                  advanced,
                  notification,
                  notTime,
                  sanction.text.toString(),
                  showSanction,
                  accountant.text.toString(),
                );
              }
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  behavior: SnackBarBehavior.floating,
                  content: const Text("The habit title can not be empty."),
                ),
              );
            }
          },
          child: const Icon(
            Icons.check,
            semanticLabel: 'Save',
            color: Colors.white,
            size: 35.0,
          ),
        );
      }),
      body: Builder(
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  TextContainer(
                    title: title,
                    hint: 'Exercise',
                    label: 'Habit',
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                          onChanged: (bool? value) {
                            setState(() {
                              twoDayRule = value!;
                            });
                          },
                          value: twoDayRule,
                        ),
                        const Text("Use Two day rule"),
                        IconButton(
                          onPressed: () {
                            showSmallTooltip(context, "Two day rule",
                                "With two day rule, you can miss one day and do not lose a streak if the next day is successful.");
                          },
                          icon: const Icon(
                            Icons.info,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ExpansionTile(
                    shape: const Border(),
                    title: const Padding(
                      padding: EdgeInsets.all(7.0),
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
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: [
                                const TextSpan(
                                    text:
                                        "This section helps you better define your habits utilizing the Habit loop. You should define cues, routines, and rewards for every habit."),
                                WidgetSpan(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: GestureDetector(
                                      onTap: () {
                                        showAdvancedTooltip(context);
                                      },
                                      child: const Icon(
                                        Icons.info,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextContainer(
                        title: cue,
                        hint: 'At 7:00AM',
                        label: 'Cue',
                      ),
                      if (platformSupportsNotifications())
                        ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 25),
                          title: const Text("Notifications"),
                          trailing: Switch(
                            value: notification,
                            onChanged: (value) {
                              notification = value;
                              setState(() {});
                            },
                          ),
                        ),
                      if (platformSupportsNotifications())
                        ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 25),
                          enabled: notification,
                          title: const Text("Notification time"),
                          trailing: InkWell(
                            onTap: () {
                              if (notification) {
                                setNotificationTime(context);
                              }
                            },
                            child: Text(
                              "${notTime.hour.toString().padLeft(2, '0')}:${notTime.minute.toString().padLeft(2, '0')}",
                              style: TextStyle(
                                  color: (notification)
                                      ? null
                                      : Theme.of(context).disabledColor),
                            ),
                          ),
                        ),
                      TextContainer(
                        title: routine,
                        hint: 'Do 50 push ups',
                        label: 'Routine',
                      ),
                      TextContainer(
                        title: reward,
                        hint: '15 min. of video games',
                        label: 'Reward',
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        child: Row(
                          children: <Widget>[
                            Checkbox(
                              onChanged: (bool? value) {
                                setState(() {
                                  showReward = value!;
                                });
                              },
                              value: showReward,
                            ),
                            const Text("Show reward"),
                            IconButton(
                              onPressed: () {
                                showSmallTooltip(context, "Show reward",
                                    "The remainder of the reward after a successful routine.");
                              },
                              icon: const Icon(
                                Icons.info,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const ListTile(
                        title: Text(
                          "Habit contract",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Center(
                          child: Text(
                            "While positive reinforcement is recommended, some people may opt for a habit contract. A habit contract allows you to specify a sanction that will be imposed if you miss your habit, and may involve an accountability partner who helps supervise your goals.",
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextContainer(
                        title: sanction,
                        hint: 'Donate 10\$ to charity',
                        label: 'Sanction',
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        child: Row(
                          children: <Widget>[
                            Checkbox(
                              onChanged: (bool? value) {
                                setState(
                                  () {
                                    showSanction = value!;
                                  },
                                );
                              },
                              value: showSanction,
                            ),
                            const Text("Show sanction"),
                            IconButton(
                              onPressed: () {
                                showSmallTooltip(context, "Show sanction",
                                    "The remainder of the sanction after a unsuccessful routine.");
                              },
                              icon: const Icon(
                                Icons.info,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextContainer(
                        title: accountant,
                        hint: 'Dan',
                        label: 'Accountability partner',
                      ),
                      const SizedBox(
                        height: 110,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
