import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/generated/l10n.dart';
import 'package:habo/habits/habits_manager.dart';
import 'package:habo/model/habit_data.dart';
import 'package:habo/model/category.dart';
import 'package:habo/navigation/routes.dart';
import 'package:habo/notifications.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:habo/widgets/text_container.dart';
import 'package:habo/screens/category_selection_screen.dart';
import 'package:intl/intl.dart';
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
  TextEditingController targetValue = TextEditingController();
  TextEditingController partialValue = TextEditingController();
  TextEditingController unit = TextEditingController();
  TimeOfDay notTime = const TimeOfDay(hour: 12, minute: 0);
  bool twoDayRule = false;
  bool showReward = false;
  bool advanced = false;
  bool notification = false;
  bool showSanction = false;
  HabitType habitType = HabitType.boolean;
  List<Category> selectedCategories = [];

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
      final numberFormatter = NumberFormat('#.##'); // Will remove trailing .0

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
      habitType = widget.habitData!.habitType;
      targetValue.text = numberFormatter.format(widget.habitData!.targetValue);
      partialValue.text = numberFormatter.format(widget.habitData!.partialValue);
      unit.text = widget.habitData!.unit;
      selectedCategories = List.from(widget.habitData!.categories);
    }
    
    // Load categories when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HabitsManager>(context, listen: false).loadCategories();
    });
  }

  @override
  void dispose() {
    title.dispose();
    cue.dispose();
    routine.dispose();
    reward.dispose();
    sanction.dispose();
    accountant.dispose();
    targetValue.dispose();
    partialValue.dispose();
    unit.dispose();
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
                widget.habitData!.archived ? Icons.unarchive : Icons.archive,
                semanticLabel: widget.habitData!.archived ? S.of(context).unarchive : S.of(context).archive,
              ),
              color: Colors.orange,
              tooltip: widget.habitData!.archived ? S.of(context).unarchiveHabit : S.of(context).archiveHabit,
              onPressed: () {
                Navigator.of(context).pop();
                if (widget.habitData != null) {
                  final habitsManager = Provider.of<HabitsManager>(context, listen: false);
                  if (widget.habitData!.archived) {
                    habitsManager.unarchiveHabit(widget.habitData!.id!);
                  } else {
                    habitsManager.archiveHabit(widget.habitData!.id!);
                  }
                }
              },
            ),
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
                final habitData = HabitData(
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
                  habitType: habitType,
                  targetValue: double.tryParse(targetValue.text) ?? 100.0,
                  partialValue: double.tryParse(partialValue.text) ?? 10.0,
                  unit: unit.text.toString(),
                  categories: selectedCategories,
                );
                final habitsManager = Provider.of<HabitsManager>(context, listen: false);
                habitsManager.editHabit(habitData);
                // Update habit-category associations
                if (widget.habitData!.id != null) {
                  habitsManager.updateHabitCategories(widget.habitData!.id!, selectedCategories);
                }
              } else {
                final habitsManager = Provider.of<HabitsManager>(context, listen: false);
                habitsManager.addHabit(
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
                  habitType: habitType,
                  targetValue: double.tryParse(targetValue.text) ?? 100.0,
                  partialValue: double.tryParse(partialValue.text) ?? 10.0,
                  unit: unit.text.toString(),
                  categories: selectedCategories,
                );
                // For new habits, we need to get the habit ID and then update categories
                // This will be handled by updating the addHabit method to accept categories
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
                  


                  ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 25),
                          title: Text(
                            S.of(context).habitType,
                          ),
                          trailing: DropdownButton<HabitType>(
                            value: habitType,
                            onChanged: (value) {
                              setState(() {
                                habitType = value!;
                              });
                            },
                            icon: const Icon(Icons.expand_more),
                            iconSize: 24,
                            elevation: 16,
                            items: [
                              DropdownMenuItem(
                                value: HabitType.boolean,
                                child: Text(S.of(context).booleanHabit),
                              ),
                              DropdownMenuItem(
                                value: HabitType.numeric,
                                child: Text(S.of(context).numericHabit),
                              ),
                            ],
                          ),
                        ),
                  if (habitType == HabitType.numeric) ...[
                    Container(
                      // margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: [
                                    TextSpan(
                                        text: S.of(context).numericHabitDescription),
                                    WidgetSpan(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: GestureDetector(
                                          onTap: () {
                                            showSmallTooltip(context, S.of(context).numericHabit, 
                                            S.of(context).numericHabitDescription);
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
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  controller: targetValue,
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                  decoration: InputDecoration(
                                    labelText: S.of(context).targetValue,
                                    hintText: '100',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  controller: unit,
                                  decoration: InputDecoration(
                                    labelText: S.of(context).unit,
                                    hintText: 'push-ups',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: partialValue,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              labelText: S.of(context).partialValue,
                              hintText: '10',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              helperText: S.of(context).partialValueDescription,
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ],
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10),
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

                  // Categories Section (conditionally shown)
                  Consumer<SettingsManager>(
                    builder: (context, settingsManager, child) {
                      if (!settingsManager.getShowCategories) {
                        return const SizedBox.shrink();
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Categories ListTile with plus sign
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                            title: Text(S.of(context).categories),
                            trailing: IconButton(
                              onPressed: () async {
                                final result = await Navigator.of(context).push<List<Category>>(
                                  MaterialPageRoute(
                                    builder: (context) => CategorySelectionScreen(
                                      initialSelectedCategories: selectedCategories,
                                      onCategoriesChanged: (categories) {
                                        // This callback is called when saving
                                      },
                                    ),
                                  ),
                                );
                                if (result != null) {
                                  setState(() {
                                    selectedCategories = result;
                                  });
                                }
                              },
                              icon: const Icon(Icons.add),
                              iconSize: 24,
                            ),
                          ),
                          
                          // Categories chips (styled like category_filter_row.dart)
                          if (selectedCategories.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
                              child: Wrap(
                                spacing: 8.0,
                                runSpacing: 4.0,
                                children: selectedCategories.map((category) {
                                  return FilterChip(
                                    label: Text(
                                      category.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    avatar: Icon(
                                      category.icon,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                    selected: true,
                                    onSelected: (selected) {
                                      // Remove category when tapped
                                      setState(() {
                                        selectedCategories.remove(category);
                                      });
                                    },
                                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                    selectedColor: Theme.of(context).colorScheme.primaryContainer,
                                    side: BorderSide(
                                      color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                                      width: 1,
                                    ),
                                    showCheckmark: false,
                                  );
                                }).toList(),
                              ),
                            ),
                        ],
                      );
                    },
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
