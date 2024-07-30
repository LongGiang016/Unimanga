import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/global_widgets/chappter_item.dart';
import 'package:unimanga_app/app/global_widgets/index.dart';
import 'package:unimanga_app/app/models/chap_comic.dart';
import 'package:unimanga_app/app/models/comic_model.dart';
import 'package:unimanga_app/app/modules/dashboard/controllers/dashboard_controllers.dart';

import '../../../../constants/index.dart';

double sizefix( double size , double screen){
   return Sizefix.sizefix(size, screen);
}
double sizefixall( double size , double screenh, double screenw){
   return Sizefix.sizefixall(size, screenh, screenw);
}

class ChappterPage extends GetView<DashboardController>{
  const ChappterPage ({super.key, required this.screenHeight,required this.screenWidth, });
  // ignore: prefer_typing_uninitialized_variables
  final screenWidth;
  final screenHeight; 
  //final ComicModel comic;
  @override
  Widget build(BuildContext context){
    List<ChapComicModel> listchap = controller.comic.value.chapComicModel!;
    return RefreshIndicator(
      onRefresh: () => controller.fecchComic(controller.comic.value.id!),
      child: Column(
        children: [
          Padding(
            padding:EdgeInsets.only(left: sizefix(10, screenWidth), right: sizefix(10, screenWidth), bottom: sizefix(10, screenHeight)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextCustom(text: "Cập nhật đến chap ${controller.comic.value.chapComicModel?.length}", fontsize: sizefix(12, screenHeight),color: Colors.grey, ),
                Row(
                  children: [
                    TextCustom(text: "Cũ nhất",fontsize: sizefix(12, screenHeight), color: Colors.grey,),
                    Padding(
                      padding: EdgeInsets.only(left: sizefix(20, screenWidth)),
                      child: TextCustom(text: "Mới nhất",fontsize: sizefix(12, screenHeight), color: Colors.grey,),
                    )
                  ],
                ),
              ],
            ),
          ),   
          Expanded(
            child: GridView.builder(
              //physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // Số lượng cột
                childAspectRatio: 6, // Tỉ lệ chiều rộng và chiều cao của mỗi item
              ),
              itemCount: listchap.length,
              itemBuilder: (context, index) {
                return ChappterItem(screenHeight: screenHeight, screenWidth: screenWidth, chappter: listchap[index], comic: controller.comic.value,);
              },
            ),
          )
      
        ],
      ),
    );
  }
}