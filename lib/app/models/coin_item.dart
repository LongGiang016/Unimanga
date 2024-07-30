class CoinModel {
  final String? id;
  final String? giaTri;
  final String? ten;
  final String? xu;

  CoinModel({this.id, this.giaTri, this.ten, this.xu});

  factory CoinModel.fromJson(Map<Object?, Object?> json) {
    return CoinModel(
      id: json["Id"] as String?,
      giaTri: json["GiaTri"] as String?,
      ten: json["Ten"] as String?,
      xu: json["Xu"] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "Id": id,
      "GiaTri": giaTri,
      "Ten": ten,
      "Xu": xu
    };
  }
}