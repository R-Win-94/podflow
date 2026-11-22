// lib/main.dart
import 'package:material_ui/material_ui.dart';
import 'l10n/strings.dart';
import 'screens/home_screen.dart';
import 'state/podflow_controller.dart';

void main() {
  runApp(PodFlowApp());
}

class PodFlowApp extends StatelessWidget {
  PodFlowApp({super.key});

  final PodFlowController _controller = PodFlowController();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final settings = _controller.settings;
        final strings = PodFlowStrings(settings.speechStyle);

        return MaterialApp(
          title: strings.appTitle,
          themeMode: settings.themeMode,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: settings.seedColor,
              brightness: Brightness.light,
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: settings.seedColor,
              brightness: Brightness.dark,
            ),
          ),
          home: HomeScreen(controller: _controller),
        );
      },
    );
  }
}