import 'package:cetak_photo/app/modules/selectedImagesPage/views/selected_images_page_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[300],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[300],
        title: Text(
          'PILIH FOTO',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.photo_library),
            onPressed: () {
              // Navigasi ke halaman SelectedImagesPageView
              Get.to(() => SelectedImagesPageView(
                  selectedImages: controller.selectedImages));
            },
          ),
        ],
      ),
      body: Obx(
        () => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
          itemCount: controller.imageUrls.length,
          itemBuilder: (context, index) {
            String imageUrl = controller.imageUrls[index];
            return GestureDetector(
              onTap: () => _showImagePreview(context, imageUrl),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        8.0), // Atur radius sesuai keinginan Anda
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover, // Menyesuaikan gambar ke dalam kotak
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Obx(
                      () => Checkbox(
                        value: controller.selectedImages.contains(imageUrl),
                        onChanged: (isChecked) {
                          if (isChecked != null) {
                            controller.toggleSelected(imageUrl);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            // Memilih otomatis semua checkbox jika setidaknya satu checkbox sudah dicentang
            if (controller.selectedImages.isNotEmpty) {
              controller.selectAllImages();
            }
          },
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.blueGrey[300]),
              elevation: MaterialStatePropertyAll(0)),
          child: Text(
            'Pilih Semua Foto',
            style: TextStyle(color: Colors.black),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            if (controller.selectedImages.isEmpty) {
              Get.snackbar(
                'Error',
                'Pilih Foto terlebih dahulu',
                snackPosition: SnackPosition.BOTTOM,
                duration: Duration(seconds: 1),
                colorText: Colors.black,
              );
            } else {
              await Get.to(() => SelectedImagesPageView(
                  selectedImages: controller.selectedImages));
              await controller.removeSelectedImagesFromHome();
            }
          },
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.blueGrey[300]),
              elevation: MaterialStatePropertyAll(0)),
          child: Text(
            'PILIH',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  void _showImagePreview(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Image.network(imageUrl),
        );
      },
    );
  }
}
