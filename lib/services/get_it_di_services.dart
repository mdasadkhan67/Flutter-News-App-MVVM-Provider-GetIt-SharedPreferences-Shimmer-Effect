import 'package:get_it/get_it.dart';
import 'package:news_app/repo/news_repository.dart';
import '../repo/auth_repository.dart';
import '../view_model/home_view_model/home_view_model.dart';
import '../view_model/register_view_model/register_view_model.dart';

final GetIt getItLocator = GetIt.instance;

void getItLocatorFunc() {
  // ✅ Register Singleton for Repository
  getItLocator.registerLazySingleton<AuthRepository>(() => AuthRepository());

  // ✅ Register Factory for ViewModel (Creates a new instance when requested)
  getItLocator.registerFactory<RegisterProvideViewModel>(() =>
      RegisterProvideViewModel(authRepository: getItLocator<AuthRepository>()));

  getItLocator.registerLazySingleton<NewsRepository>(() => NewsRepository());

  // ✅ Register Factory for ViewModel (Creates a new instance when requested)
  getItLocator.registerFactory<HomeNewsProviderViewModel>(() =>
      HomeNewsProviderViewModel(
          homeNewsRepository: getItLocator<NewsRepository>()));
}
