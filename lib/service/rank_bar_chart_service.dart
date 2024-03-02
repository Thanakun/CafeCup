import 'package:coffee_application/data/network/dio_network_api_service.dart';
import 'package:coffee_application/hive/boxes.dart';
import 'package:coffee_application/model/response/rank_bar_chart_response.dart';

class RankBarChartService {
  late final DioApiService _dio;

  RankBarChartService() {
    _dio = DioApiService();
  }

  Future<ReviewRankBarChartResponse> getRankChartData([
    int? year,
    int? quarter,
    int? month,
    dynamic dayOfWeek,
  ]) async {
    try {
      final response = await _dio.getApiAnalytics("/analytic/reviewRank", {
        "_shopId": boxUsers.get(0).id,
        "year": year,
        "quarter": quarter,
        "month": month,
      });
      ReviewRankBarChartResponse responseData =
          ReviewRankBarChartResponse.fromJson(response);

      return responseData;
    } catch (_) {
      rethrow;
    }
  }
}
