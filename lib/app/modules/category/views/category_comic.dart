import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:unimanga_app/app/models/category_comic_model.dart';
import '../../../constants/index.dart';
import '../../../global_widgets/index.dart';

double sizefix( double size , double screen){
   return Sizefix.sizefix(size, screen);
}
class CategoryComicItem extends GetView{
  const CategoryComicItem ({super.key, required this.screenHeight,required this.screenWidth, required this.cate});
  // ignore: prefer_typing_uninitialized_variables
  final screenWidth;
  final screenHeight;
  final categoryComicModel cate;
  @override
  Widget build(BuildContext context){
  return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: sizefix(10, screenWidth), right: sizefix(10, screenWidth)),
      height: sizefix(22, screenHeight),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(sizefix(10, screenWidth)),
        border: Border.all( color: AppColors.RedPrimary, width: sizefix(1, screenWidth))
      ),
      child: TextCustom(text: cate.tenTheLoai, color: AppColors.RedPrimary, fontsize: sizefix(12, screenWidth),),
    );
  }
}