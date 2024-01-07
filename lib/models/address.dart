class Address {
  String street;
  String postCode;

  Address(this.street, this.postCode);

  factory Address.fromGeoJson(Map<String, dynamic> json) {
    final properties = json['properties'];
    final street = properties['name'];
    final postCode = properties['postcode'];
    return Address(street, postCode);
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'postCode': postCode,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(json['street'], json['city']);
  }
}