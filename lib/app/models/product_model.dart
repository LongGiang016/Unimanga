// import 'package:intern_vua_gao/app/core/base_api_model.dart';

// class ProductModel extends BaseApiModel {
//   String? userId;
//   String? id;
//   String? idCart;
//   String? name;
//   String? price;
//   String? discount;
//   String? priceAfterDiscount;
//   String? sold;
//   String? image;
//   String? amount;
//   String? isCheck;

//   ProductModel({
//     this.userId,
//     this.id,
//     this.idCart,
//     this.name,
//     this.price,
//     this.discount,
//     this.priceAfterDiscount,
//     this.sold,
//     this.image,
//     this.amount,
//     this.isCheck,
//     act,
//     plus,
//   }) : super(act: act, plus: plus);

//   factory ProductModel.initial() {
//     return ProductModel(userId: '', act: '', plus: '');
//   }
//   @override
//   String toString() {
//     return 'ProductModel(id: $id, idCart: $idCart, name: $name, price: $price, discount: $discount, priceAfterDiscount: $priceAfterDiscount, sold: $sold, image: $image, amount: $amount, isCheck: $isCheck)';
//   }
//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     return ProductModel(
//       id: json["id"],
//       idCart: json["id_cart"],
//       name: json["name"],
//       price: json["price"],
//       discount: json["discount"],
//       priceAfterDiscount: json["priceAfterDiscount"],
//       sold: json["sold"],
//       image: json["image"],
//       amount: json["quantity"],
//       isCheck: "0",
//     );
//   }
//   Map<String, dynamic> toMap() {
//     return {
//       "id": id,
//       "name": name,
//       "price": price,
//       "discount": discount,
//       "priceAfterDiscount": priceAfterDiscount,
//       "sold": sold,
//       "image": image,
//       "quantity": amount,
//       "id_cart": idCart,
//       "isCheck": isCheck,
//       "act": act,
//       "userId": userId,
//     };
//   }
// }
