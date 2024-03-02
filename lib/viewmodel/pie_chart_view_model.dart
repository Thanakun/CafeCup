import 'package:coffee_application/model/response/pie_graph_response.dart';
import 'package:coffee_application/service/pie_chart_service.dart';

class PieChartVM {
  PieChartService _service = PieChartService();

  late Future<PieChartGraphResponse> pieChartData;

  Future<bool> getPieChartData([
    int? year,
    int? quarter,
    int? month,
    dynamic dayOfWeek,
  ]) async {
    pieChartData = _service.getPieChartData(year, quarter, month, dayOfWeek);
    return true;
  }
}
