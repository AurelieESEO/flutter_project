class Tariffs {
  String tariffPmr;
  double tariff1H;
  double tariff2H;
  double tariff3H;
  double tariff4H;
  double tariff24H;
  double tariffResident;
  double tariffNonResident;

  Tariffs(
      this.tariffPmr,
      this.tariff1H,
      this.tariff2H,
      this.tariff3H,
      this.tariff4H,
      this.tariff24H,
      this.tariffResident,
      this.tariffNonResident
  );

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
        json['tariffPmr'],
        json['tariff1H'],
        json['tariff2H'],
        json['tariff3H'],
        json['tariff4H'],
        json['tariff24H'],
        json['tariffResident'],
        json['tariffNonResident']
    );
  }
}