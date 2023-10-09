 import 'dart:io';

import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../components/custom_button_widget.dart';
import '../components/custom_text_field_widget.dart';
import '../components/custom_text_widget.dart';
import '../components/gallery_option_sheet_widget.dart';
import '../components/neumorphism_widget.dart';
import '../helper/constants.dart';
import '../helper/helper.dart';
import '../helper/permission_helper.dart';
import '../helper/session_manager.dart';
import '../network/api_helper.dart';
import '../provider/file_provider.dart';

class UploadBankDetailsScreen extends StatefulWidget {
  static const String id = 'upload_bank_details_screen';
  const UploadBankDetailsScreen({super.key});

  @override
  State<UploadBankDetailsScreen> createState() => _UploadBankDetailsScreenState();
}
class _UploadBankDetailsScreenState extends State<UploadBankDetailsScreen> {
  TextEditingController bankNameController = TextEditingController();
  TextEditingController ifscCodeController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController HolderNameController = TextEditingController();
  bool isAdd = false;
  String imagePath = '';
  String imageUri = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: 'Add Bank Details',
          textColor: Theme.of(context).primaryColorLight,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 30,),
            CustomTextFieldWidget(
              hintText: 'Enter Account Holder name',
              controller: HolderNameController,
              inputType: TextInputType.text,
              inputAction: TextInputAction.next,

            ),
            const SizedBox(height: 15.0),
            CustomTextFieldWidget(
              hintText: 'Enter Bank Name',
              controller: bankNameController,
              inputType: TextInputType.text,
              inputAction: TextInputAction.next,

            ),
            const SizedBox(height: 15.0),
            CustomTextFieldWidget(
              hintText: 'Enter Account Number',
              controller: accountNumberController,
              inputType: TextInputType.text,
              inputAction: TextInputAction.done,

            ),
            const SizedBox(height: 15.0),
            CustomTextFieldWidget(
              hintText: 'Enter IFSC Code',
              controller:ifscCodeController,
              inputType: TextInputType.text,
              inputAction: TextInputAction.done,

            ),
            const SizedBox(height: 15.0),
            CustomTextFieldWidget(
              hintText: 'Enter Branch Address',
              controller: contactController,
              inputType: TextInputType.text,
              inputAction: TextInputAction.done,

            ),
            const SizedBox(height: 25.0),
            //todo: Add carousel image
            // DottedBorder(
            //   borderType: BorderType.RRect,
            //   color: kAppColor,
            //   radius: const Radius.circular(10),
            //   child: Container(
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //       color: Colors.red.shade50,
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: Column(
            //       children: [
            //         const SizedBox(height: 10),
            //         getProfileWidget(),
            //        // const SizedBox(height: 5),
            //         // const CustomTextWidget(
            //         //     text: 'Upload your Profile Image',
            //         //     fontWeight: FontWeight.w700,
            //         //     fontSize: 14.0,
            //         //     textColor: Colors.black),
            //         // TextButton(
            //         //   onPressed: () {
            //         //     showModalBottomSheet(
            //         //         context: context,
            //         //         builder: (context) {
            //         //           return const GalleryOptionSheetWidget();
            //         //         });
            //         //   },
            //         //   child: const CustomTextWidget(
            //         //       text: 'Browse',
            //         //       fontSize: 14,
            //         //       fontWeight: FontWeight.w600,
            //         //       textColor: kAppColor,
            //         //       textDecoration: TextDecoration.underline),
            //         // ),
            //         const SizedBox(
            //           height: 10,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(height: 20),
               isAdd?CustomLoaderWidget():
               CustomButtonWidget(
              radius: 25,
              width: 150,
              text: 'Submit',
              btnColor: kAppColor,
              onClick: () {
                addBank();
              },
            ),
          ],
        ),
      ),

    );
  }

  Widget getProfileWidget() {
    final data = Provider.of<FileProvider>(context);

    if (data.selectedFilePath.isNotEmpty) {
      imagePath = '';
    }

    if (imagePath.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
            height: 75.0, width: 75.0, fit: BoxFit.cover, imageUri + imagePath),
      );
    }
    // if (data.selectedFilePath.isEmpty) {
    //   return const Icon(Icons.drive_folder_upload, color: kAppColor, size: 35);
    // }

    // if (data.isFileUpload) {
    //   return const CircularProgressIndicator();
    // }
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.file(
        File(data.selectedFilePath),
        height: 75.0,
        width: 75.0,
        fit: BoxFit.cover,
      ),
    );
  }

  void addBank() {
    final data = Provider.of<FileProvider>(context, listen: false);
    String accountholder = HolderNameController.text.trim();
    String bank_name = bankNameController.text.trim();
    String ac_no = accountNumberController.text.trim();
    String ifsc_code = ifscCodeController.text.trim();
    String contact = contactController.text.trim();
    if (accountholder.isEmpty) {
      Helper.showToastMessage( 'Enter Account Holder Name', Colors.red);
      return;
    }
    if (bank_name.isEmpty) {
      Helper.showToastMessage( 'Enter Bank Name ', Colors.red);
      return;
    }
    if (ac_no.isEmpty) {
      Helper.showToastMessage( 'Enter Account Number ', Colors.red);
      return;
    }
    if (ifsc_code.isEmpty) {
      Helper.showToastMessage( 'Enter IFSC Code  ', Colors.red);
      return;
    }

    if (contact.isEmpty) {
      Helper.showToastMessage( 'Enter Branch Address  ', Colors.red);
      return;
    }
    Map<String, String> body = {
      'artist_id': SessionManager.getUserId(),
      'accountholder': accountholder,
      'bank_name': bank_name,
      'account': ac_no,
      'ifsc': ifsc_code,
      'branchaddress': contact,




    };
    print(body);
    setState(() {
      isAdd = true;
    });
    ApiHelper.add_bankdetails(body,data.selectedFilePath).then((value) {
      setState(() {
        isAdd = false;
      });

      if (value.apiStatus!.toLowerCase() == 'true') {
        Helper.showSnackBar(context, 'Add  Successfully', Colors.green);
        Navigator.pop(context,true);
      } else {
        Helper.showSnackBar(context, 'Failed to add ', Colors.red);
      }
    });
  }


}



