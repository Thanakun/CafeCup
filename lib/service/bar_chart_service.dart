import 'package:coffee_application/data/network/dio_network_api_service.dart';
import 'package:coffee_application/hive/boxes.dart';
import 'package:coffee_application/model/response/reach_graph_response.dart';

class BarChartService {
  late final DioApiService _dio;

  BarChartService() {
    _dio = DioApiService();
  }

  Future<ReachGraphResponse> getBarChartData([
    int? year,
    int? quarter,
    int? month,
    dynamic dayOfWeek,
  ]) async {
    try {
      final response = await _dio.getApiAnalytics("/analytic/reachCount", {
        "_shopId": boxUsers.get(0).id,
        "year": year,
        "quarter": quarter,
        "month": month,
        "dayOfWeek": dayOfWeek
      });
      return ReachGraphResponse.fromJson(response);
    } catch (_) {
      rethrow;
    }
  }
}
