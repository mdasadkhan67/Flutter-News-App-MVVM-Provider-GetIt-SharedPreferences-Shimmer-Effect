import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/routes/app_routes_name.dart';
import '../../services/shared_preferences.dart';

class SplashViewModel with ChangeNotifier {
  final spref = SharedPreferenceHelper();
  void navigateToNextScreen(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      String? token = spref.getString('token');
      if (kDebugMode) {
        print('token : $token');
      }
      if (token == null || token.isEmpty) {
        context.go(AppRouteNames.login);
      } else {
        context.go(AppRouteNames.home);
      }
    });
  }
}
