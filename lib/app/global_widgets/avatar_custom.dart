// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class AvatarCustom extends StatelessWidget {
//   AvatarCustom(
//       {Key? key, this.fileImage, this.imageNetwork, this.size, this.onTap})
//       : super(key: key);
//   final fileImage;
//   final imageNetwork;
//   final double? size;
//   final onTap;
//   @override
//   Widget build(BuildContext context) {
//     return (fileImage != null && fileImage != "") ||
//             (imageNetwork != "" && imageNetwork != null)
//         ? GestureDetector(
//             onTap: onTap,
//             child: Container(
//               height: size,
//               width: size,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.5),
//                     spreadRadius: 1,
//                     blurRadius: 5,
//                     offset: Offset(0, 0), // changes position of shadow
//                   ),
//                 ],
//                 borderRadius: BorderRadius.circular(100),
//                 image: fileImage != null
//                     ? DecorationImage(
//                         image: FileImage(fileImage!), fit: BoxFit.cover)
//                     : DecorationImage(
//                         image: NetworkImage(imageNetwork!), fit: BoxFit.cover),
//               ),
//             ),
//           )
//         : GestureDetector(
//             onTap: onTap,
//             child: Container(
//               height: size,
//               width: size,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.5),
//                     spreadRadius: 1,
//                     blurRadius: 5,
//                     offset: Offset(0, 0), // changes position of shadow
//                   ),
//                 ],
//                 borderRadius: BorderRadius.circular(100),
//               ),
//               child: Icon(
//                 FontAwesomeIcons.solidUser,
//                 size: 40,
//               ),
//             ),
//           );
//   }
// }
