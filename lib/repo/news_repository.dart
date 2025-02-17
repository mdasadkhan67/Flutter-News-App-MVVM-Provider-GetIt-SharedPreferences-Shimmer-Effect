import '../data/network/network_api_services.dart';

class NewsRepository {
  final _newsRepository = NetworkApiServices();

  Future<dynamic> getPopularNewsApiRepo(dynamic url) async {
    try {
      dynamic response = await _newsRepository.getGetApiResponse(url);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> getNewsApiRepoByFilter(dynamic url) async {
    try {
      dynamic response = await _newsRepository.getGetApiResponse(url);
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
