import 'package:material_ui/material_ui.dart';
import '../l10n/strings.dart';
import '../models/app_settings.dart';
import '../state/podflow_controller.dart';

class QuickSettingsSheet extends StatelessWidget {
  final PodFlowController controller;

  const QuickSettingsSheet({super.key, required this.controller});

  static const List<Color> presetColors = [
    Color(0xFF1B8A5A), // Waldgrün
    Color(0xFF006A6A), // Petrol
    Color(0xFF2B5B84), // Stahlblau
    Color(0xFF7A4E2D), // Warmes Braun
    Color(0xFF6B4FA1), // Violett
    Color(0xFF9E3B33), // Rostrot
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final settings = controller.settings;
        final strings = PodFlowStrings(settings.speechStyle);

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strings.settings,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Text(
                  strings.speechStyleLabel,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                SegmentedButton<SpeechStyle>(
                  segments: const [
                    ButtonSegment(value: SpeechStyle.informalDu, label: Text('Du')),
                    ButtonSegment(value: SpeechStyle.formalSie, label: Text('Sie')),
                    ButtonSegment(value: SpeechStyle.saxonyPreview, label: Text('Sächsisch')),
                  ],
                  selected: {settings.speechStyle},
                  onSelectionChanged: (selection) {
                    controller.setSpeechStyle(selection.first);
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  strings.accentColorLabel,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: presetColors.map((color) {
                    final isSelected = settings.seedColor.toARGB32() == color.toARGB32();
                    return InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: () => controller.setSeedColor(color),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: isSelected
                              ? Border.all(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  width: 3,
                                )
                              : null,
                        ),
                        child: isSelected
                            ? const Icon(Icons.check, color: Colors.white, size: 20)
                            : null,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Text(
                  strings.profileHint,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}