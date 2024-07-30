
class categoryComicModel{
  final String? id;
  final String? tenTheLoai;
  categoryComicModel({
    this.id,
    this.tenTheLoai
  });
  factory categoryComicModel.fromJson(Map<Object?, Object?> json) {
    return categoryComicModel(
      id: json["Id"] as String ,
      tenTheLoai: json["TenTheLoai"] as String ,
    );
  }
  Map<String, dynamic> toMap(){
    return {
    "id": id,
    "TenTheLoai": tenTheLoai,
    };
  }
}