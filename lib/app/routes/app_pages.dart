import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/selectedImagesPage/bindings/selected_images_page_binding.dart';
import '../modules/selectedImagesPage/views/selected_images_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SELECTED_IMAGES_PAGE,
      page: () => SelectedImagesPageView(
        selectedImages: RxList(),
      ),
      binding: SelectedImagesPageBinding(),
    ),
  ];
}
