import 'package:coffee_application/model/response/reach_graph_response.dart';
import 'package:coffee_application/service/bar_chart_service.dart';

class ReachBarChartVM {
  final BarChartService _service = BarChartService();
  late Future<ReachGraphResponse> barChartData;

  Future<bool> getBarChartData([
    int? year,
    int? quarter,
    int? month,
    dynamic dayOfWeek,
  ]) async {
    barChartData = _service.getBarChartData(year, quarter, month, dayOfWeek);
    return true;
  }
}
