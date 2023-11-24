class Address {
  String? streetName;
  String? buildingNumber;
  String? townName;
  String? postCode;
  String? country;

  Address({
    this.streetName,
    this.buildingNumber,
    this.townName,
    this.postCode,
    this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        streetName: json['streetName'] as String?,
        buildingNumber: json['buildingNumber'] as String?,
        townName: json['townName'] as String?,
        postCode: json['postCode'] as String?,
        country: json['country'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'streetName': streetName,
        'buildingNumber': buildingNumber,
        'townName': townName,
        'postCode': postCode,
        'country': country,
      };
}
