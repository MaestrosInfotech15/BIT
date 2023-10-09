import 'package:book_indian_talents_app/model/upload_carousel.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:flutter/material.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../helper/constants.dart';

class FileProvider extends ChangeNotifier {
  CroppedFile? croppedFile;
  String selectedFilePath = '';
  XFile? imageFile;
  bool isFileUpload = false;

  void captureImages(String type) async {
    final ImagePicker picker = ImagePicker();
    switch (type) {
      case "gallery":

        /// GALLERY IMAGE PICKER
        imageFile = await picker.pickImage(
            source: ImageSource.gallery, imageQuality: 100);
        break;
      case "camera": // CAMERA CAPTURE CODE
        imageFile = await picker.pickImage(
            source: ImageSource.camera, imageQuality: 90);
        break;
    }

    if (imageFile != null) {
      cropImage(imageFile!.path);
    } else {
      print("You have not taken image");
    }
  }

  void cropImage(String path) async {
    croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: kAppBarColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(title: 'Cropper'),
      ],
    );
    selectedFilePath = croppedFile!.path;
    isFileUpload = true;

    notifyListeners();
  }

  void removeImage() {
    selectedFilePath = '';

    notifyListeners();
  }

  void initClear() {
    selectedFilePath = '';
  }

  //todo: Upload carousel image
  List<String> carouselList = [];
  List<String> showCarouselList = [];

  Future<void> uploadCarousel() async {
    UploadCarousel uploadCarousel =
        await ApiHelper.uploadCarouselImage(selectedFilePath);

    if (uploadCarousel.image != null) {
      carouselList.add(uploadCarousel.image!);
      showCarouselList.add(uploadCarousel.image!);
    }
    notifyListeners();
  }
}
