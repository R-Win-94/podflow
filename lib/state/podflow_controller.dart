import 'package:material_ui/material_ui.dart';
import '../models/app_settings.dart';

class PodFlowController extends ChangeNotifier {
  PodFlowSettings _settings = const PodFlowSettings();

  PodFlowSettings get settings => _settings;

  void setSpeechStyle(SpeechStyle style) {
    if (_settings.speechStyle == style) return;
    _settings = _settings.copyWith(speechStyle: style);
    notifyListeners();
  }

  void setListenerProfile(ListenerProfile profile) {
    if (_settings.listenerProfile == profile) return;
    _settings = _settings.copyWith(listenerProfile: profile);
    notifyListeners();
  }

  void setSeedColor(Color color) {
    if (_settings.seedColor == color) return;
    _settings = _settings.copyWith(seedColor: color);
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    if (_settings.themeMode == mode) return;
    _settings = _settings.copyWith(themeMode: mode);
    notifyListeners();
  }
}