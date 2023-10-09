import 'dart:io';
import 'dart:typed_data';
import 'package:book_indian_talents_app/components/custom_button_widget.dart';
import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/helper/helper.dart';
import 'package:book_indian_talents_app/helper/permission_helper.dart';
import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

import '../components/permission_dialog_widget.dart';

class AddEventBottomSheet extends StatefulWidget {
  const AddEventBottomSheet({super.key});

  @override
  State<AddEventBottomSheet> createState() => _AddEventBottomSheetState();
}

class _AddEventBottomSheetState extends State<AddEventBottomSheet> {
  FilePickerResult? result;
  PlatformFile? file;
  CroppedFile? croppedFile;
  String selectedFilePath = '';
  String? selectedFileType;
  XFile? imageFile;
  String fileType = '';

  bool isAdd = false;

  Uint8List? videoPath;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15.0),
              color: kAppColor,
              child: Row(
                children: [
                  const Expanded(
                    child: CustomTextWidget(
                      text: 'Add Event Photos/Videos',
                      textColor: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.cancel_outlined,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 25.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Visibility(
                    visible: fileType == 'image',
                    child: Visibility(
                      visible: selectedFilePath.isNotEmpty,
                      child: Image.file(
                        File(selectedFilePath),
                        width: 150.0,
                        height: 150.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Visibility(
                      visible: fileType == 'video',
                      child: Visibility(
                        visible: selectedFilePath.isNotEmpty,
                        child: FutureBuilder<Uint8List>(
                          future: Helper.generateThumbnail(selectedFilePath),
                          builder: (context, response) {
                            if (response.connectionState ==
                                ConnectionState.waiting) {
                              return CustomLoaderWidget();
                            }
                            return Image.memory(
                              response.data ?? Uint8List(0),
                              width: 150.0,
                              height: 150.0,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      )),
                  const SizedBox(height: 25.0),
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
                          const CustomTextWidget(
                              text: 'Upload Event Photos/Videos',
                              fontWeight: FontWeight.w700,
                              fontSize: 14.0,
                              textColor: Colors.black),
                          TextButton(
                            onPressed: () {
                              selectFile('Photo');

                              // showDialog(
                              //   context: context,
                              //   builder: (context) {
                              //     return CamraDialogWidget(
                              //       title: 'Select Media',
                              //       message: '',
                              //       btnText: 'Photo',
                              //       onClick: () {
                              //         Navigator.pop(context);
                              //         selectFile('Photo');
                              //       },
                              //       onClick1: () {
                              //         Navigator.pop(context);
                              //         selectFile('Video');
                              //       },
                              //       btnText1: 'Video',
                              //     );
                              //   },
                              // );
                            },
                            child: const CustomTextWidget(
                                text: 'Browse',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                textColor: kAppColor,
                                textDecoration: TextDecoration.underline),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: CustomTextWidget(
                                textAlign: TextAlign.start,
                                text:
                                    '*Image Less than 1MB \n*Video Less than 10MB',
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
                  const SizedBox(height: 20.0),
                  isAdd
                      ? const CustomLoaderWidget()
                      : CustomButtonWidget(
                          radius: 25,
                          width: 150,
                          text: 'Upload',
                          btnColor: selectedFilePath.isEmpty
                              ? Colors.grey
                              : kAppColor,
                          onClick: () {
                            if (selectedFilePath.isNotEmpty) {
                              addEvent();
                            }
                          },
                        ),
                  const SizedBox(height: 20.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void selectFile(String type) async {
    int permission = await PermissionHelper.getStoragePermission();

    if (mounted) {
      if (permission != 3) {
        Helper.showSnackBar(
            context, 'Please allow storage permission', Colors.red);
        return;
      }
    }
    List<String> ext = [];
    if (type == 'Photo') {
      ext = ['jpg', 'png'];
    } else {
      ext = ['mp4'];
    }
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ext = ['jpg', 'png','mp4'],
    );
    if (result == null) return;
    file = result!.files.single;

    setState(() {
      // fileType = file!.path!.contains('mp4') ? 'video' : 'image';
      if (file!.extension! == 'jpg' || file!.extension! == 'png') {
        cropImage(file!.path!);
        fileType = "image";
      } else {
        fileType = "video";
        // selectedFilePath = file!.path!;

        File image = File(file!.path!);
        int sizeInBytes = image.lengthSync();
        double sizeInMb = sizeInBytes / (1024 * 1024);
        if (sizeInMb > 10) {
          Helper.showToastMessage(
              'Please Select Less Than 10MB  video', Colors.red);
          return;
        }
        comprees(file!.path!);
      }
    });
  }

  void comprees(String videoPath) async {
    Helper.showLoaderDialog(context, message: 'Please wait');

    MediaInfo? mediaInfo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.DefaultQuality,
      deleteOrigin: false, // It's false by default
    );
    Navigator.pop(context);
    print(mediaInfo!.path);
    selectedFilePath = mediaInfo!.path!;
    setState(() {});
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
            toolbarTitle: 'Book Indian Talent',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(title: 'Book Indian Talent'),
      ],
    );
    selectedFilePath = croppedFile!.path;
    File image = File(selectedFilePath);
    int sizeInBytes = image.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb > 1) {
      Helper.showToastMessage('Please Select Less Than 1MB  Image', Colors.red);
      return;
    }
    setState(() {
      selectedFilePath = croppedFile!.path;
    });
  }

  void addEvent() {
    File image = File(selectedFilePath);
    int sizeInBytes = image.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb > 10) {
      Helper.showToastMessage(
          'Please Select Less Than 10MB  video', Colors.red);
      return;
    }
    setState(() {
      isAdd = true;
    });
    Map<String, String> body = {
      'id': SessionManager.getUserId(),
      'content_type': fileType
    };

    ApiHelper.addEventImageVideos(body, selectedFilePath).then((value) {
      setState(() {
        isAdd = false;
      });
      if (value.apiStatus!.toLowerCase() == 'true') {
        Helper.showSnackBar(context, 'Success', Colors.green);
        Navigator.pop(context, true);
      } else {
        Helper.showSnackBar(context, 'Failed', Colors.red);
      }
    });
  }
}
