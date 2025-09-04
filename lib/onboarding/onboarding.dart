import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habo/constants.dart';
import 'package:habo/generated/l10n.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PageViewModel> listPagesViewModel = [
      PageViewModel(
        titleWidget: Text(
          S.of(context).defineYourHabits,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        image: SvgPicture.asset(
          'assets/images/onboard/1.svg',
          semanticsLabel: 'Empty list',
          width: 250,
        ),
        bodyWidget: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  S.of(context).defineYourHabitsDescription,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).cueNumbered,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      S.of(context).routineNumbered,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      S.of(context).rewardNumbered,
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      PageViewModel(
        titleWidget: Text(
          S.of(context).logYourDays,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        image: SvgPicture.asset(
          'assets/images/onboard/2.svg',
          semanticsLabel: S.of(context).emptyList,
          width: 250,
        ),
        bodyWidget: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check,
                      color: HaboColors.primary,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      S.of(context).successful,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.add,
                      color: HaboColors.progress,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      S.of(context).numericHabit,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.close,
                      color: HaboColors.red,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      S.of(context).notSoSuccessful,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.last_page,
                      color: HaboColors.skip,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      S.of(context).skipDoesNotAffectStreaks,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.chat_bubble_outline,
                      color: HaboColors.orange,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      S.of(context).note,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      PageViewModel(
        title: S.of(context).observeYourProgress,
        image: SvgPicture.asset(
          'assets/images/onboard/3.svg',
          semanticsLabel: S.of(context).emptyList,
          width: 250,
        ),
        bodyWidget: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              S.of(context).trackYourProgress,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      )
    ];

    return IntroductionScreen(
      pages: listPagesViewModel,
      done: Text(S.of(context).done,
          style: const TextStyle(fontWeight: FontWeight.w600)),
      onDone: () {
        if (Provider.of<SettingsManager>(context, listen: false)
            .getSeenOnboarding) {
          Navigator.pop(context);
        } else {
          Provider.of<SettingsManager>(context, listen: false)
              .setSeenOnboarding = true;
        }
      },
      next: const Icon(Icons.arrow_forward),
      showSkipButton: true,
      dotsDecorator: const DotsDecorator(activeColor: HaboColors.primary),
      skip: Text(S.of(context).skip),
      safeAreaList: const [false, false, false, true], // Only bottom SafeArea
    );
  }
}
