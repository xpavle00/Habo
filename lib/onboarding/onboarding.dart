import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habo/constants.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

class Onboarding extends StatelessWidget {
  Onboarding({super.key});

  final List<PageViewModel> listPagesViewModel = [
    PageViewModel(
      titleWidget: const Text(
        'Define your habits',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      image: SvgPicture.asset(
        'assets/images/onboard/1.svg',
        semanticsLabel: 'Empty list',
        width: 250,
      ),
      bodyWidget: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'To better stick to your habits, you can define:',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1. Cue',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '2. Routine',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '3. Reward',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    PageViewModel(
      titleWidget: const Text(
        'Log your days',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      image: SvgPicture.asset(
        'assets/images/onboard/2.svg',
        semanticsLabel: 'Empty list',
        width: 250,
      ),
      bodyWidget: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check,
                    color: HaboColors.primary,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Successful',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.close,
                    color: HaboColors.red,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Not so successful',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.last_page,
                    color: HaboColors.skip,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Skip (does not affect streaks)',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    color: HaboColors.orange,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Comment',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    PageViewModel(
      title: "Observe your progress",
      image: SvgPicture.asset(
        'assets/images/onboard/3.svg',
        semanticsLabel: 'Empty list',
        width: 250,
      ),
      bodyWidget: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'You can track your progress through the calendar view in every habit or on the statistics page.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: listPagesViewModel,
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
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
      skip: const Text("Skip"),
    );
  }
}
