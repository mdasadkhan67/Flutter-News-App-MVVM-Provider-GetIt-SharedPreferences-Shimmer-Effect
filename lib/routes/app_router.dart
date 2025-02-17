import 'package:go_router/go_router.dart';
import 'package:news_app/model/top_news_model.dart';
import 'package:news_app/routes/app_routes_name.dart';
import 'package:news_app/view/home_screen/home_screen.dart';
import 'package:news_app/view/login_screen/login_screen.dart';
import 'package:news_app/view/news_details_screen.dart/news_details_screen.dart';
import '../utils/error_widget/error_widget.dart';
import '../view/filter_news_list/filter_news_list.dart';
import '../view/news_list/news_list.dart';
import '../view/register_screen/register_screen.dart';
import '../view/splash_screen/splash_screen_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRouteNames.initialscreen,
  routes: [
    GoRoute(
      path: AppRouteNames.initialscreen,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: AppRouteNames.login,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: AppRouteNames.register,
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: AppRouteNames.home,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: AppRouteNames.newsList,
      builder: (context, state) => NewsList(),
    ),
    GoRoute(
      path: AppRouteNames.newsdetails,
      builder: (context, state) {
        final deatilsData = state.extra as Articles;
        return NewsDetailsScreen(deatilsData: deatilsData);
      },
    ),
    GoRoute(
      path: AppRouteNames.filternewsList,
      builder: (context, state) {
        return FilterNewsList();
      },
    ),
    GoRoute(
      path: '/error/:errorMessage',
      builder: (context, state) {
        // Decode the error message from the URL
        final errorMessage = Uri.decodeComponent(
            state.pathParameters['errorMessage'] ?? 'Default error message');
        return ErrorWidget(errorMessage: errorMessage);
      },
    ),
  ],
);
