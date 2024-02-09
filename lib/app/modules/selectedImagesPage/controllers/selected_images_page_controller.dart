import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get/get.dart';

class SelectedImagesPageController extends GetxController {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  RxList selectedImages = [].obs;
  RxList imageUrls = [].obs;

  void uploadFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      result.files.forEach((element) async {
        String name = element.name;
        File file = File(element.path!);
        try {
          await firebase_storage.FirebaseStorage.instance
              .ref(name)
              .putFile(file);
          String downloadUrl = await firebase_storage.FirebaseStorage.instance
              .ref(name)
              .getDownloadURL();
          imageUrls.add(downloadUrl);
          print('Berhasil upload file $name');
        } on firebase_storage.FirebaseException catch (e) {
          print('Error saat mengunggah file $name: $e');
        }
      });
    } else {
      print('Batal memilih file');
    }
  }

  void toggleSelected(String imageUrl) {
    if (selectedImages.contains(imageUrl)) {
      selectedImages.remove(imageUrl);
    } else {
      selectedImages.add(imageUrl);
    }
  }

  Future<void> removeSelectedImagesFromSelected() async {
    selectedImages.removeWhere((imageUrl) => imageUrls.contains(imageUrl));
  }
}
