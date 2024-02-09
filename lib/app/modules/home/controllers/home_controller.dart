import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class HomeController extends GetxController {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  RxList imageUrls = [].obs;
  RxList selectedImages = [].obs;

  @override
  void onInit() {
    loadImagesFromFirebase();
    super.onInit();
  }

  Future<void> loadImagesFromFirebase() async {
    try {
      var result =
          await firebase_storage.FirebaseStorage.instance.ref().listAll();
      imageUrls.value = await Future.wait(
          result.items.map((item) => item.getDownloadURL()).toList());
    } catch (e) {
      print('Error loading images from Firebase: $e');
    }
  }

  void toggleSelected(String imageUrl) {
    if (selectedImages.contains(imageUrl)) {
      selectedImages.remove(imageUrl);
    } else {
      selectedImages.add(imageUrl);
    }
  }

  Future<void> removeSelectedImagesFromHome() async {
    imageUrls.removeWhere((imageUrl) => selectedImages.contains(imageUrl));
  }

  void selectAllImages() {
    // Jika ada setidaknya satu item yang belum dipilih, maka semua item akan dipilih
    if (selectedImages.length < imageUrls.length) {
      selectedImages.clear();
      selectedImages.addAll(imageUrls);
    } else {
      // Jika semua item sudah dipilih, maka semua item akan tidak dipilih (false)
      selectedImages.clear();
    }
  }
}
