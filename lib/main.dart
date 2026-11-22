// lib/main.dart
import 'package:material_ui/material_ui.dart';
import 'l10n/strings.dart';
import 'screens/home_screen.dart';
import 'state/podflow_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final controller = PodFlowController();
  await controller.init();
  runApp(PodFlowApp(controller: controller));
}

class PodFlowApp extends StatelessWidget {
  final PodFlowController controller;

  const PodFlowApp({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final settings = controller.settings;
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
          home: HomeScreen(controller: controller),
        );
      },
    );
  }
}