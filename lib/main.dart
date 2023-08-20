import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:inshorts/model/bookmark_model.dart';
import 'package:inshorts/splash/splashscreen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BookmarkAdapter());

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeModel(),
      child: const MyApp(),
    ),
  );
}

class ThemeModel extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, themeModel, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            brightness: themeModel.isDarkMode ? Brightness.dark : Brightness.light,
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
