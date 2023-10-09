import 'package:book_indian_talents_app/components/neumorphism_widget.dart';
import 'package:book_indian_talents_app/helper/helper.dart';
import 'package:book_indian_talents_app/model/bank_details.dart';
import 'package:book_indian_talents_app/model/show_addplan.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/custom_text_widget.dart';
import '../helper/constants.dart';

class ShowBankDetailsWidget extends StatefulWidget {
  const ShowBankDetailsWidget({
    super.key,required this.showBankDetails,
    required this.onTap,
  });
  final BankDetailsData showBankDetails;
  final VoidCallback  onTap;

  @override
  State<ShowBankDetailsWidget> createState() => _ShowPlanWidgetState();
}
class _ShowPlanWidgetState extends State<ShowBankDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: NeumorphismWidget(
        padding: EdgeInsets.all(5),
        child: Container(
          padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.only(left: 1, right: 1, ),
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
                      text: 'Account Holder : ${widget.showBankDetails.accountholder!}',
                      textColor: Colors.black,
                      fontSize: 12,
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
                text:'Bank Name : ${widget.showBankDetails.bankName!}',
                textColor: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              CustomTextWidget(
                text: 'Account No : ${widget.showBankDetails.acNo!}',
                textColor: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              )       ,


              CustomTextWidget(
                text: 'IFSC Code    : ${widget.showBankDetails.ifscCode!}',
                textColor: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              CustomTextWidget(
                text:'Branch Address : ${widget.showBankDetails.branchaddress!}',
                textColor: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }

}