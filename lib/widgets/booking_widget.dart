import 'package:book_indian_talents_app/components/custom_button_widget.dart';
import 'package:book_indian_talents_app/components/custom_radio_button.dart';
import 'package:book_indian_talents_app/components/custom_text_field_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/helper/helper.dart';
import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:book_indian_talents_app/helper/size_config.dart';
import 'package:book_indian_talents_app/model/show_addplan.dart';
import 'package:book_indian_talents_app/screens/bookind_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class BookDialogWidget extends StatefulWidget {
  const BookDialogWidget({super.key, required this.plan});
  final ShowPlanData plan;
  @override
  State<BookDialogWidget> createState() => _BookDialogWidgetState();
}
class _BookDialogWidgetState extends State<BookDialogWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text=SessionManager.getUserName()??'';
    _numberController.text=SessionManager.getMobile()??'';
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Dialog(
        insetPadding: EdgeInsets.zero,
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15.0),
                  decoration: BoxDecoration(color: kAppColor.withOpacity(0.2)),
                  child: CustomTextWidget(
                    text: 'Book Now',
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
                        hintText: 'Enter Contact Person name',
                        controller: _nameController,
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        prefixIcon: Icons.person_2_outlined,
                      ),
                      const SizedBox(height: 15.0),
                      CustomTextFieldWidget(
                        hintText: 'Enter contact number',
                        controller: _numberController,
                        isEnable: false,
                        inputType: TextInputType.number,
                        inputAction: TextInputAction.next,
                        maxLength: 10,
                        prefixIcon: Icons.phone_android_rounded,
                      ),
                      const SizedBox(height: 15.0),
                      CustomTextFieldWidget(
                        hintText: 'Enter Venue Address For the Service',
                        controller: _venueController,
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.done,
                        prefixIcon: Icons.location_on,
                      ),
                      const SizedBox(height: 25.0),
                      CustomButtonWidget(
                        text: 'Submit',
                        onClick: book,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25.0),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void book() {
    String name = _nameController.text.trim();
    String contact = _numberController.text.trim();
    String address = _venueController.text.trim();
    if (name.isEmpty) {
      Helper.showToastMessage('Enter person name', Colors.red);
      return;
    }
    if (contact.length != 10) {
      Helper.showToastMessage('Enter contact number', Colors.red);
      return;
    }
    if (address.isEmpty) {
      Helper.showToastMessage('Enter address', Colors.red);
      return;
    }
    Map<String, String> body = {
      'name': name,
      'contact': contact,
      'address': address,
      'plan_id': widget.plan.id!,
      'artist_id': widget.plan.artistId!,
      'total_amt': widget.plan.amount!
    };

    print(body);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => BookInfluencersDialogWidget(body: body));
  }
}
//todo--------------------------------------------------------------------------
class BookInfluencersDialogWidget extends StatefulWidget {
  const BookInfluencersDialogWidget({super.key, required this.body});
  final Map<String, String> body;
  @override
  State<BookInfluencersDialogWidget> createState() =>
      _BookInfluencersDialogWidgetState();
}
class _BookInfluencersDialogWidgetState
    extends State<BookInfluencersDialogWidget> {
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _productController = TextEditingController();
  final TextEditingController _serviceController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2080),
    );
    if (picked != null) {
      String selectedDate = Helper.formattedDate(picked);
      _dateController.text = selectedDate;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Dialog(
        insetPadding: EdgeInsets.zero,
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15.0),
                  decoration: BoxDecoration(color: kAppColor.withOpacity(0.2)),
                  child: CustomTextWidget(
                    text: 'Book Now influencers',
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
                      // const CustomTextWidget(
                      //   text: 'Purpose of booking*',
                      //   textColor: Colors.black,
                      //   fontWeight: FontWeight.w700,
                      //   fontSize: 12,
                      // ),
                      // const SizedBox(
                      //   height: 2,
                      // ),
                      CustomTextFieldWidget(
                        hintText: 'Enter Purpose',
                        controller: _purposeController,
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 15.0),
                      // const CustomTextWidget(
                      //   text: 'About product*',
                      //   textColor: Colors.black,
                      //   fontWeight: FontWeight.w700,
                      //   fontSize: 12,
                      // ),
                      // const SizedBox(
                      //   height: 2,
                      // ),
                      CustomTextFieldWidget(
                        hintText: 'Enter About Occasion',
                        controller: _productController,
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 15.0),
                      // const CustomTextWidget(
                      //   text:
                      //       'What kind of exact service is expected from talent*',
                      //   textColor: Colors.black,
                      //   fontWeight: FontWeight.w700,
                      //   fontSize: 12,
                      // ),
                      // const SizedBox(
                      //   height: 2,
                      // ),
                      CustomTextFieldWidget(
                        hintText: 'Enter Explain',
                        controller: _serviceController,
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: 15.0),
                      // const CustomTextWidget(
                      //   text: 'What is exact date for IG post*',
                      //   textColor: Colors.black,
                      //   fontWeight: FontWeight.w700,
                      //   fontSize: 12,
                      // ),
                      // const SizedBox(
                      //   height: 2,
                      // ),
                      // InkWell(
                      //   onTap: _selectDate,
                      //   child: CustomTextFieldWidget(
                      //     hintText: 'Enter Date',
                      //     isEnable: false,
                      //     controller: _dateController,
                      //     inputType: TextInputType.text,
                      //     inputAction: TextInputAction.done,
                      //   ),
                      // ),
                      const SizedBox(height: 25.0),
                      CustomButtonWidget(
                        text: 'Submit',
                        onClick: book,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void book() {
    String purpose = _purposeController.text.trim();
    String product = _productController.text.trim();
    String service = _serviceController.text.trim();
  //  String date = _dateController.text.trim();
    if (purpose.isEmpty) {
      Helper.showToastMessage('Enter booking purpose', Colors.red);
      return;
    }
    if (product.isEmpty) {
      Helper.showToastMessage('Enter about product', Colors.red);
      return;
    }
    if (service.isEmpty) {
      Helper.showToastMessage('Enter expected service', Colors.red);
      return;
    }
    // if (date.isEmpty) {
    //   Helper.showToastMessage('Select date', Colors.red);
    //   return;
    // }
    widget.body['purpose'] = purpose;
    widget.body['about_product'] = product;
    widget.body['kind_service'] = service;
    widget.body['date_ig_post'] = '-';

    print(widget.body);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => GuidelinesDialogWidget(body: widget.body));
  }
}
//todo--------------------------------------------------------------------------------
class GuidelinesDialogWidget extends StatefulWidget {
  const GuidelinesDialogWidget({super.key, required this.body});
  final Map<String, String> body;
  @override
  State<GuidelinesDialogWidget> createState() => _GuidelinesDialogWidgetState();
}
class _GuidelinesDialogWidgetState extends State<GuidelinesDialogWidget> {
  bool isTerm = false;
  @override
  Widget build(BuildContext context) {
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
                  text: 'Guidelines ',
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
                            text: 'ONCE THE BOOKING IS CONFIRMED FROM\n TALENT',
                            style: GoogleFonts.quicksand(
                              color: Theme.of  (context).hintColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            )),
                        TextSpan(
                          text: 'ARTIST ONLY 24% WILL BE REFUNDED 5 DAYS ',
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                            text:
                                'BEFORE OF AGREED  DATE , POST THAT\n DAY NO REFUND CAN BE GIVEN IN ANY CIRCUMSTANCES',
                            style: GoogleFonts.quicksand(
                              color: Theme.of(context).hintColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            )),
                      ]),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomRadioButton(
                          label: 'Accept Terms & Conditions',
                          value: isTerm,
                          onChanged: (isCheck) {
                            setState(() {
                              isTerm = !isTerm;
                            });
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButtonWidget(
                      text: 'Submit',
                      onClick: _continue,
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
  }

  void _continue() {
    if (!isTerm) {
      Helper.showToastMessage('Accept Terms & Condition', Colors.red);
      return;
    }
    Navigator.pushNamed(context, BookingScreen.id, arguments: widget.body);
  }
}