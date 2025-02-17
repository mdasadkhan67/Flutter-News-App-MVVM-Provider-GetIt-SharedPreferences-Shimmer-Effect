import 'package:provider/provider.dart';
import 'package:nested/nested.dart';
import '../repo/auth_repository.dart';
import '../repo/news_repository.dart';
import '../view_model/filer_news_view_model/filer_news_view_model.dart';
import '../view_model/home_view_model/home_view_model.dart';
import '../view_model/login_view_model/login_view_model.dart';
import '../view_model/register_view_model/register_view_model.dart';
import '../view_model/splash_view_model/splash_view_model.dart';

List<SingleChildWidget> get providerList {
  return [
    ChangeNotifierProvider(create: (_) => SplashViewModel()),
    ChangeNotifierProvider(
        create: (_) =>
            RegisterProvideViewModel(authRepository: AuthRepository())),
    ChangeNotifierProvider(
        create: (_) =>
            LoginProviderViewModel(authRepository: AuthRepository())),
    ChangeNotifierProvider(
        create: (_) =>
            HomeNewsProviderViewModel(homeNewsRepository: NewsRepository())),
    ChangeNotifierProvider(
        create: (_) =>
            FilterProviderNewsViewModel(homeNewsRepository: NewsRepository())),
  ];
}
