import 'package:book_indian_talents_app/components/neumorphism_widget.dart';
import 'package:book_indian_talents_app/components/new_user_widget.dart';
import 'package:book_indian_talents_app/helper/helper.dart';
import 'package:book_indian_talents_app/model/show_addplan.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:book_indian_talents_app/screens/show_artist_plan_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/custom_button_widget.dart';
import '../components/custom_loader_widget.dart';
import '../components/custom_text_field_widget.dart';
import '../components/custom_text_widget.dart';
import '../helper/constants.dart';
import '../helper/session_manager.dart';
import '../helper/size_config.dart';

class ShowPlanWidget extends StatefulWidget {
  const ShowPlanWidget({
    super.key,required this.showPlanData,
    required this.onTap,
  });
  final ShowPlanData showPlanData;
  final VoidCallback  onTap;

  @override
  State<ShowPlanWidget> createState() => _ShowPlanWidgetState();
}
class _ShowPlanWidgetState extends State<ShowPlanWidget> {





  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: NeumorphismWidget(
        padding: EdgeInsets.all(5),
        child: Container(
          padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.only(left: 2, right: 2, ),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextWidget(
                      text: widget.showPlanData.name!,
                      textColor: kAppColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap:widget.onTap,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
              CustomTextWidget(
                text: widget.showPlanData.details!,
                textColor: Colors.black,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextWidget(
                        text: '₹${widget.showPlanData.amount}',
                        textColor: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    InkWell(
                      onTap:() {

                        showDialog(
                            context: context,
                            builder: (context) =>
                             UpdateArtistPlanWidget(showPlanData: widget.showPlanData,));
                      },
                      child: const Icon(
                        Icons.edit_calendar_outlined,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}

class UpdateArtistPlanWidget extends StatefulWidget {
  const UpdateArtistPlanWidget({super.key,required this.showPlanData});
  final ShowPlanData showPlanData;
  @override
  State<UpdateArtistPlanWidget> createState() => _AddPlanDialogWidgetState();
}

class _AddPlanDialogWidgetState extends State<UpdateArtistPlanWidget> {
  TextEditingController planController = TextEditingController();
  TextEditingController AmountController = TextEditingController();
  TextEditingController DescriptionController = TextEditingController();
  bool isAdd = false;

  @override
  void initState() {
    super.initState();
    getPlanData();
  }

  void getPlanData() {
    ShowPlanData showPlanData = widget.showPlanData!;
    planController.text = showPlanData.name ?? '';
    AmountController.text = showPlanData. amount?? '';
    DescriptionController.text = showPlanData.details ?? '';

  }

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
                    //UpdatePlan();
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

  void UpdatePlan() {
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
      'plan_id': widget.showPlanData.id!,
      'name': plan,
      'details': Description,
      'amount': amount,
    };
    setState(() {
      isAdd = true;
    });
    ApiHelper.updateArtistPlans(body).then((value) {
      setState(() {
        isAdd = false;
      });
      if (value.apiStatus!.toLowerCase() == 'true') {
        Helper.showSnackBar(context, 'Plan Update Successfully', Colors.green);
        Navigator.pop(context, true);
      } else {
        Helper.showSnackBar(context, 'Failed to Update ', Colors.red);
      }
    });
  }
}