import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:book_indian_talents_app/screens/add_address_screen.dart';
import 'package:flutter/material.dart';

import '../helper/constants.dart';
import '../helper/helper.dart';
import '../model/show_address.dart';
import 'edit_address_screen.dart';

class AddressBookScreen extends StatefulWidget {
  static const String id = 'address_book_screen';

  const AddressBookScreen({super.key});

  @override
  State<AddressBookScreen> createState() => _AddressBookScreenState();
}

class _AddressBookScreenState extends State<AddressBookScreen> {
  String _selectedValue = 'Option 1';
  late Future<ShowAddress> addressfuture;

  Future<ShowAddress> showAddress() async {
    return ApiHelper.showAddress();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addressfuture = showAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: 'Address ',
          textColor: Theme.of(context).primaryColorLight,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          TextButton(
              onPressed: () async {
                final data =
                    await Navigator.pushNamed(context, AddAddressScreen.id);
                if (data != null) {
                  if (data == true) {
                    setState(() {
                      addressfuture = showAddress();
                    });
                  }
                }
              },
              child: const CustomTextWidget(
                text: 'Add Address',
                textColor: Colors.black,
              ))
        ],
      ),
      body: FutureBuilder<ShowAddress>(
          future: addressfuture,
          builder: (context, response) {
            if (response.connectionState == ConnectionState.waiting) {
              return const CustomLoaderWidget();
            }
            if (response.data!.apiStatus!.toLowerCase() == 'false') {
              return const Center(
                child: CustomTextWidget(
                    text: 'No address found', textColor: Colors.red),
              );
            }
            List<ShowAddressData> showaddressLsit = response.data!.data!;

            if (showaddressLsit.isEmpty) {
              return const Center(
                child: CustomTextWidget(
                    text: 'No address found', textColor: Colors.red),
              );
            }

            if (response.data!.apiStatus!.toLowerCase() == 'false') {
              return Center(
                child: CustomTextWidget(
                    text: response.data!.result!, textColor: Colors.red),
              );
            }
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                height: 0.5,
              ),
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.grey.shade200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              title: Row(
                                children: [
                                  CustomTextWidget(
                                      text: showaddressLsit[index].name ?? '',
                                      textColor: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const CustomTextWidget(
                                      text: '(Default)',
                                      textColor: Colors.grey,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ],
                              ),
                              value: _selectedValue,
                              groupValue: _selectedValue,
                              onChanged: (value) {
                                setState(() {});
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(
                              5.0,
                            ),
                            margin: const EdgeInsets.only(right: 10),
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                              color: Colors.white,
                              border: Border.all(color: kAppBarColor),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomTextWidget(
                                  text: showaddressLsit[index].adreessType!,
                                  textColor: kAppBarColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 72, right: 20),
                        child: CustomTextWidget(
                            text:
                                '${showaddressLsit[index].landmark!} ${showaddressLsit[index].address!} ${showaddressLsit[index].city!} ${showaddressLsit[index].state!} ${showaddressLsit[index].pincode!}',
                            textColor: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                deleteAddress(showaddressLsit[index].id!);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(
                                  5.0,
                                ),
                                margin: const EdgeInsets.only(right: 10),
                                width: 40,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  color: Colors.white,
                                ),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: kAppColor,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              child: Container(
                                padding: const EdgeInsets.all(
                                  5.0,
                                ),
                                margin: const EdgeInsets.only(right: 10),
                                width: 40,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  color: Colors.white,
                                ),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      color: kAppColor,
                                    )
                                  ],
                                ),
                              ),
                              onTap: () async {
                                final data = await Navigator.pushNamed(
                                    context, EditAddressScreen.id,
                                    arguments: showaddressLsit[index]);

                                if (data != null) {
                                  if (data == true) {
                                    setState(() {
                                      addressfuture = showAddress();
                                    });
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              },
              shrinkWrap: true,
              itemCount: showaddressLsit.length,
            );
          }),
    );
  }

  void deleteAddress(String id) {
    Helper.showLoaderDialog(context, message: 'deleting.......');
    Map<String, String> body = {
      'address_id': id,
    };
    print(body);
    ApiHelper.deleteAddress(body).then((value) {
      Navigator.pop(context);
      if (value.apiStatus!.toLowerCase() == 'true') {
        Helper.showToastMessage('Successfully Delete', Colors.green);
        setState(() {
          addressfuture = showAddress();
        });
      } else {
        Helper.showToastMessage(value.result!, Colors.red);
      }
    });
  }
}
