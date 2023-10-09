import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:book_indian_talents_app/widgets/wallet_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../components/custom_button_widget.dart';
import '../components/custom_text_widget.dart';
import '../components/neumorphism_widget.dart';
import '../helper/constants.dart';
import '../helper/session_manager.dart';
import '../model/wallet.dart';
class WalletScreen extends StatefulWidget {
  static const String id = 'wallet_screen';
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  late Future<Wallet>walletfuture;

  Future<Wallet>getWallet()async{
    return ApiHelper.getWallet();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    walletfuture = getWallet();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: 'Refer & Earn History',
          textColor: Theme.of(context).primaryColorLight,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
        // actions: [
        //   Container(
        //     margin: EdgeInsets.only(right: 10),
        //     child: CustomButtonWidget(
        //       text: 'Add',
        //       onClick: () {
        //         showDialog(
        //             context: context,
        //             builder: (context) =>
        //             const WalletWidget());
        //       },
        //       width: 70,
        //       height: 35,
        //       fontSize: 14,
        //       btnColor: kAppColor,
        //       textColor: Colors.white,
        //       radius: 20,
        //     ),
        //   )
        // ],
      ),
      body: FutureBuilder<Wallet>(
        future: walletfuture,
        builder: (context,response){
          if(response.connectionState==ConnectionState.waiting){
            return CustomLoaderWidget();
          }
          if(response.data!.apiStatus!.toLowerCase()=='false'){
            return Center(
              child: CustomTextWidget(text: 'No History  found', textColor: Colors.red),
            );
          }
          List<WalletData>walletlist=response.data!.data!;
          if(walletlist.isEmpty){
            return Center(child: CustomTextWidget(text: 'No History Found', textColor: Colors.red));
          }
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20,left: 30,right: 30),
                child: NeumorphismWidget(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.wallet,
                          size: 25,
                          color: Colors.red,
                        ),
                        SizedBox(width: 10,),
                        CustomTextWidget(
                          text:'₹${response.data!.wallet!}',
                          textColor: kAppColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Divider(),
              Expanded(
                child: ListView.builder(itemBuilder: (context,index){
                  return  Container(
                    margin: EdgeInsets.only(top: 10,bottom: 10),
                    padding: const EdgeInsets.only(left: 30,right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NeumorphismWidget(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: kAppColor,
                                    shape: BoxShape.circle
                                ),
                                padding: EdgeInsets.all(5),
                                child:  Icon(
                                  Icons.person,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextWidget(
                                      text: 'TEX - ${walletlist[index]}',
                                      textColor: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    SizedBox(height: 4),
                                    CustomTextWidget(
                                      text: 'Date Time - ${walletlist[index].date}',
                                      textColor: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ],
                                ),
                              ),
                              CustomTextWidget(
                                text:'₹${walletlist[index].amt}',
                                textColor: kAppColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: walletlist.length,
                shrinkWrap: true),
              ),
            ],
          );
        }
      )
    );
  }
}
