import 'package:book_indian_talents_app/components/custom_button_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0))),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextWidget(
                        text: title,
                        textColor: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.clear, color: Colors.white))
                  ],
                )),
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: CustomTextWidget(
                text: message,
                textColor: Theme.of(context).primaryColorLight,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 15.0),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
                child: CustomButtonWidget(
                  text: btnText,
                  onClick: onClick,
                  height: 45.0,
                  radius: 8.0,
                )),
            const SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionDialogWidget extends StatelessWidget {
  const QuestionDialogWidget(
      {Key? key,
      required this.title,
      required this.message,
      required this.onClick,
      required this.btnText})
      : super(key: key);

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
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0))),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextWidget(
                        text: title,
                        textColor: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.clear, color: Colors.white))
                  ],
                )),
            const SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: CustomTextWidget(
                text: message,
                textColor: Theme.of(context).primaryColorLight,
                fontSize: 16.0,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 15.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButtonWidget(
                      text: 'No',
                      onClick: () {
                        Navigator.pop(context);
                      },
                      height: 45.0,
                      radius: 8.0,
                    ),
                  ),
                  const SizedBox(width: 25.0),
                  Expanded(
                    child: CustomButtonWidget(
                      text: btnText,
                      onClick: onClick,
                      height: 45.0,
                      radius: 8.0,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }
}

class SuccessDialogWidget extends StatelessWidget {
  const SuccessDialogWidget(
      {super.key,
      required this.title,
      required this.message,
      required this.onClick,
      required this.btnText,
      this.image = 'success.json',this.height = 150.0});

  final String title;
  final String message;
  final String btnText;
  final VoidCallback onClick;
  final String image;
  final double height;

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
            const SizedBox(height: 15.0),
            Lottie.asset('assets/lottie/$image',height:height),
            const SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: CustomTextWidget(
                text: message,

                textColor: Theme.of(context).primaryColorLight,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 15.0),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
                child: CustomButtonWidget(
                  text: btnText,
                  onClick: onClick,
                  height: 45.0,
                  radius: 8.0,
                )),
            const SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}
