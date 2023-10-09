import 'package:book_indian_talents_app/components/custom_button_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_field_widget.dart';
import 'package:book_indian_talents_app/helper/helper.dart';
import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:book_indian_talents_app/helper/size_config.dart';
import 'package:book_indian_talents_app/model/total_wallet.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:flutter/material.dart';

import '../components/custom_loader_widget.dart';
import '../components/custom_text_widget.dart';
import '../components/neumorphism_widget.dart';
import '../helper/constants.dart';
import '../model/artist_wallet.dart';

class ArtistWalletScreen extends StatefulWidget {
  static const String id = 'artist_wallet_screen';

  const ArtistWalletScreen({super.key});

  @override
  State<ArtistWalletScreen> createState() => _ArtistWalletScreenState();
}

class _ArtistWalletScreenState extends State<ArtistWalletScreen> {
  late Future<TotalWallet> walletfuture;
  late Future<ArtistWallet> artistfuture;
  String amount = '';

  Future<TotalWallet> totalamount() async {
    return ApiHelper.totalamount();
  }

  Future<ArtistWallet> getArtistWallet() {
    return ApiHelper.getArtisrwallet();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    walletfuture = totalamount();
    artistfuture = getArtistWallet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: kAppBarColor,
          title: CustomTextWidget(
            text: 'Artist Wallet',
            textColor: Theme.of(context).primaryColorLight,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
          actions: [
            CustomButtonWidget(
              text: 'Withdraw',
              onClick: () {
                showDialog(
                    context: context,
                    builder: (context) => WithdrawMoneyDialog(amount: amount,)).then(
                  (value) {
                    setState(() {
                      walletfuture = totalamount();
                      artistfuture = getArtistWallet();
                    });
                  },
                );
              },
              btnColor: Colors.green,
              radius: 25.0,
              width: 120.0,
              height: 40,
            ),
            const SizedBox(width: 20.0),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NeumorphismWidget(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(
                      children: [
                        const Expanded(
                          child: CustomTextWidget(
                            text: 'Total Balance',
                            textColor: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(width: 10),
                        FutureBuilder<TotalWallet>(
                          future: walletfuture,
                          builder: (context, response) {
                            if (response.connectionState ==
                                ConnectionState.waiting) {
                              return CustomLoaderWidget();
                            }
                            if (response.data!.apiStatus!.toLowerCase() ==
                                'false') {
                              return Center(
                                child: CustomTextWidget(
                                    text:'0',
                                    textColor: Colors.red),
                              );
                            }
                            amount = response.data!.totalAmount??'0';
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 10),
                              decoration: const BoxDecoration(
                                  color: kAppColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: CustomTextWidget(
                                text: '₹${response.data!.totalAmount ?? 0}',
                                textColor: Colors.white,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w700,
                                fontSize: 18.0,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const CustomTextWidget(
                    text: 'History',
                    textColor: Colors.black,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
            Expanded(
                child: FutureBuilder<ArtistWallet>(
                    future: artistfuture,
                    builder: (context, response) {
                      if (response.connectionState == ConnectionState.waiting) {
                        return CustomLoaderWidget();
                      }
                      if (response.data!.apiStatus!.toLowerCase() == 'false') {
                        return Center(
                          child: CustomTextWidget(
                              text: 'No History Found', textColor: Colors.red),
                        );
                      }
                      List<ArtistWalletData> artistlist = response.data!.data!;
                      return ListView.builder(
                        itemCount: artistlist.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return WalletWidget(
                            artistWalletData: artistlist[index],
                          );
                        },
                      );
                    }))
          ],
        ));
  }
}

class WalletWidget extends StatefulWidget {
  const WalletWidget({super.key, required this.artistWalletData});

  final ArtistWalletData artistWalletData;

  @override
  State<WalletWidget> createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: NeumorphismWidget(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextWidget(
                    text: 'TXN id: ${DateTime.now().millisecondsSinceEpoch}',
                    textColor: Colors.black,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(width: 10),
                CustomTextWidget(
                  text: '₹${widget.artistWalletData.amount}',
                  textColor: Colors.red,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                ),
              ],
            ),
            CustomTextWidget(
              text: widget.artistWalletData.dates!,
              textColor: Colors.black54,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            ),

            CustomTextWidget(
              text: widget.artistWalletData.contact??'',
              textColor: Colors.black54,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            ),
          ],
        ),
      ),
    );
  }
}

class WithdrawMoneyDialog extends StatefulWidget {
  const WithdrawMoneyDialog({
    super.key,required this.amount
  });

  final String amount ;
  @override
  State<WithdrawMoneyDialog> createState() => _WithdrawMoneyDialogState();
}


class _WithdrawMoneyDialogState extends State<WithdrawMoneyDialog> {
  TextEditingController AmountController = TextEditingController();
  bool isWallet = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey.shade200),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: SizeConfig.width(),
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              decoration: BoxDecoration(color: kAppColor.withOpacity(0.2)),
              child: CustomTextWidget(
                text: 'Withdraw Money',
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
                   CustomTextWidget(
                      text: 'Current Balance: ${widget.amount}',
                      textColor: kAppColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0),
                  const SizedBox(height: 15.0),
                  CustomTextFieldWidget(
                    hintText: 'Enter Amount',
                    controller: AmountController,
                    inputType: TextInputType.number,
                    inputAction: TextInputAction.done,
                    prefixIcon: Icons.currency_rupee_rounded,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: isWallet
                  ? CustomLoaderWidget()
                  : CustomButtonWidget(
                      radius: 25,
                      width: 150,
                      text: 'Send Request',
                      onClick: () {
                        walletWithdraw();
                      },
                    ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  void walletWithdraw() {
    String amount = AmountController.text.trim();
    if (amount.isEmpty) {
      Helper.showToastMessage('Enter Amount', Colors.red);
      return;
    }
    Map<String, String> body = {
      'artist_id': SessionManager.getUserId(),
      'amount': amount,
    };
    setState(() {
      isWallet = true;
    });
    ApiHelper.walletWithDraw(body).then((value) {
      Navigator.pop(context);
      if (value.apiStatus!.toLowerCase() == 'true') {
        Helper.showToastMessage(
            'Your Request has Been Submitted', Colors.green);
        setState(() {});
      } else {
        Helper.showToastMessage('filed to Request', Colors.red);
      }
    });
  }
}
