class ValidateTokenResponse {
  String? status;
  validateData? data;

  ValidateTokenResponse({this.status, this.data});

  ValidateTokenResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new validateData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class validateData {
  int? iId;
  String? role;

  validateData({this.iId, this.role});

  validateData.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['role'] = this.role;
    return data;
  }
}
