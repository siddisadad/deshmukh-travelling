import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '/core/design_system/tokens.dart';
import '/core/design_system/components/app_button.dart';

class SplashOnboardingWidget extends ConsumerStatefulWidget {
  const SplashOnboardingWidget({super.key});

  static String routeName = 'SplashOnboarding';
  static String routePath = '/splashOnboarding';

  @override
  ConsumerState<SplashOnboardingWidget> createState() => _SplashOnboardingWidgetState();
}

class _SplashOnboardingWidgetState extends ConsumerState<SplashOnboardingWidget> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingData> _steps = [
    OnboardingData(
      title: 'Travel in Comfort',
      description: 'Experience premium journeys with our fleet of high-end, air-conditioned buses designed for maximum relaxation.',
      imageUrl: 'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80',
    ),
    OnboardingData(
      title: 'Easy Booking',
      description: 'Book your tickets in seconds with our intuitive interface. Secure payments and instant confirmation.',
      imageUrl: 'https://images.unsplash.com/photo-1570126128858-623dd0b3c1c7?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80',
    ),
    OnboardingData(
      title: 'Track Your Ride',
      description: 'Stay informed with real-time bus tracking. Know exactly where your bus is and when it will arrive.',
      imageUrl: 'https://images.unsplash.com/photo-1520038410233-7141be7e6f97?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            left: -50,
            top: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.xs),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: const Icon(
                        Icons.directions_bus_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      'Deshmukh Travelling',
                      style: AppTypography.headlineMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) => setState(() => _currentIndex = index),
                  itemCount: _steps.length,
                  itemBuilder: (context, index) {
                    final step = _steps[index];
                    return OnboardingPage(data: step);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_steps.length, (index) {
                        final isActive = _currentIndex == index;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          height: 8,
                          width: isActive ? 24 : 8,
                          decoration: BoxDecoration(
                            color: isActive ? AppColors.primary : AppColors.alternate,
                            borderRadius: BorderRadius.circular(AppRadius.full),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    AppButton(
                      text: _currentIndex == _steps.length - 1 ? 'Get Started' : 'Next',
                      isFullWidth: true,
                      onPressed: () {
                        if (_currentIndex < _steps.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        } else {
                          context.goNamed('LoginOTP');
                        }
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AppButton(
                      text: 'Skip',
                      variant: AppButtonVariant.ghost,
                      isFullWidth: true,
                      onPressed: () => context.goNamed('LoginOTP'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                child: Column(
                  children: [
                    Text(
                      'Powered by',
                      style: AppTypography.labelSmall.copyWith(color: AppColors.textSecondary),
                    ),
                    Text(
                      'Deshmukh Technologies LLP',
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final String imageUrl;

  OnboardingData({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;

  const OnboardingPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.xl),
            child: CachedNetworkImage(
              imageUrl: data.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: AppTypography.headlineMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
