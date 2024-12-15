import 'package:drinks/features/drinks/data/datasources/remote/drinks_datasource_remote_http.dart';
import 'package:drinks/features/drinks/data/repositories/drinks_repository_impl.dart';
import 'package:drinks/features/drinks/domain/usecases/drinks_usecase.dart';
import 'package:drinks/features/drinks/presentation/viewmodels/drinks_viewmodel.dart';
import 'package:drinks/features/drinks_details/presentation/viewmodels/drinks_details_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
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
  ChangeNotifierProvider(
    create: (context) => DrinksDetailsViewModel(),
  )
];
