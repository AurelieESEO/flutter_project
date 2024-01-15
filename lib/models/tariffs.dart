// Model for tariffs
// - tariffPmr: tariff for a person with reduced mobility
// - tariff1H: tariff for 1 hour
// - tariff2H: tariff for 2 hours
// - tariff3H: tariff for 3 hours
// - tariff4H: tariff for 4 hours
// - tariff24H: tariff for 24 hours
// - tariffResident: monthly tariff for a resident
// - tariffNonResident: monthly tariff for a non resident
class Tariffs {
  String? tariffPmr;
  double tariff1H;
  double tariff2H;
  double tariff3H;
  double tariff4H;
  double tariff24H;
  int? tariffResident;
  int? tariffNonResident;

  // Constructor of the class Tariffs
  Tariffs(this.tariff1H, this.tariff2H, this.tariff3H, this.tariff4H,
      this.tariff24H,
      {this.tariffPmr, this.tariffResident, this.tariffNonResident});

  // Method to convert a Tariffs object to a JSON object
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

  // Method to convert a JSON object to a Tariffs object
  factory Tariffs.fromJson(Map<String, dynamic> json) {
    return Tariffs(json['tariff1H'], json['tariff2H'], json['tariff3H'],
        json['tariff4H'], json['tariff24H'],
        tariffPmr: json['tariffPmr'],
        tariffResident: json['tariffResident'],
        tariffNonResident: json['tariffNonResident']);
  }
}
