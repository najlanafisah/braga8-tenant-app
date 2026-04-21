import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage({bool fromGallery = true}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      } else {
        print("Debug: User menutup picker tanpa memilih file.");
      }
    } catch (e) {
      // INI YANG PENTING: melihat error teknisnya
      print("Debug: Terjadi error saat pickImage: $e");
    }
    return null;
  }
}
