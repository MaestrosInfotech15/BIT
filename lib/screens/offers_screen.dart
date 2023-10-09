import 'package:book_indian_talents_app/components/custom_button_widget.dart';
import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_field_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/components/neumorphism_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/helper/helper.dart';
import 'package:book_indian_talents_app/model/offers.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';

class OffersScreen extends StatefulWidget {
  static const String id = 'offers_screen';

  const OffersScreen({super.key, required this.planId});

  final String planId;

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  final TextEditingController _offerController = TextEditingController();
  late Future<Offers> offerFuture;

  String offerId = '';

  Future<Offers> getOffer() async {
    return ApiHelper.showOffers();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    offerFuture = getOffer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: 'Offers',
          textColor: Theme.of(context).hintColor,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: NeumorphismWidget(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                    text: 'Enter Refer Code',
                    textColor: Theme.of(context).primaryColorLight,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: CustomTextFieldWidget(
                        hintText: 'Enter Code',
                        controller: _offerController,
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.done,
                      )),
                      const SizedBox(width: 10.0),
                      CustomButtonWidget(
                        text: 'Apply',
                        onClick: applyCoupon,
                        width: 80.0,
                        height: 55.0,
                        radius: 15,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: CustomTextWidget(
              text: 'Available Offers',
              textColor: kAppColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: FutureBuilder<Offers>(
              future: offerFuture,
              builder: (context, response) {
                if (response.connectionState == ConnectionState.waiting) {
                  return const CustomLoaderWidget();
                }

                if (response.data!.apiStatus!.toLowerCase() == 'false') {
                  return const Center(
                    child: CustomTextWidget(
                        text: 'No offer found', textColor: Colors.red),
                  );
                }

                List<OffersData> offerList = response.data!.data!;

                if (offerList.isEmpty) {
                  return const Center(
                    child: CustomTextWidget(
                      text: 'No offers found',
                      textColor: Colors.red,
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: offerList.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 10.0),
                      child: NeumorphismWidget(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: CachedNetworkImage(
                                imageUrl:
                                    '${offerList[index].path}${offerList[index].image}',
                                placeholder: (context, url) =>
                                    const CustomLoaderWidget(),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.local_offer,
                                  size: 40,
                                ),
                                width: 50.0,
                                height: 50.0,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextWidget(
                                          text: offerList[index].offerCode!,
                                          textColor: kAppColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      CustomTextWidget(
                                        text: offerList[index].expireDate!,
                                        textColor: Colors.black54,
                                        fontSize: 10.0,
                                      ),
                                    ],
                                  ),
                                  HtmlWidget(
                                    offerList[index].description!,
                                    textStyle: GoogleFonts.poppins(
                                        color: Colors.black54, fontSize: 10.0),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: CustomTextWidget(
                                        text:
                                            '${offerList[index].discount}% Discount Upto',
                                        textColor: Colors.black,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                      )),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            minimumSize: const Size(75.0, 30.0),
                                            side: const BorderSide(
                                                color: kAppColor, width: 0.5)),
                                        onPressed: () {
                                          offerId = offerList[index].id!;

                                          _offerController.text =
                                              offerList[index].offerCode!;
                                        },
                                        child: const CustomTextWidget(
                                          text: 'Select',
                                          textColor: kAppColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.0,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void applyCoupon() {
    String code = _offerController.text.trim();

    if (code.isEmpty) {
      Helper.showSnackBar(context, 'Enter code', Colors.red);
      return;
    }
    Map<String, String> body = {
      'plan_id': widget.planId,
      'offer_code': code,
    };
    Helper.showLoaderDialog(context, message: 'Apply...');

    ApiHelper.applyOffer(body).then((value) {
      Navigator.pop(context);

      if (value.apiStatus!.toLowerCase() == 'true') {
        Helper.showSnackBar(context, 'Coupon apply successfully', Colors.green);

        Map<String, String> couponBody = {
          'grand_total': value.grandTotal.toString(),
          'code': code,
          'offer_id': offerId,
        };
        Navigator.pop(context, couponBody);
      } else {
        Helper.showSnackBar(
            context, value.result ?? 'Something went wrong', Colors.red);
      }
    });
  }
}
