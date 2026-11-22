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

  const PodFlowSettings({
    this.speechStyle = SpeechStyle.informalDu,
    this.listenerProfile = ListenerProfile.standard,
    this.seedColor = const Color(0xFF1B8A5A),
    this.themeMode = ThemeMode.system,
  });

  PodFlowSettings copyWith({
    SpeechStyle? speechStyle,
    ListenerProfile? listenerProfile,
    Color? seedColor,
    ThemeMode? themeMode,
  }) {
    return PodFlowSettings(
      speechStyle: speechStyle ?? this.speechStyle,
      listenerProfile: listenerProfile ?? this.listenerProfile,
      seedColor: seedColor ?? this.seedColor,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}