import 'package:book_indian_talents_app/components/custom_dialog_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/components/neumorphism_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/helper/helper.dart';
import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:book_indian_talents_app/screens/home_screen.dart';
import 'package:book_indian_talents_app/screens/offers_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../components/custom_button_widget.dart';
import '../components/custom_loader_widget.dart';
import '../helper/size_config.dart';
import '../model/show_artist_slote.dart';
import 'confirm_booking_screen.dart';

class BookingScreen extends StatefulWidget {
  static const String id = 'booking_screen';

  const BookingScreen({super.key, required this.body});

  final Map<String, String> body;
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

bool isdate=false;
bool isDate=false;
List<DateTime> datelist = [];
class _BookingScreenState extends State<BookingScreen> {
  String selectTime = 'Select Time';
  String grandTotal = '';
  String planAmount = '';
  String startDate = '';
  String endDate = '';

  String offerCode = 'Unlock Offers or Apply Refer Code';
  String offerId = '';

  DateTime incDate= DateTime.now();

  Future<void> _selectTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    if (pickedTime != null) {
      String time = Helper.formatTime(pickedTime.format(context));

      setState(() {
        selectTime = time;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(widget.body);
    grandTotal = widget.body['total_amt']!;
    planAmount = widget.body['total_amt']!;
  //  incDate= DateFormat('dd-MM-yyyy').parse(widget.body['date_ig_post']!);
    startDate =widget.body['date_ig_post']!;
    endDate =widget.body['date_ig_post']!;
    getDate();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    // startDate = DateFormat('dd-MM-yyyy').format(args.value);
    // endDate = DateFormat('dd-MM-yyyy').format(args.value);
    print(args.value);
    setState(() {
      if (args.value is PickerDateRange) {
        startDate = DateFormat('dd-MM-yyyy').format(args.value.startDate);
       endDate = DateFormat('dd-MM-yyyy')
           .format(args.value.endDate ?? args.value.startDate);
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: 'Booking',
          textColor: Theme.of(context).hintColor,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            CustomTextWidget(
              text: 'Select Start & End Date',
              textColor: Theme.of(context).primaryColorLight,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 10.0),
            isDate?CustomLoaderWidget():NeumorphismWidget(
              padding: const EdgeInsets.all(5.0),
              child: SfDateRangePicker(
               // initialSelectedDate:incDate,
                //initialSelectedRange: PickerDateRange(incDate, incDate),
                enablePastDates: false,
                monthCellStyle: DateRangePickerMonthCellStyle(blackoutDatesDecoration: BoxDecoration  (
                    color: Colors.grey.shade300,
                    border: Border.all(color: const Color(0xFFF44436), width: 1),
                    shape: BoxShape.circle),),
                monthViewSettings: DateRangePickerMonthViewSettings(blackoutDates:datelist,),
                selectionMode: DateRangePickerSelectionMode.range,
                onSelectionChanged: _onSelectionChanged,
              ),
            ),
            const SizedBox(height: 25.0),
            CustomTextWidget(
              text: 'Select Booking Time',
              textColor: Theme.of(context).primaryColorLight,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 10.0),
            InkWell(
              onTap: () {
                _selectTime();
              },
              child: NeumorphismWidget(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 15.0),
                child: Row(
                  children: [
                    Expanded(
                        child: CustomTextWidget(
                      text: selectTime,
                      textColor: Theme.of(context).primaryColorLight,
                      fontWeight: FontWeight.w600,
                    )),
                    const Icon(Icons.access_time)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25.0),
            InkWell(
              onTap: () async {
                final data = await Navigator.pushNamed(context, OffersScreen.id,
                    arguments: widget.body['plan_id']);

                if (data != null) {
                  Map<String, String> offerBody = data as Map<String, String>;
                  setState(() {
                    //  grandTotal = data as String;
                    grandTotal = offerBody['grand_total']!;
                    offerCode = offerBody['code']!;
                    offerId = offerBody['offer_id']!;
                  });
                }
              },
              child: NeumorphismWidget(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 15.0),
                child: Row(
                  children: [
                    Image.asset(
                      '$kLogoPath/discount.png',
                      height: 30.0,
                    ),
                    const SizedBox(width: 15.0),
                    Expanded(
                      child: CustomTextWidget(
                        text: offerCode,
                        textColor: Theme.of(context).primaryColorLight,
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    const Icon(Icons.navigate_next_rounded)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25.0),
            NeumorphismWidget(
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
                        text: '₹$planAmount',
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
                        text: discount(),
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
                        text: '₹$grandTotal',
                        fontSize: 16.0,
                        textColor: Theme.of(context).primaryColorLight,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25.0),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 3.0,
          ),
        ]),
        child: Row(
          children: [
            TextButton(
              onPressed: () {},
              child: const CustomTextWidget(
                text: 'Reset',
                textColor: Colors.black87,
                fontSize: 16.0,
              ),
            ),
             Spacer(),
            CustomButtonWidget(
              text: 'Book (₹$grandTotal)',
              onClick: () {
                bookingNow();
              },
              width: 120,
              radius: 25.0,
              height: 45.0,
            )
          ],
        ),
      ),
    );
  }

  String discount() {
    double amount = double.parse(planAmount) - double.parse(grandTotal);
    return '₹$amount';
  }

  void bookingNow() {
    if (startDate.isEmpty && endDate.isEmpty) {
      Helper.showSnackBar(context, 'Select Date', Colors.red);
      return;
    }

    if (selectTime == 'Select Time') {
      Helper.showSnackBar(context, 'Select Time', Colors.red);
      return;
    }
    widget.body['total_amt'] = grandTotal;
    widget.body['user_id'] = SessionManager.getUserId();
    widget.body['user_type'] = SessionManager.getLoginWith();
    widget.body['time_slot'] = selectTime;
    widget.body['start_date'] = startDate;
    widget.body['end_date'] = endDate;

    widget.body['discount']=discount();
    widget.body['sub_total']=planAmount;
    if (offerId.isNotEmpty) {
      widget.body['offer_id'] = offerId;
    }
Navigator.pushNamed(context, ConfirmBookingScreen.id,arguments: widget.body);
  /* showDialog(
      context: context,
      builder: (context){
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Dialog(
            insetPadding: EdgeInsets.zero,
            elevation: 0.0,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey.shade200),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: SizeConfig.width(),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    decoration: BoxDecoration(color: kAppColor.withOpacity(0.2)),
                    child: CustomTextWidget(
                      text: 'Confirm Booking ',
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
                        const SizedBox(
                          height: 20,
                        ),
                        const CustomTextWidget(
                          text:
                          'YOUR BOOKING WILL BE CONFIRMED WITHIN\n 24 HOURS POST CONFIRMATION & CONSENT\nFROM THE TALENT/ARTIST',
                          textColor: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'ONCE THE BOOKING IS CONFIRMED FROM TALENT/ARTIST THERE WILL BE NO REFUNDED',
                              style: GoogleFonts.quicksand(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ]),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomButtonWidget(
                          text: 'Ok',
                          onClick: () {
                            Navigator.pop(context);
                            bookingProsced(widget.body);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25.0),
                ],
              ),
            ),
          ),

        );
      },
    );
    */


  }

  void bookingProsced(Map<String,String>body){
    Helper.showLoaderDialog(context, message: 'Please wait...');

    ApiHelper.booking(body).then((value) {
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
                title: 'Booking',
                message: 'Booking Successfully.\nYour booking id $bookingId',
                onClick: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeScreen.id, (route) => false);
                },
                btnText: 'Back to home'));
      } else {
        Helper.showSnackBar(context, 'Booking Failed! Try again.', Colors.red);
      }
    });
  }
  void getDate(){
    setState(() {
      isDate = true;
    });
    ApiHelper.getShowartistSlote(widget.body['artist_id']!).then((value) {
      setState(() {
        isDate = false;
      });
      if (value.apiStatus!.toLowerCase() == 'true') {
        if (value.data!.isNotEmpty) {
          for(var data in value.data!){
            print(data.date);
            DateTime date = DateTime.parse(data.date!.trim());
            datelist.add(date);

          }
        }
      }
    });
  }
}
