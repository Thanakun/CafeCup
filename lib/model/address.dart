class Address {
  String country;
  String province;
  String district;
  String subDistrict;
  String road;
  String postalCode;
  String addressText;

  Address({
    required this.country,
    required this.province,
    required this.district,
    required this.subDistrict,
    required this.road,
    required this.postalCode,
    required this.addressText,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      country: json['country'],
      province: json['province'],
      district: json['district'],
      subDistrict: json['subDistrict'],
      road: json['road'],
      postalCode: json['postalCode'],
      addressText: json['addressText'],
    );
  }
}
