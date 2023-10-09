import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/helper/helper.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/custom_button_widget.dart';
import '../components/custom_text_field_widget.dart';
import '../components/custom_text_widget.dart';
import '../helper/constants.dart';
import '../helper/session_manager.dart';
import '../helper/size_config.dart';

class AddPlanDialogWidget extends StatefulWidget {
  const AddPlanDialogWidget({super.key});

  @override
  State<AddPlanDialogWidget> createState() => _AddPlanDialogWidgetState();
}

class _AddPlanDialogWidgetState extends State<AddPlanDialogWidget> {
  TextEditingController planController = TextEditingController();
  TextEditingController AmountController = TextEditingController();
  TextEditingController DescriptionController = TextEditingController();
  bool isAdd = false;

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
                  text: 'Add Service',
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
                      hintText: 'Enter Service Name',
                      controller: planController,
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.next,

                    ),
                    const SizedBox(height: 15.0),
                    CustomTextFieldWidget(
                      hintText: 'Enter Service Charges',
                      controller: AmountController,
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.done,
                      prefixIcon: Icons.currency_rupee,
                    ),
                    const SizedBox(height: 15.0),
                    DescriptionTextField(
                        hintText: 'Enter Description ',
                        controller: DescriptionController,
                        inputType: TextInputType.multiline,
                        inputAction: TextInputAction.newline,
                        prefixIcon: Icons.email_outlined),
                    const SizedBox(height: 25.0),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Center(
                child:isAdd? CustomLoaderWidget():CustomButtonWidget(
                  radius: 25,
                  width: 150,
                  text: 'Save',
                  onClick: () {
                    addPlan();
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

  void addPlan() {
    String plan = planController.text.trim();
    String amount = AmountController.text.trim();
    String Description = DescriptionController.text.trim();
    if (plan.isEmpty) {
      Helper.showToastMessage( 'Enter Plan Name', Colors.red);
      return;
    }
    if (amount.isEmpty) {
      Helper.showToastMessage( 'Enter plan Amount', Colors.red);
      return;
    }
    if (Description.isEmpty) {
      Helper.showToastMessage( 'Enter Description ', Colors.red);
      return;
    }
    Map<String, dynamic> body = {
      'id': SessionManager.getUserId(),
      'plan_name': plan,
      'details': Description,
      'amount': amount,
    };
    setState(() {
      isAdd = true;
    });
    ApiHelper.addPlan(body).then((value) {
      setState(() {
        isAdd = false;
      });
      if (value.apiStatus!.toLowerCase() == 'true') {
        Helper.showSnackBar(context, 'Plan Added Successfully', Colors.green);
        Navigator.pop(context,true);
      } else {
        Helper.showSnackBar(context, 'Failed to add ', Colors.red);
      }
    });
  }
}
