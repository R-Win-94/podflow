import '../models/app_settings.dart';

class PodFlowStrings {
  final SpeechStyle style;

  const PodFlowStrings(this.style);

  String get appTitle => 'PodFlow';

  String get welcomeBanner => switch (style) {
        SpeechStyle.informalDu => 'Willkommen zurück – deine Feeds sind bereit.',
        SpeechStyle.formalSie => 'Willkommen zurück – Ihre Feeds stehen bereit.',
        SpeechStyle.saxonyPreview => 'Nu gugge da – deine Feeds sind startklar.',
      };

  String get newEpisodes => 'Neue Folgen';
  String get favorites => 'Lieblinge';
  String get surpriseList => 'Überraschungsliste';
  String get chartsDe => 'Beliebt in DE';
  String get chartsIntl => 'International';
  String get discover => 'Entdecken';
  String get settings => 'Einstellungen';

  String get speechStyleLabel => switch (style) {
        SpeechStyle.informalDu => 'Anrede (Du)',
        SpeechStyle.formalSie => 'Anrede (Sie)',
        SpeechStyle.saxonyPreview => 'Anrede (Sächsisch-Vorschau)',
      };

  String get accentColorLabel => switch (style) {
        SpeechStyle.informalDu => 'Wähle deine Akzentfarbe',
        SpeechStyle.formalSie => 'Wählen Sie Ihre Akzentfarbe',
        SpeechStyle.saxonyPreview => 'Such dir ’ne schicke Farbe aus',
      };

  String get profileHint => switch (style) {
        SpeechStyle.informalDu =>
          'Aktives Hörerprofil: Du kannst alles entspannt anpassen, ohne zugespammt zu werden.',
        SpeechStyle.formalSie =>
          'Aktives Hörerprofil: Alle Optionen lassen sich übersichtlich und ohne störende Hinweise anpassen.',
        SpeechStyle.saxonyPreview =>
          'Profil aktiv: Nix drängt sich uff, alles bleibt übersichtlich.',
      };
}