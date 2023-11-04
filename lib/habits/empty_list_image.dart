import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habo/generated/l10n.dart';
import 'package:habo/navigation/app_state_manager.dart';
import 'package:provider/provider.dart';

class EmptyListImage extends StatelessWidget {
  const EmptyListImage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<AppStateManager>(context, listen: false)
            .goCreateHabit(true);
      },
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 300,
                height: 300,
                child: SvgPicture.asset('assets/images/emptyList.svg',
                    semanticsLabel: S.of(context).emptyList),
              ),
              Text(
                S.of(context).createYourFirstHabit,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
