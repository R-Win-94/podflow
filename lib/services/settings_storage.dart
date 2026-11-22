import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/app_settings.dart';

class SettingsStorage {
  Future<File> _getFile() async {
    final dir = await getApplicationSupportDirectory();
    return File('${dir.path}${Platform.pathSeparator}podflow_settings.json');
  }

  Future<PodFlowSettings> loadSettings() async {
    try {
      final file = await _getFile();
      if (!await file.exists()) {
        return const PodFlowSettings();
      }
      final content = await file.readAsString();
      if (content.trim().isEmpty) {
        return const PodFlowSettings();
      }
      final decoded = jsonDecode(content);
      if (decoded is Map<String, dynamic>) {
        return PodFlowSettings.fromJson(decoded);
      }
      return const PodFlowSettings();
    } catch (_) {
      return const PodFlowSettings();
    }
  }

  Future<void> saveSettings(PodFlowSettings settings) async {
    try {
      final file = await _getFile();
      await file.parent.create(recursive: true);
      await file.writeAsString(jsonEncode(settings.toJson()));
    } catch (_) {
      // Unaufdringlich: kein störendes Pop-up beim stillen Speichern
    }
  }
}