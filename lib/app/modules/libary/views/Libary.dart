// import 'package:flutter/material.dart';

// import 'Followed.dart';
// import 'Watched.dart';

// class Libary extends StatefulWidget {
//   const Libary({super.key});

//   @override
//   State<Libary> createState() => _LibaryState();
// }

// class _LibaryState extends State<Libary> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//         initialIndex: 1,
//         length: 2,
//         child: Scaffold(
//           appBar: AppBar(
//             bottom: const PreferredSize(
//               preferredSize: Size.fromHeight(1),
//               child: TabBar(
//                 tabs: <Widget>[
//                   Tab(
//                     icon: Icon(Icons.bookmark_outline),
//                   ),
//                   Tab(
//                     icon: Icon(Icons.replay),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           body: const Column(
//             children: [
//               Expanded(
//                 child: TabBarView(
//                   children: <Widget>[Followed(), Watched()],
//                 ),
//               )
//             ],
//           ),
//         ));
//   }
// }
