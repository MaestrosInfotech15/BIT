import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/model/show_address.dart';
import 'package:flutter/material.dart';

import '../components/custom_button_widget.dart';
import '../components/custom_text_field_widget.dart';
import '../components/custom_text_widget.dart';
import '../components/string_drop_down_widget.dart';
import '../helper/constants.dart';
import '../helper/helper.dart';
import '../helper/session_manager.dart';
import '../network/api_helper.dart';

class EditAddressScreen extends StatefulWidget {
  static const String id = 'edit_address_screen';
  final ShowAddressData data;

  const EditAddressScreen({super.key, required this.data});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  TextEditingController pincodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController localityController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  String initialState = 'Select State';
  String addressType = 'Home';
  bool isAddAddress = false;

  @override
  void initState() {
    super.initState();
    getAddress();
  }

  void getAddress() {
    ShowAddressData showAddressData = widget.data!;
    pincodeController.text = showAddressData.pincode ?? '';
    addressController.text = showAddressData.address ?? '';
    localityController.text = showAddressData.landmark ?? '';
    cityController.text = showAddressData.city ?? '';
    initialState = showAddressData.state ?? 'Select State';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: 'Edit Address',
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
              width: double.infinity,
              color: kAppcremColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextWidget(
                      text: 'Service To:${SessionManager.getLoginWith()}',
                      textColor: Theme.of(context).primaryColorLight,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextWidget(
                      text: widget.data.pincode! +
                          ' ' +
                          widget.data.landmark! +
                          ' ' +
                          widget.data.address! +
                          ' ' +
                          widget.data.city! +
                          widget.data.state!,
                      textColor: Theme.of(context).primaryColorLight,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              color: Colors.white,
              width: double.infinity,
              child: CustomTextWidget(
                  text: 'Edit Address',
                  textColor: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 15,
            ),
            Column(
              children: [
                Padding(
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
                          controller: addressController,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
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
                              text: 'Update Address',
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
            )
          ],
        ),
      ),
    );
  }

  void addAddress() {
    String pincode = pincodeController.text.trim();
    String address = addressController.text.trim();
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
      'address_id': widget.data.id,
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
    ApiHelper.updateAddress(body).then((value) {
      setState(() {
        isAddAddress = false;
      });
      if (value.apiStatus!.toLowerCase() == 'true') {
        Helper.showSnackBar(context, 'Update Address Successfully', greencolor);
        Navigator.pop(context, true);
      } else {
        Helper.showSnackBar(context, 'Failed to add address', Colors.red);
      }
    });
  }
}
