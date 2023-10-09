import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:flutter/material.dart';
import '../components/custom_button_widget.dart';
import '../components/custom_dialog_widget.dart';
import '../components/custom_text_widget.dart';
import '../components/neumorphism_widget.dart';
import '../helper/constants.dart';
import '../helper/helper.dart';
import '../network/api_helper.dart';
import 'home_screen.dart';

class ConfirmBookingScreen extends StatefulWidget {
  static const String id = 'confirm_booking_screen';

  const ConfirmBookingScreen({super.key,required this.body});
  final Map<String, String> body;


  @override
  State<ConfirmBookingScreen> createState() => _ConfirmBookingScreenState();
}

class _ConfirmBookingScreenState extends State<ConfirmBookingScreen> {
  String grandTotal = '';
  String planAmount = '';

// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     PhonePePaymentSdk.init('environmentValue', 'appId', '35c63349-cc73-43ef-b0fd-174336fd17d8', 'enableLogging')
//         .then((val) => {
//       setState(() {
//         result = 'PhonePe SDK Initialized - $val';
//       })
//     })
//         .catchError((error) {
//       handleError(error);
//       return <dynamic>{};
//     });
//   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kAppBarColor,
          title: CustomTextWidget(
            text: 'Confirm Booking',
            textColor: Theme.of(context).primaryColorLight,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: NeumorphismWidget(
                padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextWidget(
                            text: 'Date',
                            textColor: Theme.of(context).primaryColorLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        CustomTextWidget(
                          text: widget.body['start_date']??'',
                          textColor: Theme.of(context).primaryColorLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextWidget(
                            text: 'Time ',
                            textColor: Theme.of(context).primaryColorLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        CustomTextWidget(
                          text: widget.body['time_slot']??'',
                          textColor: Theme.of(context).primaryColorLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: NeumorphismWidget(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextWidget(
                            text: 'Sub Total',
                            textColor: Theme.of(context).primaryColorLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        CustomTextWidget(
                          text: '₹${widget.body['sub_total']??''}',
                          textColor: Theme.of(context).primaryColorLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextWidget(
                            text: 'Discount',
                            textColor: Theme.of(context).primaryColorLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        CustomTextWidget(
                          text:'${widget.body['discount']??''}',
                          textColor: Theme.of(context).primaryColorLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextWidget(
                            text: 'Total Payment',
                            textColor: Theme.of(context).primaryColorLight,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                          ),
                        ),
                        CustomTextWidget(
                          text: '₹${widget.body['total_amt']??''}',
                          fontSize: 16.0,
                          textColor: Theme.of(context).primaryColorLight,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),

                  ],

                ),
              ),
            ),
            SizedBox(height: 30),
            CustomButtonWidget(
              text: 'Book Now',
              onClick: () {
                bookingProsced();
              },
              width: 200,
              radius: 25.0,
              height: 45.0,
            )
          ],
        ));
  }
  void bookingProsced(){
    widget.body.remove('discount');
    widget.body.remove('sub_total');
    Helper.showLoaderDialog(context, message: 'Please wait...');

    ApiHelper.booking(widget.body).then((value) {
      Navigator.pop(context);
      if (value.apiStatus!.toLowerCase() == 'true') {
        updateBooking(value.bookingId!);
      } else {
        Helper.showSnackBar(context, 'Booking Failed! Try again.', Colors.red);
      }
    });
  }

  void updateBooking(String bookingId) {
    Map<String, String> body = {
      'booking_id': bookingId,
      'transaction_id': '7894563210'
    };

    Helper.showLoaderDialog(context, message: 'Booking Confirmation...');

    ApiHelper.bookingUpdate(body).then((value) {
      Navigator.pop(context);
      if (value.apiStatus!.toLowerCase() == 'true') {
        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) => SuccessDialogWidget(
                title: 'Booking ',
                message: 'Booking Successfully.\n\nArtist: ${SessionManager.getNickName()}\n\nYour booking id $bookingId\n\n Your Booking Date & Time: ${widget.body['time_slot']} ${widget.body['start_date']} ${widget.body['end_date']}',
                onClick: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context,HomeScreen.id, (route) => false);
                },
                btnText: 'Back to home'));
      } else {
        Helper.showSnackBar(context, 'Booking Failed! Try again.', Colors.red);
      }
    });
  }
}
