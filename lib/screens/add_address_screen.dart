import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/components/string_drop_down_widget.dart';
import 'package:book_indian_talents_app/helper/helper.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:flutter/material.dart';

import '../components/custom_button_widget.dart';
import '../components/custom_text_field_widget.dart';
import '../components/custom_text_widget.dart';
import '../helper/constants.dart';
import '../helper/session_manager.dart';

class AddAddressScreen extends StatefulWidget {
  static const String id = 'add_address_screen';

  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  TextEditingController pincodeController = TextEditingController();
  TextEditingController addresscodeController = TextEditingController();
  TextEditingController localityController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  bool isAddAddress = false;
  String addressType = 'Home';

  String initialState = 'Select State';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: 'Add Address',
          textColor: Theme.of(context).primaryColorLight,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              color: Colors.white,
              width: double.infinity,
              child: CustomTextWidget(
                  text: 'Add Address',
                  textColor: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextFieldWidget(
                      hintText: 'Pin Code*',
                      controller: pincodeController,
                      inputType: TextInputType.number,
                      maxLength: 6,
                      inputAction: TextInputAction.next,
                      prefixIcon: Icons.pin),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextFieldWidget(
                      hintText: 'Address (House No.Building Name)',
                      controller: addresscodeController,
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      prefixIcon: Icons.home),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextFieldWidget(
                      hintText: 'Locality ',
                      controller: localityController,
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      prefixIcon: Icons.pin),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFieldWidget(
                            hintText: 'City*',
                            controller: cityController,
                            inputType: TextInputType.text,
                            inputAction: TextInputAction.next,
                            prefixIcon: Icons.location_on_outlined),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: StringDropDownWidget(
                          initialValue: initialState,
                          items: stateList,
                          onChange: (value) {
                            setState(() {
                              initialState = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.only(left: 25, right: 25),
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextWidget(
                    text: 'Save Address As',
                    textColor: Theme.of(context).primaryColorLight,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            addressType = 'Home';
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(
                            5.0,
                          ),
                          margin: EdgeInsets.only(right: 10),
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Colors.white,
                            border: Border.all(
                                color: addressType == 'Home'
                                    ? kAppBarColor
                                    : Colors.grey),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomTextWidget(
                                text: 'Home',
                                textColor: addressType == 'Home'
                                    ? kAppBarColor
                                    : Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            addressType = 'Work';
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(
                            5.0,
                          ),
                          margin: EdgeInsets.only(right: 10),
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Colors.white,
                            border: Border.all(
                                color: addressType == 'Work'
                                    ? kAppBarColor
                                    : Colors.grey),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomTextWidget(
                                text: 'Work',
                                textColor: addressType == 'Work'
                                    ? kAppBarColor
                                    : Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  isAddAddress
                      ? CustomLoaderWidget()
                      : CustomButtonWidget(
                          text: 'Save',
                          onClick: () {
                            addAddress();
                          },
                        ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addAddress() {
    String pincode = pincodeController.text.trim();
    String address = addresscodeController.text.trim();
    String locality = localityController.text.trim();
    String city = cityController.text.trim();
    if (pincode.isEmpty) {
      Helper.showToastMessage('Enter PinCode', Colors.red);
      return;
    }
    if (address.isEmpty) {
      Helper.showToastMessage('Enter address', Colors.red);
      return;
    }
    if (locality.isEmpty) {
      Helper.showToastMessage('Enter Locality ', Colors.red);
      return;
    }
    if (city.isEmpty) {
      Helper.showToastMessage('Enter City', Colors.red);
      return;
    }
    Map<String, dynamic> body = {
      'id': SessionManager.getUserId(),
      'type': SessionManager.getLoginWith(),
      'pincode': pincode,
      'address': address,
      'landmark': locality,
      'city': city,
      'state': initialState,
      'address_type': addressType,
    };
    setState(() {
      isAddAddress = true;
    });
    ApiHelper.addAddress(body).then((value) {
      setState(() {
        isAddAddress = false;
      });
      if (value.apiStatus!.toLowerCase() == 'true') {
        Helper.showSnackBar(context, 'Address Added Successfully', greencolor);
        Navigator.pop(context, true);
      } else {
        Helper.showSnackBar(context, 'Failed to add address', Colors.red);
      }
    });
  }
}
