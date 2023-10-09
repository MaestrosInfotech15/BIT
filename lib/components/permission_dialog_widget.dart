import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'custom_button_widget.dart';
import 'custom_text_widget.dart';

class PermissionDialogWidget extends StatelessWidget {
  const PermissionDialogWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Theme.of(context).scaffoldBackgroundColor),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 30.0,
              ),
              const Icon(
                Icons.cancel,
                size: 50.0,
                color: Colors.red,
              ),
              const SizedBox(
                height: 15.0,
              ),
              const CustomTextWidget(
                text: 'Permission Required.',
                textColor: Colors.black,
                fontSize: 16.0,
              ),
              const SizedBox(
                height: 15.0,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 8.0),
                  child: CustomButtonWidget(
                    text: 'Goto Settings',
                    onClick: () {
                      Navigator.pop(context);
                      openAppSettings();
                    },
                    height: 45.0,
                    radius: 5.0,
                  )),
              const SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ));
  }
}

class SimpleDialogWidget extends StatelessWidget {
  const SimpleDialogWidget(
      {Key? key,
      required this.title,
      required this.message,
      required this.onClick,
      required this.btnText})
      : super(key: key);

  //
  final String title;
  final String message;
  final String btnText;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Theme.of(context).scaffoldBackgroundColor),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: double.infinity,
                  decoration:  BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                  child:
                      CustomTextWidget(text: title, textColor: Colors.white)),
              const SizedBox(
                height: 15.0,
              ),
              CustomTextWidget(
                text: message,
                textColor: Colors.black,
                fontSize: 16.0,
              ),
              const SizedBox(
                height: 15.0,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 8.0),
                  child: CustomButtonWidget(
                    text: btnText,
                    onClick: onClick,
                    height: 45.0,
                    btnColor: Colors.white,
                  )),
              const SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ));
  }
}

//CustomButtonTwoWidget(
//                     radius: 10.0,
//                     text: 'Go to settings',
//                     height: 45.0,
//                     onClick: () {
//                       Navigator.pop(context);
//                       openAppSettings();
//                     },
//                     btnColor: kAppColor),
class CamraDialogWidget extends StatelessWidget {
  const CamraDialogWidget(
      {Key? key,
        required this.title,
        required this.message,
        required this.btnText,
        required this.onClick,
        required this.onClick1,
        required this.btnText1})
      : super(key: key);

  //
  final String title;
  final String message;
  final String btnText;
  final String btnText1;
  final VoidCallback onClick;
  final VoidCallback onClick1;
  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Theme.of(context).scaffoldBackgroundColor),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: double.infinity,
                  decoration:  BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0))),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                  child:
                  CustomTextWidget(text: title, textColor: Colors.white)),
              const SizedBox(
                height: 15.0,
              ),
              CustomTextWidget(
                text: message,
                textColor: Colors.black,
                fontSize: 16.0,
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 8.0),
                      child: CustomButtonWidget(
                        text: btnText,
                        onClick: onClick,
                        height: 45.0,
                        btnColor: Colors.white,
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 8.0),
                      child: CustomButtonWidget(
                        text: btnText1,
                        onClick: onClick1,
                        height: 45.0,
                        btnColor: Colors.white,
                      )),
                ],
              ),

              const SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ));
  }
}