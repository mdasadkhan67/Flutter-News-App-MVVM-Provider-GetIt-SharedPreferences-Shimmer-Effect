import 'api_status.dart';

class ApiResponse<T> {
  ApiStatus status;
  T? data;
  String? message;

  ApiResponse({
    required this.status,
    this.data,
    this.message,
  });

  ApiResponse.notStarted() : status = ApiStatus.notStarted;

  ApiResponse.success(this.data) : status = ApiStatus.success;

  ApiResponse.error(this.message) : status = ApiStatus.error;

  ApiResponse.loading() : status = ApiStatus.loading;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
