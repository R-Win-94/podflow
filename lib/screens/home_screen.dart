// lib/screens/home_screen.dart
import 'package:material_ui/material_ui.dart';
import '../l10n/strings.dart';
import '../state/podflow_controller.dart';
import 'quick_settings_sheet.dart';

class HomeScreen extends StatelessWidget {
  final PodFlowController controller;

  const HomeScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final strings = PodFlowStrings(controller.settings.speechStyle);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.appTitle),
        actions: [
          IconButton(
            tooltip: strings.settings,
            icon: const Icon(Icons.tune),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                showDragHandle: true,
                builder: (_) => QuickSettingsSheet(controller: controller),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                strings.welcomeBanner,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                    ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _SectionCard(
            icon: Icons.fiber_new_outlined,
            title: strings.newEpisodes,
            subtitle: 'Automatische Liste neuer Folgen ab Einrichtungstag.',
          ),
          _SectionCard(
            icon: Icons.star_outline,
            title: strings.favorites,
            subtitle: 'Besondere Lieblinge mit Priorität und Hinweisen.',
          ),
          _SectionCard(
            icon: Icons.auto_awesome_outlined,
            title: strings.surpriseList,
            subtitle: 'Lokale Empfehlungen passend zu deinen Hörgewohnheiten.',
          ),
          _SectionCard(
            icon: Icons.podcasts_outlined,
            title: '${strings.chartsDe} · ${strings.chartsIntl} · ${strings.discover}',
            subtitle: 'Register-Suche, Charts und manuelle Feed-URLs.',
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _SectionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: colorScheme.secondaryContainer,
            foregroundColor: colorScheme.onSecondaryContainer,
            child: Icon(icon),
          ),
          title: Text(title),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }
}