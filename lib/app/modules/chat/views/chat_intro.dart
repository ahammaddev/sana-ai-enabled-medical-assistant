import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sana/app/modules/chat/controllers/chat_controller.dart';
import 'package:sana/app/modules/chat/views/topic_card.dart';
import 'package:sana/app/utils/constants/colors/app_colors.dart';

class _Topic {
  const _Topic(this.icon, this.label, this.prompt);

  final IconData icon;
  final String label;
  final String prompt;
}

const List<_Topic> _topics = [
  _Topic(
    Icons.healing_outlined,
    'Check Headache & Fever Symptoms',
    'I have a headache and a mild fever. What should I do?',
  ),
  _Topic(
    Icons.medication_outlined,
    'Paracetamol Dosage Guidelines',
    'What is the safe adult dosage for Paracetamol and its side effects?',
  ),
  _Topic(
    Icons.local_hospital_outlined,
    'First Aid for Thermal Burns',
    'What are the immediate first aid steps for a minor burn?',
  ),
  _Topic(
    Icons.favorite_border_rounded,
    'Tips to Lower Blood Pressure',
    'What dietary and lifestyle habits help manage high blood pressure?',
  ),
];

/// Branding header shown at the top of a consultation, with suggested
/// topics when the consultation is still empty.
class ChatIntro extends GetView<ChatController> {
  const ChatIntro({super.key, required this.showTopics});

  final bool showTopics;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(top: 30.0, bottom: showTopics ? 20.0 : 16.0),
      child: Column(
        children: [
          const FaIcon(
            FontAwesomeIcons.robot,
            size: 90,
            color: AppColors.primary,
          ),
          const SizedBox(height: 5),
          Text('SANA', style: theme.textTheme.headlineLarge),
          Text(
            'AI-powered medical assistant',
            style: theme.textTheme.titleMedium,
          ),
          Text(
            'Developed by Faisal Ahammad',
            style: theme.textTheme.titleSmall,
          ),
          const SizedBox(height: 16),

          // Consultation Topics (Shown when empty)
          if (showTopics) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'CONSULTATION TOPICS',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const SizedBox(height: 10),
            for (final topic in _topics) ...[
              TopicCard(
                icon: topic.icon,
                label: topic.label,
                onTap: () => controller.sendPrompt(topic.prompt),
              ),
              const SizedBox(height: 8),
            ],
            const SizedBox(height: 6),
            Text(
              'For informational purposes only. Consult a doctor for emergencies.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 10.5,
                color: AppColors.secondary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
