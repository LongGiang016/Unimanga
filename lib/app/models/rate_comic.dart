class RateComic {
   String? hinhNen;
   String? id;
   String? idUser;
   String? day;
   String? time;
   String? starRate;
   String? userName;
   String? content;
   String? status;
  RateComic({
    this.id,
     this.idUser,
     this.day,
     this.time,
     this.starRate,
    this.content,
   this.hinhNen,
    this.userName,
    this.status,
  });
  factory RateComic.fromJson(Map<Object?, Object?> json) {
    return RateComic(
      id: json["Id"] as String? ,
      hinhNen: json["HinhNen"] as String?,
      idUser: json["IdNguoiDung"] as String?,
      day: json["Ngay"] as String?,
      time: json["ThoiGian"] as String?,
      starRate: json["SoSao"] as String?,
      content: json["NoiDung"] as String?,
      userName: json["TenNguoiDung"] as String?,
      status: json["TrangThai"] as String?
    );
  }
  Map<String, dynamic> toMap(){
  return {
    'Id': id,
    'HinhNen': hinhNen,
    'IdNguoiDung': idUser,
    'Ngay': day,
    'ThoiGian': time,
    'SoSao': starRate,
    'NoiDung': content,
    'TenNguoiDung': userName,
    'TrangThai': status
  };
}

}