import 'package:coffee_application/data/network/dio_network_api_service.dart';
import 'package:coffee_application/hive/boxes.dart';
import 'package:coffee_application/model/response/spider_graph_response.dart';

class SpiderChartService {
  late final DioApiService _dio;

  SpiderChartService() {
    _dio = DioApiService();
  }

  Future<SpiderChartResponseModel> getSpiderChartData([
    int? year,
    int? quarter,
    int? month,
    dynamic dayOfWeek,
  ]) async {
    try {
      final response = await _dio.getApiAnalytics("/analytic/reviewShopScore", {
        "_shopId": boxUsers.get(0).id,
        "year": year,
        "quarter": quarter,
        "month": month,
        "dayOfWeek": dayOfWeek
      });
      SpiderChartResponseModel responseData =
          SpiderChartResponseModel.fromJson(response);

      return responseData;
    } catch (_) {
      rethrow;
    }
  }
}
