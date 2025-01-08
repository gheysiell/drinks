import 'package:drinks/core/navigation_service.dart';
import 'package:drinks/core/providers.dart';
import 'package:drinks/features/drinks/presentation/views/drinks_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drinks/shared/palette.dart';

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
          fontFamily: 'Nunito',
          textSelectionTheme: const TextSelectionThemeData(
            selectionHandleColor: Palette.primary,
            cursorColor: Palette.primary,
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Palette.primary,
          ),
          useMaterial3: true,
        ),
        home: const DrinksView(),
      ),
    );
  }
}
