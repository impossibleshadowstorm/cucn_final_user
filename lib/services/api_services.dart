import 'api/api_client.dart';

class ApiServices {
  late final ApiClient _apiClient;

  ApiClient init() {
    _apiClient = ApiClient();
    return _apiClient;
  }
}
