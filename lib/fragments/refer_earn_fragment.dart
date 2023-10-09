import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/model/refer_code.dart';
import 'package:book_indian_talents_app/model/top_rated.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../components/custom_loader_widget.dart';
import '../helper/helper.dart';
import '../network/api_helper.dart';

class ReferEarnFragment extends StatefulWidget {
  const ReferEarnFragment({super.key});
  @override
  State<ReferEarnFragment> createState() => _ReferEarnFragmentState();
}

class _ReferEarnFragmentState extends State<ReferEarnFragment> {
  late Future<ReferCode> refercodefuture;

  Future<ReferCode> getrefer() async {
    return ApiHelper.getRefer();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refercodefuture = getrefer();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: 'Refer',
          textColor: Theme.of(context).hintColor,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      body:FutureBuilder<ReferCode>(
          future: refercodefuture,
          builder: (context,response){
            if (response.connectionState ==
                ConnectionState.waiting) {
              return const CustomLoaderWidget();
            }
            if (response.data!.apiStatus!.toLowerCase() ==
                'false') {
              return const Center(
                child: CustomTextWidget(
                    text: 'No Order Found', textColor: Colors.red),
              );
            }
           ReferCodeData referCodeData=response.data!.data!;
            return  SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25.0,
              ),
              Image(
                image: AssetImage('assets/images/refer_icon.png'),
                height: 150,
                width: double.infinity,
              ),
              SizedBox(
                height: 45.0,
              ),
              CustomTextWidget(
                text: 'Your Refeeral Code',
                textColor: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 20.0,
              ),
              InkWell(
                onTap: (){
                  final String textToCopy = referCodeData.referCode??''; // Replace with your desired text
                  Clipboard.setData(ClipboardData(text: textToCopy));
                  Helper.showToastMessage('Copy', Colors.green);
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  color: kAppBarColor,
                  radius: Radius.circular(1),
                  padding: EdgeInsets.all(6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTextWidget(
                              text:referCodeData.referCode??'',
                              textColor: Colors.grey,
                              fontSize: 16),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.copy, size: 15, color: Colors.grey),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextWidget(
                text: 'Tap to copy',
                textColor: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 50,
              ),
              TextButton.icon(
                onPressed: () {
                    Share.share('check out my Refer Code ${referCodeData.referCode} https://.com');
                },
                icon: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
                label:
                CustomTextWidget(text: 'Share Now', textColor: Colors.white),
                style: TextButton.styleFrom(
                  backgroundColor: kAppBarColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextButton(
                onPressed: () {},
                child: CustomTextWidget(
                    text: 'T&C Apply',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    textColor: Colors.grey.shade600,
                    textDecoration: TextDecoration.underline),
              ),
            ],
          ),
        );
      })
    );
  }

}
