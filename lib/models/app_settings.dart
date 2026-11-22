import 'package:material_ui/material_ui.dart';

enum SpeechStyle {
  informalDu,
  formalSie,
  saxonyPreview,
}

enum ListenerProfile {
  beginner,
  standard,
  pro,
}

class PodFlowSettings {
  final SpeechStyle speechStyle;
  final ListenerProfile listenerProfile;
  final Color seedColor;
  final ThemeMode themeMode;
  final Map<String, int> episodeLimitsByPodcast;

  const PodFlowSettings({
    this.speechStyle = SpeechStyle.informalDu,
    this.listenerProfile = ListenerProfile.standard,
    this.seedColor = const Color(0xFF1B8A5A),
    this.themeMode = ThemeMode.system,
    this.episodeLimitsByPodcast = const {},
  });

  int? episodeLimitFor(String podcastKey) => episodeLimitsByPodcast[podcastKey];

  PodFlowSettings copyWith({
    SpeechStyle? speechStyle,
    ListenerProfile? listenerProfile,
    Color? seedColor,
    ThemeMode? themeMode,
    Map<String, int>? episodeLimitsByPodcast,
  }) {
    return PodFlowSettings(
      speechStyle: speechStyle ?? this.speechStyle,
      listenerProfile: listenerProfile ?? this.listenerProfile,
      seedColor: seedColor ?? this.seedColor,
      themeMode: themeMode ?? this.themeMode,
      episodeLimitsByPodcast:
          episodeLimitsByPodcast ?? this.episodeLimitsByPodcast,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'speechStyle': speechStyle.name,
      'listenerProfile': listenerProfile.name,
      'seedColor': seedColor.toARGB32(),
      'themeMode': themeMode.name,
      'episodeLimitsByPodcast': episodeLimitsByPodcast,
    };
  }

  factory PodFlowSettings.fromJson(Map<String, dynamic> json) {
    final rawLimits = json['episodeLimitsByPodcast'];
    final parsedLimits = <String, int>{};
    if (rawLimits is Map) {
      for (final entry in rawLimits.entries) {
        final value = entry.value;
        if (value is int && value > 0) {
          parsedLimits[entry.key.toString()] = value;
        }
      }
    }

    return PodFlowSettings(
      speechStyle: SpeechStyle.values.firstWhere(
        (e) => e.name == json['speechStyle'],
        orElse: () => SpeechStyle.informalDu,
      ),
      listenerProfile: ListenerProfile.values.firstWhere(
        (e) => e.name == json['listenerProfile'],
        orElse: () => ListenerProfile.standard,
      ),
      seedColor: Color(
        json['seedColor'] is int ? json['seedColor'] as int : 0xFF1B8A5A,
      ),
      themeMode: ThemeMode.values.firstWhere(
        (e) => e.name == json['themeMode'],
        orElse: () => ThemeMode.system,
      ),
      episodeLimitsByPodcast: parsedLimits,
    );
  }
}