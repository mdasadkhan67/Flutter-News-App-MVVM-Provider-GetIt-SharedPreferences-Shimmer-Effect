import 'package:intl/intl.dart';

class AppApiUrl {
  static const String newsBaseUrl = 'https://newsapi.org/v2/';
  static const String authBaseUrl = 'https://reqres.in/api/';
  static const String apiKey = '79aeffa0e97e48ae8345a7541f0fc657';

  static const String registerApi = '${authBaseUrl}register';
  static const String loginApi = '${authBaseUrl}login';

  static const String topNewsApi =
      '${newsBaseUrl}top-headlines?sources=techcrunch&apiKey=$apiKey';

  static String filterByDateAPI(DateTime selectedDate) {
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    return '$newsBaseUrl/everything?q=tesla&from=$formattedDate&sortBy=publishedAt&apiKey=$apiKey';
  }
}
