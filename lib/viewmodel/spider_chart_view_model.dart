import 'package:coffee_application/model/response/spider_graph_response.dart';
import 'package:coffee_application/service/spider_chart.service.dart';

class SpiderChartVM {
  final SpiderChartService _service = SpiderChartService();
  late Future<SpiderChartResponseModel> spiderChartDataFirstGraph;
  late Future<SpiderChartResponseModel> spiderChartDataSecondGraph;

  void onUserEnterSpiderChartPage() {
    getSpiderChartFirstGraph();
    getSpiderChartSecondGraph();
  }

  Future<void> getSpiderChartFirstGraph([
    int? year,
    int? quarter,
    int? month,
    dynamic dayOfWeek,
  ]) async {
    spiderChartDataFirstGraph =
        _service.getSpiderChartData(year, quarter, month, dayOfWeek);
  }

  Future<void> getSpiderChartSecondGraph([
    int? year,
    int? quarter,
    int? month,
    dynamic dayOfWeek,
  ]) async {
    spiderChartDataSecondGraph =
        _service.getSpiderChartData(year, quarter, month, dayOfWeek);
  }
}
