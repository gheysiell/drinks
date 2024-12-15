import 'package:drinks/core/navigation_service.dart';
import 'package:drinks/core/providers.dart';
import 'package:drinks/features/drinks/presentation/views/drinks_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Drinks());
}

class Drinks extends StatelessWidget {
  const Drinks({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Drinks',
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigatorKey,
        theme: ThemeData(
          textSelectionTheme: const TextSelectionThemeData(
            selectionHandleColor: Colors.orange,
            cursorColor: Colors.orange,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: true,
        ),
        home: const DrinksApp(),
      ),
    );
  }
}

class DrinksApp extends StatelessWidget {
  const DrinksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const DrinksView();
  }
}
