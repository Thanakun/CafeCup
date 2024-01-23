import 'package:coffee_application/data/response/status.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponse(this.status, this.data, this.message);

  ApiResponse.loading() : status = Status.loading;

  ApiResponse.complete() : status = Status.complete;

  ApiResponse.error() : status = Status.error;


  @override
  String toString(){
    return "Status : $status \n Message : $message \n Data: $data";
  }
}
