import 'package:coffee_application/service/scanner_service.dart';

class ScannerVM {
  ScannerService _service = ScannerService();

  Future<bool> onUserScannedCode({required String code}) async {
    return _service.onUserScannedCode(code: code);
  }
}
