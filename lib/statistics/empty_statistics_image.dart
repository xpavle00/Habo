import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habo/generated/l10n.dart';

class EmptyStatisticsImage extends StatelessWidget {
  const EmptyStatisticsImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 300,
              height: 300,
              child: SvgPicture.asset('assets/images/noDataStatistics.svg',
                  semanticsLabel: S.of(context).emptyList),
            ),
            Text(
              S.of(context).noDataAboutHabits,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
