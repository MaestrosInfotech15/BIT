import 'dart:io';

import 'package:book_indian_talents_app/components/custom_button_widget.dart';
import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/components/gallery_option_sheet_widget.dart';
import 'package:book_indian_talents_app/components/neumorphism_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/helper/helper.dart';
import 'package:book_indian_talents_app/helper/permission_helper.dart';
import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:book_indian_talents_app/model/upload_carousel.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:book_indian_talents_app/provider/file_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UpdateArtistCarouselScreen extends StatefulWidget {
  static const String id = 'update_artist_carousel_screen';

  const UpdateArtistCarouselScreen({super.key});

  @override
  State<UpdateArtistCarouselScreen> createState() =>
      _UpdateArtistCarouselScreenState();
}

class _UpdateArtistCarouselScreenState
    extends State<UpdateArtistCarouselScreen> {
  CroppedFile? croppedFile;
  String selectedFilePath = '';
  XFile? imageFile;

  List<String> carouselList = [];
  String path = 'https://ruparnatechnology.com/book_indian_talents/images/';
  bool isSubmit = false;
  bool iscarousel = false;

  void uploadImage() {
    Helper.showLoaderDialog(context, message: 'Please wait..');

    ApiHelper.uploadCarouselImage(selectedFilePath).then((value) {
      Navigator.pop(context);
      if (value.apiStatus!.toLowerCase() == 'true') {
        carouselList.add(value.image!);
        path = value.path!;
      }
      setState(() {});
    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCarouselImage();
    print(SessionManager.getUserId());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: 'Profile Images',
          textColor: Theme.of(context).primaryColorLight,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 25.0),
            //todo: Add carousel image
            iscarousel
                ? CustomLoaderWidget()
                : Visibility(
                    visible: carouselList.isNotEmpty,
                    child: NeumorphismWidget(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(carouselList.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: CachedNetworkImage(
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                      imageUrl: path + carouselList[index],
                                      placeholder: (context, url) =>
                                          const CustomLoaderWidget(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.broken_image),
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        carouselList
                                            .remove(carouselList[index]);
                                      });
                                    },
                                    child: const CustomTextWidget(
                                      text: 'Remove',
                                      textColor: Colors.red,
                                      fontSize: 12.0,
                                      textDecoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
            DottedBorder(
              borderType: BorderType.RRect,
              color: kAppColor,
              radius: const Radius.circular(10),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    //getProfileWidget(),
                    const SizedBox(height: 5),
                    const CustomTextWidget(
                        text: 'Upload Carousel Image',
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                        textColor: Colors.black),
                    TextButton(
                      onPressed: () {
                        // showModalBottomSheet(
                        //     context: context,
                        //     builder: (context) {
                        //       return const GalleryOptionSheetWidget();
                        //     });
                        captureImages('gallery');
                      },
                      child: const CustomTextWidget(
                          text: 'Browse',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          textColor: kAppColor,
                          textDecoration: TextDecoration.underline),
                    ),
                    SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: CustomTextWidget(
                          textAlign: TextAlign.start,
                          text: '*Image Less than 1MB ',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          textColor: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            isSubmit
                ? CustomLoaderWidget()
                : CustomButtonWidget(
                    radius: 25,
                    width: 150,
                    text: 'Submit',
                    btnColor: carouselList.isEmpty ? Colors.grey : kAppColor,
                    onClick: () {
                      if (carouselList.isNotEmpty) {
                        submitCarousel();
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }

  void captureImages(String type) async {
    int permission = await PermissionHelper.getStoragePermission();

    if (mounted) {
      if (permission != 3) {
        Helper.showSnackBar(
            context, 'Please allow storage permission', Colors.red);
        return;
      }
    }

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
    File image =  File(selectedFilePath);
    int sizeInBytes = image.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb > 1){
      Helper.showToastMessage('Please Select Less Than 1MB  Image', Colors.red);
      return;
    }
  uploadImage();
  }

  //todo: submit selected images
  void submitCarousel() {
    setState(() {
      isSubmit = true;
    });

    Map<String, String> body = {
      'id': SessionManager.getUserId(),
      'images': carouselList.join(',')
    };

    ApiHelper.submitCarouselImages(body).then((value) {
      setState(() {
        isSubmit = false;
      });
      if (value.apiStatus!.toLowerCase() == 'true') {
        Helper.showSnackBar(context, 'Upload successfully', Colors.green);
        Navigator.pop(context, true);
      } else {
        Helper.showSnackBar(context, 'Failed to upload image', Colors.red);
      }
    });
  }

  void getCarouselImage() {
    setState(() {
      iscarousel = true;
    });
    ApiHelper.getCarouselImages().then((value) {
      setState(() {
        iscarousel = false;
      });
      if (value.apiStatus!.toLowerCase() == 'true') {
        if (value.data!.isNotEmpty) {
          carouselList = value.data ?? [];
        }
      }
    });
  }
}
