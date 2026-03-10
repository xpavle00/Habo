import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habo/constants.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:provider/provider.dart';
import 'package:habo/widgets/primary_button.dart';

class SyncOnboardingView extends StatefulWidget {
  final VoidCallback onComplete;

  const SyncOnboardingView({super.key, required this.onComplete});

  @override
  State<SyncOnboardingView> createState() => _SyncOnboardingViewState();
}

class _SyncOnboardingViewState extends State<SyncOnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingPageData> _pages = [
    _OnboardingPageData(
      title: 'Seamless Continuity',
      description:
          'Your habits, flawlessly synchronized across everywhere. Start tracking on your phone, tick off on your tablet seamlessly.',
      imagePath: 'assets/images/sync_onboard/sync.svg',
    ),
    _OnboardingPageData(
      title: 'Zero-Knowledge Privacy',
      description:
          'State-of-the-art End-to-End Encryption. Only you hold the master key — we can never read or access your personal data.',
      imagePath: 'assets/images/sync_onboard/encrypt.svg',
    ),
    _OnboardingPageData(
      title: 'Rest Easy',
      description:
          'We securely snapshot your entire progress history to the cloud. Total peace of mind, automatically.',
      imagePath: 'assets/images/sync_onboard/backup.svg',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentPage < _pages.length - 1) {
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
    await settingsManager.setHasSeenSyncOnboarding(true);
    widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  onPressed: _completeOnboarding,
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            // Pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final page = _pages[index];
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
                                  color: HaboColors.primary.withValues(
                                    alpha: 0.05,
                                  ),
                                  blurRadius: 40,
                                  spreadRadius: 20,
                                ),
                              ],
                            ),
                            child: SvgPicture.asset(
                              page.imagePath,
                              height: 200,
                            ),
                          ),
                          const SizedBox(height: 56),
                          // Title
                          Text(
                            page.title,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          // Description
                          Text(
                            page.description,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: isDark
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                              height: 1.6,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Bottom Controls
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Page Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
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
                  ),
                  const SizedBox(height: 32),
                  // CTA Button
                  PrimaryButton(
                    width: double.infinity,
                    onPressed: _onNext,
                    child: Text(
                      _currentPage == _pages.length - 1
                          ? 'Get Started'
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
}

class _OnboardingPageData {
  final String title;
  final String description;
  final String imagePath;

  _OnboardingPageData({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}
