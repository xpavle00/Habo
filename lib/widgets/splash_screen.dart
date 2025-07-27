import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/themes.dart';

/// Splash screen widget shown during app initialization.
/// 
/// Displays the app logo with a theme-aware background and subtle animation.
class SplashScreen extends StatefulWidget {
  /// The current theme mode to determine colors
  final Themes themeMode;

  const SplashScreen({
    super.key,
    this.themeMode = Themes.device,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Get theme data based on current theme mode
  ThemeData _getThemeData() {
    switch (widget.themeMode) {
      case Themes.light:
        return HaboTheme.lightTheme;
      case Themes.dark:
        return HaboTheme.darkTheme;
      case Themes.oled:
        return HaboTheme.oledTheme;
      case Themes.device:
      default:
        // Use system theme
        final brightness = MediaQuery.of(context).platformBrightness;
        return brightness == Brightness.dark 
            ? HaboTheme.darkTheme 
            : HaboTheme.lightTheme;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = _getThemeData();
    
    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        backgroundColor: themeData.scaffoldBackgroundColor,
        body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Logo with animation
                  Transform.scale(
                    scale: _scaleAnimation.value,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: HaboColors.primary.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.asset(
                            'assets/images/app_icon.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // App Name
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      'Habo',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: themeData.colorScheme.onSurface,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Subtitle
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      'Building Better Habits',
                      style: TextStyle(
                        fontSize: 16,
                        color: themeData.colorScheme.onSurface.withOpacity(0.7),
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // Loading indicator
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SizedBox(
                      width: 32,
                      height: 32,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          HaboColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
