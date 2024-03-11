class ReviewPointsResponse {
  int? status;
  Data? data;

  ReviewPointsResponse({this.status, this.data});

  ReviewPointsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  int? iId;
  int? reviewPoints;
  bool? canClaimCode;
  String? lastClaim;
  int? daysToRefresh;

  Data(
      {this.iId,
      this.reviewPoints,
      this.canClaimCode,
      this.lastClaim,
      this.daysToRefresh});

  Data.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    reviewPoints = json['reviewPoints'];
    canClaimCode = json['canClaimCode'];
    lastClaim = json['lastClaim'];
    daysToRefresh = json['daysToRefresh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['reviewPoints'] = this.reviewPoints;
    data['canClaimCode'] = this.canClaimCode;
    data['lastClaim'] = this.lastClaim;
    data['daysToRefresh'] = this.daysToRefresh;
    return data;
  }
}
