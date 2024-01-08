class Tariffs {
  String? tariffPmr;
  double tariff1H;
  double tariff2H;
  double tariff3H;
  double tariff4H;
  double tariff24H;
  int? tariffResident;
  int? tariffNonResident;

  Tariffs(this.tariff1H, this.tariff2H, this.tariff3H,
      this.tariff4H, this.tariff24H,
      {this.tariffPmr, this.tariffResident, this.tariffNonResident});

  Map<String, dynamic> toJson() {
    return {
      'tariffPmr': tariffPmr,
      'tariff1H': tariff1H,
      'tariff2H': tariff2H,
      'tariff3H': tariff3H,
      'tariff4H': tariff4H,
      'tariff24H': tariff24H,
      'tariffResident': tariffResident,
      'tariffNonResident': tariffNonResident,
    };
  }

  factory Tariffs.fromJson(Map<String, dynamic> json) {
    return Tariffs(
        json['tariff1H'],
        json['tariff2H'],
        json['tariff3H'],
        json['tariff4H'],
        json['tariff24H'],
        tariffPmr: json['tariffPmr'],
        tariffResident: json['tariffResident'],
        tariffNonResident: json['tariffNonResident']);
  }
}
