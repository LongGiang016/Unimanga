class PayMentModel {
  String? id;
  String? gmail;
  String? idNguoiDung;
  String? ngayThanhToan;
  String? soTien;
  String? tenNguoiDung;
  String? thoiGianThanhToan;

  PayMentModel({
    this.id,
    this.gmail,
    this.idNguoiDung,
    this.ngayThanhToan,
    this.soTien,
    this.tenNguoiDung,
    this.thoiGianThanhToan,
  });

  factory PayMentModel.fromJson(Map<Object?, Object?> json) {
    return PayMentModel(
      id: json["Id"] as String?,
      gmail: json["Gmail"] as String?,
      idNguoiDung: json["IdNguoiDung"] as String?,
      ngayThanhToan: json["NgayThanhToan"] as String?,
      soTien: json["SoTien"] as String?,
      tenNguoiDung: json["TenNguoiDung"] as String?,
      thoiGianThanhToan: json["ThoiGianThanhToan"] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "Id": id,
      "Gmail": gmail,
      "IdNguoiDung": idNguoiDung,
      "NgayThanhToan": ngayThanhToan,
      "SoTien": soTien,
      "TenNguoiDung": tenNguoiDung,
      "ThoiGianThanhToan": thoiGianThanhToan,
    };
  }
}