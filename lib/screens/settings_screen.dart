import 'package:material_ui/material_ui.dart';
import '../l10n/strings.dart';
import '../models/app_settings.dart';
import '../state/podflow_controller.dart';

class SettingsScreen extends StatefulWidget {
  final PodFlowController controller;

  const SettingsScreen({super.key, required this.controller});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _customPodcastController = TextEditingController();
  String _query = '';

  static const List<Color> presetColors = [
    Color(0xFF1B8A5A), // Waldgrün
    Color(0xFF006A6A), // Petrol
    Color(0xFF2B5B84), // Stahlblau
    Color(0xFF7A4E2D), // Warmes Braun
    Color(0xFF6B4FA1), // Violett
    Color(0xFF9E3B33), // Rostrot
  ];

  static const List<String> samplePodcasts = [
    'Tech & Tüftelei',
    'Erzgebirge & Geschichte',
    'Späte Runde Audio',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _customPodcastController.dispose();
    super.dispose();
  }

  bool _matches(List<String> terms) {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return true;
    return terms.any((t) => t.toLowerCase().contains(q));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final settings = widget.controller.settings;
        final strings = PodFlowStrings(settings.speechStyle);

        final showSpeech = _matches([
          'anrede',
          'sprache',
          'du',
          'sie',
          'sächsisch',
          'dialekt',
          strings.speechStyleLabel,
        ]);

        final showColor = _matches([
          'farbe',
          'akzent',
          'design',
          'theme',
          'material',
          strings.accentColorLabel,
        ]);

        final showLimits = _matches([
          'episoden',
          'limit',
          'folgen',
          'podcast',
          'speicher',
          ...samplePodcasts,
          ...settings.episodeLimitsByPodcast.keys,
        ]);

        return Scaffold(
          appBar: AppBar(
            title: Text(strings.settings),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _query = value),
                decoration: InputDecoration(
                  hintText: 'Einstellungen durchsuchen (z. B. Du, Farbe, Limit)...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _query.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _query = '');
                          },
                        ),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              if (showSpeech)
                Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          strings.speechStyleLabel,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 10),
                        SegmentedButton<SpeechStyle>(
                          segments: const [
                            ButtonSegment(
                              value: SpeechStyle.informalDu,
                              label: Text('Du'),
                            ),
                            ButtonSegment(
                              value: SpeechStyle.formalSie,
                              label: Text('Sie'),
                            ),
                            ButtonSegment(
                              value: SpeechStyle.saxonyPreview,
                              label: Text('Sächsisch'),
                            ),
                          ],
                          selected: {settings.speechStyle},
                          onSelectionChanged: (selection) {
                            widget.controller.setSpeechStyle(selection.first);
                          },
                        ),
                      ],
                    ),
                  ),
                ),

              if (showColor)
                Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          strings.accentColorLabel,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: presetColors.map((color) {
                            final isSelected =
                                settings.seedColor.toARGB32() == color.toARGB32();
                            return InkWell(
                              borderRadius: BorderRadius.circular(999),
                              onTap: () => widget.controller.setSeedColor(color),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                  border: isSelected
                                      ? Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          width: 3,
                                        )
                                      : null,
                                ),
                                child: isSelected
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 20,
                                      )
                                    : null,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),

              if (showLimits)
                Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Episoden-Limit pro Podcast',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Legt fest, wie viele Folgen pro Podcast maximal behalten werden (ohne Limit = unbegrenzt).',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 12),
                        ..._buildPodcastLimitRows(context, settings),
                        const Divider(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _customPodcastController,
                                decoration: const InputDecoration(
                                  labelText: 'Weiteren Podcast-Namen hinzufügen',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            FilledButton(
                              onPressed: () {
                                final name = _customPodcastController.text.trim();
                                if (name.isEmpty) return;
                                widget.controller.setEpisodeLimit(name, 3);
                                _customPodcastController.clear();
                              },
                              child: const Text('Limit (3)'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

              if (!showSpeech && !showColor && !showLimits)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Text('Keine passenden Einstellungen gefunden.'),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildPodcastLimitRows(
    BuildContext context,
    PodFlowSettings settings,
  ) {
    final keys = <String>{
      ...samplePodcasts,
      ...settings.episodeLimitsByPodcast.keys,
    }.toList();

    return keys.map((podcast) {
      final currentLimit = settings.episodeLimitFor(podcast);
      return ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(podcast),
        subtitle: Text(
          currentLimit == null
              ? 'Aktuell: Kein Limit'
              : 'Aktuell: max. $currentLimit Folgen',
        ),
        trailing: PopupMenuButton<int?>(
          tooltip: 'Limit festlegen',
          initialValue: currentLimit,
          onSelected: (value) => widget.controller.setEpisodeLimit(podcast, value),
          itemBuilder: (context) => const [
            PopupMenuItem<int?>(value: null, child: Text('Kein Limit')),
            PopupMenuItem<int?>(value: 1, child: Text('1 Folge')),
            PopupMenuItem<int?>(value: 3, child: Text('3 Folgen')),
            PopupMenuItem<int?>(value: 5, child: Text('5 Folgen')),
            PopupMenuItem<int?>(value: 10, child: Text('10 Folgen')),
          ],
          child: Chip(
            label: Text(currentLimit == null ? 'Offen' : '$currentLimit Folgen'),
          ),
        ),
      );
    }).toList();
  }
}