import 'package:coffee_application/data/network/dio_network_api_service.dart';
import 'package:coffee_application/hive/boxes.dart';
import 'package:coffee_application/model/response/reach_graph_response.dart';

import '../model/response/pie_graph_response.dart';

class PieChartService {
  late final DioApiService _dio;

  PieChartService() {
    _dio = DioApiService();
  }

  Future<PieChartGraphResponse> getPieChartData([
    int? year,
    int? quarter,
    int? month,
    dynamic dayOfWeek,
  ]) async {
    try {
      final response = await _dio.getApiAnalytics("/analytic/reachAge", {
        "_shopId": boxUsers.get(0).id,
        "year": year,
        "quarter": quarter,
        "month": month,
        "dayOfWeek": dayOfWeek
      });
      return PieChartGraphResponse.fromJson(response);
    } catch (_) {
      rethrow;
    }
  }
}
