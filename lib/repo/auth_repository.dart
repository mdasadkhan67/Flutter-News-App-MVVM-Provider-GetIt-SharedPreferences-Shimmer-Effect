import 'package:news_app/configs/app_api_url.dart';
import 'package:news_app/data/network/network_api_services.dart';

class AuthRepository {
  final _authRepository = NetworkApiServices();

  Future<dynamic> postRegisterApi(dynamic data) async {
    try {
      dynamic response =
          await _authRepository.getPostApiResponse(AppApiUrl.registerApi, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postLoginApi(dynamic data) async {
    try {
      dynamic response =
          await _authRepository.getPostApiResponse(AppApiUrl.loginApi, data);
      return response;
    } catch (e) {
      print('Auth Repo: ${e}');
      throw e;
    }
  }
}
