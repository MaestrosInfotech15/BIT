import 'package:flutter/material.dart';

import '../components/custom_button_widget.dart';
import '../components/custom_text_field_widget.dart';
import '../components/custom_text_widget.dart';
import '../helper/constants.dart';
import '../helper/size_config.dart';

class WalletWidget extends StatefulWidget {
  const WalletWidget({super.key});

  @override
  State<WalletWidget> createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 18),
      elevation: 0.0,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey.shade200),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: SizeConfig.width(),
                padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                decoration: BoxDecoration(color: kAppColor.withOpacity(0.2)),
                child: CustomTextWidget(
                  text: ' Add Wallet ',
                  textAlign: TextAlign.center,
                  textColor: Theme.of(context).primaryColorLight,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFieldWidget(
                      hintText: 'Enter Amount',
                      controller: TextEditingController(),
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      prefixIcon: Icons.abc,
                    ),
                    const SizedBox(height: 15.0),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Center(
                child:CustomButtonWidget(
                  radius: 25,
                  width: 150,
                  text: 'Save',
                  onClick: () {
                  },
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
