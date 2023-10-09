import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/components/permission_dialog_widget.dart';
import 'package:book_indian_talents_app/helper/helper.dart';
import 'package:book_indian_talents_app/helper/permission_helper.dart';
import 'package:book_indian_talents_app/provider/file_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class GalleryOptionSheetWidget extends StatefulWidget {
  const GalleryOptionSheetWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<GalleryOptionSheetWidget> createState() =>
      _GalleryOptionSheetWidgetState();
}

class _GalleryOptionSheetWidgetState extends State<GalleryOptionSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: InkWell(
              onTap: _cameraPermission,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      CupertinoIcons.camera_fill,
                      size: 35,
                    ),
                    const SizedBox(height: 5.0),
                    CustomTextWidget(
                        text: 'Camera',
                        textColor: Theme.of(context).primaryColorLight),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: _checkStoragePermission,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      CupertinoIcons.photo_fill,
                      size: 35,
                    ),
                    const SizedBox(height: 5.0),
                    CustomTextWidget(
                        text: 'Gallery',
                        textColor: Theme.of(context).primaryColorLight),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

void _checkStoragePermission() {
    PermissionHelper.getStoragePermission().then((value) {
      Navigator.pop(context);

      if (value == 2) {
        //todo: here we show dialog
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return const PermissionDialogWidget();
            });
        return;
      }

      if (value == 1) {
        Helper.showSnackBar(
            context, "Storage permission required!", Colors.red);
        return;
      }

      Provider.of<FileProvider>(context, listen: false).captureImages('gallery');
    });
  }

  void _cameraPermission() {
    PermissionHelper.getCameraPermission().then((value) {
      Navigator.pop(context);

      if (value == 2) {
        //todo: here we show dialog
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return const PermissionDialogWidget();
            });
        return;
      }

      if (value == 1) {
        Helper.showSnackBar(
            context, "Storage permission required!", Colors.red);
        return;
      }
      Provider.of<FileProvider>(context, listen: false).captureImages('camera');
    });
  }
}
