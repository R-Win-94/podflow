import 'package:material_ui/material_ui.dart';
import '../models/app_settings.dart';
import '../services/settings_storage.dart';

class PodFlowController extends ChangeNotifier {
  final SettingsStorage _storage = SettingsStorage();
  PodFlowSettings _settings = const PodFlowSettings();
  bool _isLoaded = false;

  PodFlowSettings get settings => _settings;
  bool get isLoaded => _isLoaded;

  Future<void> init() async {
    _settings = await _storage.loadSettings();
    _isLoaded = true;
    notifyListeners();
  }

  Future<void> _updateAndPersist(PodFlowSettings next) async {
    _settings = next;
    notifyListeners();
    await _storage.saveSettings(_settings);
  }

  Future<void> setSpeechStyle(SpeechStyle style) async {
    if (_settings.speechStyle == style) return;
    await _updateAndPersist(_settings.copyWith(speechStyle: style));
  }

  Future<void> setListenerProfile(ListenerProfile profile) async {
    if (_settings.listenerProfile == profile) return;
    await _updateAndPersist(_settings.copyWith(listenerProfile: profile));
  }

  Future<void> setSeedColor(Color color) async {
    if (_settings.seedColor == color) return;
    await _updateAndPersist(_settings.copyWith(seedColor: color));
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_settings.themeMode == mode) return;
    await _updateAndPersist(_settings.copyWith(themeMode: mode));
  }

  Future<void> setEpisodeLimit(String podcastKey, int? limit) async {
    final updated = Map<String, int>.from(_settings.episodeLimitsByPodcast);
    if (limit == null || limit <= 0) {
      updated.remove(podcastKey);
    } else {
      updated[podcastKey] = limit;
    }
    await _updateAndPersist(_settings.copyWith(episodeLimitsByPodcast: updated));
  }
}