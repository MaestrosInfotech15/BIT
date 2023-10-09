import 'package:book_indian_talents_app/screens/upload_bank_details_screen.dart';
import 'package:flutter/material.dart';

import '../components/custom_button_widget.dart';
import '../components/custom_loader_widget.dart';
import '../components/custom_text_widget.dart';
import '../helper/constants.dart';
import '../helper/helper.dart';
import '../model/bank_details.dart';
import '../network/api_helper.dart';
import '../widgets/show_bank_details_widget.dart';

class ArtistBankDetailsScreen extends StatefulWidget {
  static const String id = 'artist_bank_details_screen';
  const ArtistBankDetailsScreen({super.key});

  @override
  State<ArtistBankDetailsScreen> createState() => _ArtistBankDetailsState();
}

class _ArtistBankDetailsState extends State<ArtistBankDetailsScreen> {
  late Future<BankDetails> bankdetailsfuture;

  Future<BankDetails> viewBankDetails() async {
    return ApiHelper.getbankDetails();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bankdetailsfuture = viewBankDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: 'Bank Details',
          textColor: Colors.black,
          fontWeight: FontWeight.w700,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CustomButtonWidget(text: 'Add Bank Details',
              textColor: Colors.white,
              width: 100,
              height: 30,
              radius:20,
              fontSize: 12,
              onClick: () {
                Navigator.pushNamed(
                    context, UploadBankDetailsScreen.id)
                    .then((value) {
                  if (value != null) {
                    if (value == true) {
                      setState(() {
                        bankdetailsfuture = viewBankDetails();
                      });
                    }
                  }
                });
              },),
          ),

        ],
      ),
      body:  FutureBuilder<BankDetails>(
          future: bankdetailsfuture,
          builder: (context, response) {
            if (response.connectionState ==
                ConnectionState.waiting) {
              return const CustomLoaderWidget();
            }
            if (response.data!.apiStatus!.toLowerCase() ==
                'false') {
              return const Center(
                child: CustomTextWidget(
                    text: 'No Bank Details', textColor: Colors.red),
              );
            }
            List<BankDetailsData> showbanklist =
            response.data!.data!;
            if (showbanklist.isEmpty) {
              return const Center(
                child: CustomTextWidget(
                    text: 'No Bank Details', textColor: Colors.red),
              );
            }

            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ShowBankDetailsWidget(
                  showBankDetails: showbanklist[index],
                  onTap: () {
                    deleteBank(showbanklist[index].id!);
                  },
                );
              },
              shrinkWrap: true,
              itemCount: showbanklist.length,
            );
          }),
    );
  }
  void deleteBank(String id) {
    Helper.showLoaderDialog(context, message: 'deleting.......');
    Map<String, String> body = {
      'bank_id': id,
    };
    ApiHelper.deleteBankdetails(body).then((value) {
      Navigator.pop(context);
      if (value.apiStatus!.toLowerCase() == 'true') {
        Helper.showToastMessage('Successfully Delete', Colors.green);
        setState(() {
          bankdetailsfuture = viewBankDetails();
        });
      } else {
        Helper.showToastMessage(value.result!, Colors.red);
      }
    });
  }
}
