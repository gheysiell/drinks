import 'package:drinks/features/drinks/data/datasources/remote/drinks_datasource_remote_http.dart';
import 'package:drinks/features/drinks/data/repositories/drinks_repository_impl.dart';
import 'package:drinks/features/drinks/domain/usecases/drinks_usecase.dart';
import 'package:drinks/features/drinks/presentation/viewmodels/drinks_viewmodel.dart';
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
      providers: [
        Provider(
          create: (context) => DrinksDataSourceRemoteHttpImpl(),
        ),
        Provider(
          create: (context) => DrinksRepositoryImpl(
            drinksDataSourceRemoteHttp: DrinksDataSourceRemoteHttpImpl(),
          ),
        ),
        Provider(
          create: (context) => DrinksUseCase(
            drinksRepository: DrinksRepositoryImpl(
              drinksDataSourceRemoteHttp: DrinksDataSourceRemoteHttpImpl(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => DrinksViewModel(
            drinksUseCase: DrinksUseCase(
              drinksRepository: DrinksRepositoryImpl(
                drinksDataSourceRemoteHttp: DrinksDataSourceRemoteHttpImpl(),
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Drinks',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
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
