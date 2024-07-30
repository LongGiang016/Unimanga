// import 'dart:convert';

// class PlaceAutocompleteModel {
//   PlaceAutocompleteModel({
//     this.description,
//     this.placeId,
//     this.mainText,
//     this.input,
//     this.radius,
//     this.lat,
//     this.lng,
//   });

//   String? description;
//   String? placeId;
//   String? mainText;
//   String? input;
//   String? radius;
//   double? lat;
//   double? lng;

//   factory PlaceAutocompleteModel.fromJson(String str) =>
//       PlaceAutocompleteModel.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory PlaceAutocompleteModel.fromMap(Map<String, dynamic> json) =>
//       PlaceAutocompleteModel(
//         description: json["description"],
//         placeId: json["place_id"],
//         mainText: json['structured_formatting']["main_text"],
//       );

//   Map<String, dynamic> toMap() => {
//         "description": description,
//         "place_id": placeId,
//       };

//   @override
//   String toString() {
//     return '&input=$input&radius=$radius&type=address';
//   }

//   @override
//   String toStringDetail() {
//     return '&place_id=$placeId';
//   }
// }
