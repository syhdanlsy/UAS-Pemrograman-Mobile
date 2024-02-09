import 'package:get/get.dart';

import '../controllers/selected_images_page_controller.dart';

class SelectedImagesPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectedImagesPageController>(
      () => SelectedImagesPageController(),
    );
  }
}
