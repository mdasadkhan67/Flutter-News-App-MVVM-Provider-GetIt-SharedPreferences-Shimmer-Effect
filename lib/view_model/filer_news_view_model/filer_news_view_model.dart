import 'package:flutter/material.dart';
import '../../configs/app_api_url.dart';
import '../../data/response/api_response.dart';
import '../../model/top_news_model.dart';
import '../../repo/news_repository.dart';

class FilterProviderNewsViewModel extends ChangeNotifier {
  final NewsRepository homeNewsRepository;
  bool isLoading = false; // Track loading state
  FilterProviderNewsViewModel({required this.homeNewsRepository});

  ApiResponse<TopNewsModel> newsList = ApiResponse.loading();

  late DateTime? newDate = DateTime(2025, 02, 16);
  String publication = ''; // Initialize to empty string
  String country = ''; // Initialize to empty string

  // Cache to store the fetched news data
  TopNewsModel? cachedNewsData;

  void changePublicationFilter(String selectedPublication) {
    publication = selectedPublication;
    notifyListeners();
  }

  void changeCountryFilter(String selectedCountry) {
    country = selectedCountry;
    notifyListeners();
  }

  // Handle date change with loading state
  void setDate(BuildContext context) async {
    final DateTime? pickedDate = await _showDatePicker(context);
    if (pickedDate != null) {
      newDate = pickedDate;
      isLoading = true; // Set loading to true when date is changed
      notifyListeners();
      await getDataByDate(newDate!);
      isLoading = false; // Set loading to false after data is fetched
      notifyListeners();
    }
  }

  Future<DateTime?> _showDatePicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: newDate ?? DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime.now(),
    );
    return pickedDate;
  }

  // Get data by date but use cached data if available
  Future<TopNewsModel> getDataByDate(DateTime selectedDate) async {
    if (cachedNewsData != null && !isLoading) {
      // If cached data exists and not loading, return it immediately
      return cachedNewsData!;
    }

    try {
      final response = await homeNewsRepository
          .getNewsApiRepoByFilter(AppApiUrl.filterByDateAPI(selectedDate));
      // Cache the fetched data
      cachedNewsData = TopNewsModel.fromJson(response);
      return cachedNewsData!;
    } catch (error) {
      throw Exception('Failed to load news: $error');
    }
  }
}
