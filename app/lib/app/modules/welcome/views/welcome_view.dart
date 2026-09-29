import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sana/app/modules/welcome/controllers/welcome_controller.dart';
import 'package:sana/app/modules/welcome/views/feature_tile.dart';
import 'package:sana/app/utils/constants/colors/app_colors.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.neutral,
        image: DecorationImage(
          image: AssetImage('assets/images/lines.png'),
          fit: BoxFit.cover,
          opacity: 0.08,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          // Scrollable on short screens while keeping the Spacer layout on
          // regular ones.
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 20.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(flex: 1),

                        // Robot Brand Icon
                        const FaIcon(
                          FontAwesomeIcons.robot,
                          size: 90,
                          color: AppColors.primary,
                        ),
                        const SizedBox(height: 12),

                        // App Title & Tagline
                        Text(
                          'SANA',
                          style: theme.textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'AI-powered medical assistant',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: AppColors.primarydark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Developed by Faisal Ahammad',
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: AppColors.secondary,
                          ),
                        ),

                        const Spacer(flex: 1),
                        const SizedBox(height: 24),

                        // Feature Highlights
                        const FeatureTile(
                          icon: Icons.health_and_safety_outlined,
                          title: 'Clinical Symptom Guidance',
                          description:
                              'Analyze symptoms and get preliminary triage suggestions.',
                        ),
                        const SizedBox(height: 10),
                        const FeatureTile(
                          icon: Icons.medication_outlined,
                          title: 'Medication Awareness',
                          description:
                              'Understand drug indications, dosage safety, and precautions.',
                        ),
                        const SizedBox(height: 10),
                        const FeatureTile(
                          icon: Icons.lock_outline_rounded,
                          title: 'Private & Local History',
                          description:
                              'Your consultations are securely stored right on your device.',
                        ),

                        const Spacer(flex: 2),
                        const SizedBox(height: 24),

                        // Action Buttons
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              elevation: 0,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            onPressed: controller.navigateToChatList,
                            child: Text(
                              'YOUR CONSULTATIONS',
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: BorderSide(
                                color: AppColors.secondary.withAlpha(80),
                                width: 1,
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            onPressed: controller.startDirectChat,
                            child: Text(
                              'START QUICK CONSULTATION',
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: AppColors.primarydark,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Copyright
                        Text(
                          '© 2026 MD. FAISAL AHAMMAD',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.primarydark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
