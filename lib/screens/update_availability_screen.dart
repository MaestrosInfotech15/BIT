import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../components/custom_button_widget.dart';
import '../components/custom_loader_widget.dart';
import '../components/custom_text_widget.dart';
import '../components/neumorphism_widget.dart';
import '../helper/constants.dart';
import '../helper/helper.dart';
import '../helper/session_manager.dart';
import '../network/api_helper.dart';

class UpdateAvailabilityScreen extends StatefulWidget {
  static const String id = 'update_availability_screen';

  const UpdateAvailabilityScreen({super.key});

  @override
  State<UpdateAvailabilityScreen> createState() =>
      _UpdateAvailabilityScreenState();
}

class _UpdateAvailabilityScreenState extends State<UpdateAvailabilityScreen> {
  String selectedDateText = '';
  String selectedDatesAsString = '';
  List<DateTime> selectedDates = [];
  List<DateTime> datelist = [];

  bool isdate = false;
  bool isDate=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDate();
  }

void getDate(){
  setState(() {
    isDate = true;
  });
  ApiHelper.getShowartistSlote(SessionManager.getUserId()).then((value) {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: 'Availability',
          textColor: Theme.of(context).primaryColorLight,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: isdate
                ? CustomLoaderWidget()
                : CustomButtonWidget(
                    text: 'Update Availability',
                    textColor: Colors.white,
                    width: 100,
                    height: 30,
                    radius: 20,
                    fontSize: 12,
                    onClick: () {

                      submitDate();
                    },
                  ),
          ),
        ],
      ),
      body:isDate?CustomLoaderWidget(): NeumorphismWidget(
        padding: EdgeInsets.zero,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SfDateRangePicker(
            initialSelectedDate: DateTime.now(),
            enablePastDates: false,

            monthCellStyle: DateRangePickerMonthCellStyle(blackoutDatesDecoration: BoxDecoration(
                color: Colors.grey.shade300,
                border: Border.all(color: const Color(0xFFF44436), width: 1),
                shape: BoxShape.circle),),
            selectionMode: DateRangePickerSelectionMode.multiple,
            monthViewSettings: DateRangePickerMonthViewSettings(blackoutDates:datelist,),
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              setState(() {
                // selectedDates = args.value;
                selectedDates = args.value;
                selectedDatesAsString = selectedDates
                    .map((date) => date.toLocal().toString().split(' ')[0])
                    .join(',');

                print(selectedDatesAsString);
              });
            },
          ),
        ),
      ),
    );
  }

  void submitDate() {

    if(selectedDatesAsString.isEmpty){
      Helper.showToastMessage('Select Date', Colors.red);
      return;
    }
    Map<String, dynamic> body = {
      'artist_id': SessionManager.getUserId(),
      'date': selectedDatesAsString,
    };
    print(body);
    setState(() {
      isdate = true;
    });
    ApiHelper.AddartistSlote(body).then((value) {
      setState(() {
        isdate = false;
      });
      if (value.apiStatus!.toLowerCase() == 'true') {
     //   Helper.showToastMessage('Add artist slot', Colors.green);

        setState(() {
          getDate();
        });
      } else {
        Helper.showToastMessage('Failed to Request', Colors.red);
      }
    });
  }
}
