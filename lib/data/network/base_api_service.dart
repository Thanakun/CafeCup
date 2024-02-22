abstract class BaseApiService {
  Future<dynamic> getApiAuth(String url);

  Future<dynamic> postAuthApi(String url, dynamic data);
}
