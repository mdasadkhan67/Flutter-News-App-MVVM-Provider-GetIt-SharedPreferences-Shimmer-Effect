import 'package:flutter/foundation.dart';
import 'package:news_app/data/response/api_response.dart';
import 'package:news_app/model/top_news_model.dart';
import '../../configs/app_api_url.dart';
import '../../repo/news_repository.dart';

class HomeNewsProviderViewModel extends ChangeNotifier {
  final NewsRepository homeNewsRepository;
  HomeNewsProviderViewModel({required this.homeNewsRepository});

  ApiResponse<TopNewsModel> newsList = ApiResponse.loading();

  void setResponseStatus() {
    newsList = ApiResponse.loading();

    homeNewsRepository
        .getPopularNewsApiRepo(AppApiUrl.topNewsApi)
        .then((response) {
      newsList = ApiResponse.success(response);
    }).catchError((error) {
      newsList = ApiResponse.error(error.toString());
    });
    notifyListeners();
  }

  Future<TopNewsModel> getPopularNewsApiRepo() async {
    try {
      dynamic response =
          await homeNewsRepository.getPopularNewsApiRepo(AppApiUrl.topNewsApi);
      return TopNewsModel.fromJson(response);
    } catch (error) {
      rethrow;
    }
  }
}
