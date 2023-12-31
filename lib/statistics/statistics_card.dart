import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:habo/statistics/statistics.dart';
import '../settings/settings_manager.dart';

class StatisticsCard extends StatefulWidget {
  const StatisticsCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final StatisticsData data;

  @override
  State<StatisticsCard> createState() => _StatisticsCardState();
}

class _StatisticsCardState extends State<StatisticsCard> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //calculate total prayers
  totalPrayers() {
    var checks = widget.data.checks.toInt();
    var fails = widget.data.fails.toInt();
    int total = (checks + fails);
    return total;
  }

  //always update  data to firebaseStore
  Future<void> addStatistics() async {
    await _firestore.collection("user").doc("data").set({
      'Total fajar': totalPrayers().toString(),
      'prayed': widget.data.checks.toString(),
      'time': Timestamp.now(),
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //update data  to firebase
    addStatistics();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15.0),
      color: Theme.of(context).colorScheme.primaryContainer,
      shadowColor: Theme.of(context).shadowColor,
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    widget.data.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text(
                      ' Total Fajar Prayers',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      //store into firebase cloud
                      totalPrayers().toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Pray Fajar',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      //store into firebase cloud
                      widget.data.checks.toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Total History',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check,
                      color:
                          Provider.of<SettingsManager>(context, listen: false)
                              .checkColor,
                    ),
                    Text(
                      widget.data.checks.toString(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.close,
                      color:
                          Provider.of<SettingsManager>(context, listen: false)
                              .failColor,
                    ),
                    Text(
                      widget.data.fails.toString(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            //MonthlyGraph(data: widget.data),
          ],
        ),
      ),
    );
  }
}
