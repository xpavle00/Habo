import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/generated/l10n.dart';
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

  const EditHabitScreen({super.key, required this.habitData});

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

  Future<void> setNotificationTime(BuildContext context) async {
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
      dialogBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
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
      dialogBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
      dialogType: DialogType.info,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 28),
        child: Column(
          children: [
            Text(
              S.of(context).habitLoop,
              style: const TextStyle(
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
                children: <TextSpan>[
                  TextSpan(
                    text: S.of(context).habitLoopDescription,
                  ),
                  const TextSpan(
                    text: '\n\n',
                  ),
                  TextSpan(
                    text: S.of(context).cue,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: S.of(context).cueDescription,
                  ),
                  const TextSpan(
                    text: '\n\n',
                  ),
                  TextSpan(
                    text: S.of(context).routine,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: S.of(context).routineDescription,
                  ),
                  const TextSpan(
                    text: '\n\n',
                  ),
                  TextSpan(
                    text: S.of(context).reward,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: S.of(context).rewardDescription,
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
          (widget.habitData != null)
              ? S.of(context).editHabit
              : S.of(context).createHabit,
        ),
        backgroundColor: Colors.transparent,
        iconTheme: Theme.of(context).iconTheme,
        actions: <Widget>[
          if (widget.habitData != null)
            IconButton(
              icon: Icon(
                Icons.delete,
                semanticLabel: S.of(context).delete,
              ),
              color: HaboColors.red,
              tooltip: S.of(context).delete,
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
                  content: Text(S.of(context).habitTitleEmptyError),
                ),
              );
            }
          },
          child: Icon(
            Icons.check,
            semanticLabel: S.of(context).save,
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
                    hint: S.of(context).exercise,
                    label: S.of(context).habit,
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
                        Text(S.of(context).useTwoDayRule),
                        IconButton(
                          onPressed: () {
                            showSmallTooltip(context, S.of(context).twoDayRule,
                                S.of(context).twoDayRuleDescription);
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
                    title: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text(
                        S.of(context).advancedHabitBuilding,
                        style: const TextStyle(
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
                                TextSpan(
                                    text: S
                                        .of(context)
                                        .advancedHabitBuildingDescription),
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
                        hint: S.of(context).at7AM,
                        label: S.of(context).cue,
                      ),
                      if (platformSupportsNotifications())
                        ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 25),
                          title: Text(
                            S.of(context).notifications,
                          ),
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
                          title: Text(
                            S.of(context).notificationTime,
                          ),
                          trailing: InkWell(
                            onTap: () {
                              if (notification) {
                                setNotificationTime(context);
                              }
                            },
                            child: Text(
                              '${notTime.hour.toString().padLeft(2, '0')}:${notTime.minute.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                  color: (notification)
                                      ? null
                                      : Theme.of(context).disabledColor),
                            ),
                          ),
                        ),
                      TextContainer(
                        title: routine,
                        hint: S.of(context).do50PushUps,
                        label: S.of(context).routine,
                      ),
                      TextContainer(
                        title: reward,
                        hint: S.of(context).fifteenMinOfVideoGames,
                        label: S.of(context).reward,
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
                            Text(
                              S.of(context).showReward,
                            ),
                            IconButton(
                              onPressed: () {
                                showSmallTooltip(
                                  context,
                                  S.of(context).showReward,
                                  S.of(context).remainderOfReward,
                                );
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
                      ListTile(
                        title: Text(
                          S.of(context).habitContract,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                          child: Text(
                            S.of(context).habitContractDescription,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextContainer(
                        title: sanction,
                        hint: S.of(context).donateToCharity,
                        label: S.of(context).sanction,
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
                            Text(
                              S.of(context).showSanction,
                            ),
                            IconButton(
                              onPressed: () {
                                showSmallTooltip(
                                  context,
                                  S.of(context).showSanction,
                                  S.of(context).remainderOfSanction,
                                );
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
                        hint: S.of(context).dan,
                        label: S.of(context).accountabilityPartner,
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
