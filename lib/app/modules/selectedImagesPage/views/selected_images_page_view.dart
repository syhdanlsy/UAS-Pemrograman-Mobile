import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';

import '../controllers/selected_images_page_controller.dart';

class SelectedImagesPageView extends GetView<SelectedImagesPageController> {
  final RxList selectedImages;

  const SelectedImagesPageView({Key? key, required this.selectedImages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[300],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[300],
        title: Text(
          'CETAK FOTO',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {},
            icon: Icon(Icons.send_and_archive),
          )
        ],
      ),
      body: Obx(
        () => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
          itemCount: selectedImages.length,
          itemBuilder: (context, index) {
            String imageUrl = selectedImages[index];
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
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.uploadFile(),
        child: Icon(Icons.add),
      ),
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
