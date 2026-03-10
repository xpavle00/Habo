import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habo/constants.dart';
import 'package:habo/generated/l10n.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:provider/provider.dart';
import 'package:habo/widgets/primary_button.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext(int pageCount) {
    if (_currentPage < pageCount - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  Future<void> _completeOnboarding() async {
    final settingsManager = Provider.of<SettingsManager>(
      context,
      listen: false,
    );
    if (settingsManager.getSeenOnboarding) {
      Navigator.pop(context);
    } else {
      settingsManager.setSeenOnboarding = true;
    }
  }

  Widget _buildPageIndicator(int count, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: _currentPage == index ? 24 : 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? HaboColors.primary
                : (isDark ? Colors.grey[800] : Colors.grey[300]),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final List<Widget> pages = [
      // Page 1
      _OnboardingPage(
        title: S.of(context).defineYourHabits,
        imagePath: 'assets/images/onboard/1.svg',
        imageSemantics: 'Empty list',
        bodyWidget: Column(
          children: [
            Text(
              S.of(context).defineYourHabitsDescription,
              style: theme.textTheme.titleMedium?.copyWith(
                color: isDark ? Colors.grey[400] : Colors.grey[600],
                height: 1.6,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[900] : Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildListItem(S.of(context).cueNumbered, isDark),
                  const SizedBox(height: 12),
                  _buildListItem(S.of(context).routineNumbered, isDark),
                  const SizedBox(height: 12),
                  _buildListItem(S.of(context).rewardNumbered, isDark),
                ],
              ),
            ),
          ],
        ),
      ),
      // Page 2
      _OnboardingPage(
        title: S.of(context).logYourDays,
        imagePath: 'assets/images/onboard/2.svg',
        imageSemantics: S.of(context).emptyList,
        bodyWidget: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[900] : Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIconRow(
                Icons.check,
                HaboColors.primary,
                S.of(context).successful,
                isDark,
              ),
              const SizedBox(height: 16),
              _buildIconRow(
                Icons.add,
                HaboColors.progress,
                S.of(context).numericHabit,
                isDark,
              ),
              const SizedBox(height: 16),
              _buildIconRow(
                Icons.close,
                HaboColors.red,
                S.of(context).notSoSuccessful,
                isDark,
              ),
              const SizedBox(height: 16),
              _buildIconRow(
                Icons.last_page,
                HaboColors.skip,
                S.of(context).skipDoesNotAffectStreaks,
                isDark,
              ),
              const SizedBox(height: 16),
              _buildIconRow(
                Icons.chat_bubble_outline,
                HaboColors.orange,
                S.of(context).note,
                isDark,
              ),
            ],
          ),
        ),
      ),
      // Page 3
      _OnboardingPage(
        title: S.of(context).observeYourProgress,
        imagePath: 'assets/images/onboard/3.svg',
        imageSemantics: S.of(context).emptyList,
        bodyWidget: Text(
          S.of(context).trackYourProgress,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleMedium?.copyWith(
            color: isDark ? Colors.grey[400] : Colors.grey[600],
            height: 1.6,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: TextButton(
                  onPressed: _completeOnboarding,
                  child: Text(
                    S.of(context).skip,
                    style: TextStyle(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemCount: pages.length,
                itemBuilder: (context, index) => pages[index],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildPageIndicator(pages.length, isDark),
                  const SizedBox(height: 32),
                  PrimaryButton(
                    width: double.infinity,
                    onPressed: () => _onNext(pages.length),
                    child: Text(
                      _currentPage == pages.length - 1
                          ? S.of(context).done
                          : 'Next',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(String text, bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '•',
          style: TextStyle(
            fontSize: 20,
            color: HaboColors.primary,
            height: 1.2,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.grey[300] : Colors.grey[800],
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIconRow(
    IconData icon,
    Color iconColor,
    String text,
    bool isDark,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.grey[300] : Colors.grey[800],
            ),
          ),
        ),
      ],
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final String title;
  final String imagePath;
  final String imageSemantics;
  final Widget bodyWidget;

  const _OnboardingPage({
    required this.title,
    required this.imagePath,
    required this.imageSemantics,
    required this.bodyWidget,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Image with glowing shadow background
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: HaboColors.primary.withValues(alpha: 0.05),
                    blurRadius: 40,
                    spreadRadius: 20,
                  ),
                ],
              ),
              child: SvgPicture.asset(
                imagePath,
                semanticsLabel: imageSemantics,
                height: 200,
              ),
            ),
            const SizedBox(height: 48),
            // Title
            Text(
              title,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // Body Content
            bodyWidget,
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
