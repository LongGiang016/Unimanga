// import 'package:intern_vua_gao/app/core/base_api_model.dart';

// class HistoryShippingModel extends BaseApiModel {
//   String? id;
//   String? status;
//   String? idStatus;
//   String? dateTime;

//   HistoryShippingModel({
//     this.id,
//     this.idStatus,
//     this.status,
//     this.dateTime,
//     act,
//     plus,
//   }) : super(act: act, plus: plus);

//   factory HistoryShippingModel.initial() {
//     return HistoryShippingModel(act: '', plus: '');
//   }

//   factory HistoryShippingModel.fromJson(Map<String, dynamic> json) {
//     return HistoryShippingModel(
//       id: json["id"],
//       idStatus: json["id_status"],
//       status: json["status"],
//       dateTime: json["date"],
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       "id": id,
//       "id_status": idStatus,
//       "status": status,
//       "date": dateTime,
//     };
//   }
// }
