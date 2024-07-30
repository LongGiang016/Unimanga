import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/category/bindings/category_binding.dart';
import '../modules/dashboard/controllers/dashboard_controllers.dart';

class Filter extends GetView<DashboardController> {
  Filter({Key? key}) : super(key: key);

  //dependency injection with getx

  //name of chips given as list
  final List<String> statusOptions = ['All', 'Asus', 'MI', 'Apple'];

  @override
  Widget build(BuildContext context) {
    //DashBoardBinding().dependencies();
    var listComic = controller.selectedChip;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Wrap(
                  spacing: 20,
                  children: List<Widget>.generate(
                    statusOptions.length,
                    (int index) {
                      return ChoiceChip(
                        label: Text(statusOptions[index]),
                        selected: listComic == index,
                        onSelected: (bool selected) {
                          if (selected) {
                            listComic = index;
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
