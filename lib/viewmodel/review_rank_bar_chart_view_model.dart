import 'package:coffee_application/model/response/rank_bar_chart_response.dart';
import 'package:coffee_application/model/response/reach_graph_response.dart';
import 'package:coffee_application/service/bar_chart_service.dart';
import 'package:coffee_application/service/rank_bar_chart_service.dart';

class ReviewRankBarChartVM {
  final RankBarChartService _service = RankBarChartService();
  late Future<ReviewRankBarChartResponse> rankChartData;

  Future<bool> getRankChartData([
    int? year,
    int? quarter,
    int? month,
  ]) async {
    rankChartData = _service.getRankChartData(year, quarter, month);
    return true;
  }
}
