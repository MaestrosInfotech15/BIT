import 'dart:io';

import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/components/custom_radio_button.dart';
import 'package:book_indian_talents_app/components/string_drop_down_widget.dart';
import 'package:book_indian_talents_app/fragments/account_fragment.dart';
import 'package:book_indian_talents_app/fragments/home_fragment.dart';
import 'package:book_indian_talents_app/helper/helper.dart';
import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:book_indian_talents_app/model/show_profile.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:book_indian_talents_app/provider/app_controller.dart';
import 'package:book_indian_talents_app/screens/home_screen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_button_widget.dart';
import '../components/custom_text_field_widget.dart';
import '../components/custom_text_widget.dart';
import '../components/gallery_option_sheet_widget.dart';
import '../helper/constants.dart';
import '../provider/file_provider.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const String id = 'update_profile_screen';

  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController nick_nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _anniversaryController = TextEditingController();

  String _gender = '';
  FocusNode addressnode=FocusNode();

  String initialState = 'Select State';
  bool isProfile = false;
  String imagePath = '';
  String imageUri = '';
  bool isUpdate = false;

  Future<void> _selectDate(String type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1947),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      String selectedDate = Helper.formattedDate(picked);
      if (type == 'dob') {
        _dateController.text = selectedDate;
      } else {
        _anniversaryController.text = selectedDate;
      }
      addressnode.requestFocus();
    }
  }

  void getProfile() {
    setState(() {
      isProfile = true;
    });
    ApiHelper.getProfile().then((value) {
      setState(() {
        isProfile = false;
      });
      if (value.apiStatus!.toLowerCase() == 'true') {
        ShowProfileData showProfileData = value.data!;
        nameController.text = showProfileData.name ?? '';
        nick_nameController.text = showProfileData.nick_name ?? '';
        cityController.text = showProfileData.city ?? '';
        addressController.text = showProfileData.address ?? '';
        numberController.text = showProfileData.contact ?? '';
        emailController.text = showProfileData.email ?? '';
        zipController.text = showProfileData.zip ?? '';
        _dateController.text = showProfileData.dob ?? '';
        _anniversaryController.text = showProfileData.doa ?? '';
        imagePath = showProfileData.images ?? '';
        imageUri = value.path!;

        if (value.data != null) {
          if (value.data!.state!.isEmpty) {
            initialState = 'Select State';
          } else {
            initialState = value.data!.state!;
          }
        }
        //initialState = value.data!.state ?? 'Select State';
        _gender = value.data!.gender ?? '';
        SessionManager.setProfileImage(imageUri + imagePath);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<FileProvider>(context, listen: false).selectedFilePath = '';
    nameController.text = SessionManager.getUserName();
    numberController.text = SessionManager.getMobile();
    emailController.text = SessionManager.getUserEmail();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: 'Update Profile',
          textColor: Theme.of(context).primaryColorLight,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: isProfile
          ? const CustomLoaderWidget()
          : SingleChildScrollView(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  const CustomTextWidget(
                      text: 'Full name*',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      textColor: Colors.black),
                  const SizedBox(height: 5.0),
                  CustomTextFieldWidget(
                      hintText: 'Enter Full Name',
                      controller: nameController,
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      prefixIcon: Icons.person),
                  const SizedBox(height: 10.0),
                  
                  SessionManager.getLoginWith()=='ARTIST'?Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomTextWidget(
                            text: 'Business  name*',
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            textColor: Colors.black),
                        const SizedBox(height: 5.0),
                        CustomTextFieldWidget(
                            hintText: 'Enter Business Name',
                            controller: nick_nameController,
                            inputType: TextInputType.name,
                            inputAction: TextInputAction.next,
                            prefixIcon: Icons.person),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ):Text(''),

                  
                  const CustomTextWidget(
                      text: 'Email Address*',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      textColor: Colors.black),
                  const SizedBox(height: 5.0),
                  CustomTextFieldWidget(
                      hintText: 'Enter your Email ',
                      controller: emailController,
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                      prefixIcon: Icons.email_outlined),
                  const SizedBox(height: 20.0),
                  const CustomTextWidget(
                      text: 'Phone Number*',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      textColor: Colors.black),
                  const SizedBox(height: 5.0),
                  CustomTextFieldWidget(
                      hintText: 'Enter your number ',
                      controller: numberController,
                      maxLength: 10,
                      isEnable: false,
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.next,
                      prefixIcon: Icons.email_outlined),
                  const SizedBox(height: 20.0),
                  const CustomTextWidget(
                      text: 'Date of Birth *',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      textColor: Colors.black),
                  const SizedBox(height: 5.0),
                  InkWell(
                    onTap: () {
                      _selectDate('dob');
                    },
                    child: CustomTextFieldWidget(
                      hintText: 'Enter Date',
                      isEnable: false,
                      prefixIcon: Icons.date_range,
                      controller: _dateController,
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.done,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const CustomTextWidget(
                      text: 'Date of Anniversary *',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      textColor: Colors.black),
                  const SizedBox(height: 5.0),
                  InkWell(
                    onTap: () {
                      _selectDate('anniversaryController');
                    },
                    child: CustomTextFieldWidget(
                      hintText: 'Enter Anniversary',
                      isEnable: false,
                      prefixIcon: Icons.date_range,
                      controller: _anniversaryController,
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.done,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const CustomTextWidget(
                      text: 'Address*',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      textColor: Colors.black),
                  const SizedBox(height: 5.0),
                  CustomTextFieldWidget(
                      hintText: 'Enter your address ',
                      controller: addressController,
                      focus: addressnode,
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      prefixIcon: Icons.location_on_outlined),
                  const SizedBox(height: 20.0),
                  const CustomTextWidget(
                      text: 'City*',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      textColor: Colors.black),
                  const SizedBox(height: 5.0),
                  CustomTextFieldWidget(
                      hintText: 'Enter your city ',
                      controller: cityController,
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      prefixIcon: Icons.location_city),
                  const SizedBox(height: 20.0),
                  const CustomTextWidget(
                      text: 'India State*',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      textColor: Colors.black),
                  const SizedBox(height: 5.0),
                  StringDropDownWidget(
                      initialValue: initialState,
                      items: stateList,
                      onChange: (value) {
                        setState(() {
                          initialState = value;
                        });
                      }),
                  const SizedBox(height: 20.0),
                  const CustomTextWidget(
                      text: 'Zip*',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      textColor: Colors.black),
                  const SizedBox(height: 5.0),
                  CustomTextFieldWidget(
                      hintText: 'Enter zip code ',
                      controller: zipController,
                      inputType: TextInputType.number,
                      maxLength: 6,
                      inputAction: TextInputAction.done,
                      prefixIcon: Icons.numbers),
                  const SizedBox(height: 20.0),
                  const CustomTextWidget(
                      text: 'Gender',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      textColor: Colors.black),
                  const SizedBox(height: 5.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: CustomRadioButton(
                          label: 'Male',
                          value: _gender == 'Male',
                          onChanged: (isCheck) {
                            setState(() {
                              _gender = 'Male';
                            });
                          },
                        ),
                      ),
                      Flexible(
                        child: CustomRadioButton(
                          label: 'Female',
                          value: _gender == 'Female',
                          onChanged: (isCheck) {
                            setState(() {
                              _gender = 'Female';
                            });
                          },
                        ),
                      ),
                      Flexible(
                        child: CustomRadioButton(
                          label: 'Rather Not Say',
                          value: _gender == 'Rather Not Say',
                          onChanged: (isCheck) {
                            setState(() {
                              _gender = 'Rather Not Say';
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  DottedBorder(
                    borderType: BorderType.RRect,
                    color: kAppColor,
                    radius: const Radius.circular(10),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          getProfileWidget(),
                          const SizedBox(height: 5),
                          const CustomTextWidget(
                              text: 'Upload your Profile Image',
                              fontWeight: FontWeight.w700,
                              fontSize: 14.0,
                              textColor: Colors.black),
                          TextButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return const GalleryOptionSheetWidget();
                                  });
                            },
                            child: const CustomTextWidget(
                                text: 'Browse',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                textColor: kAppColor,
                                textDecoration: TextDecoration.underline),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: isUpdate
                        ? const CustomLoaderWidget()
                        : CustomButtonWidget(
                            radius: 25,
                            width: 150,
                            text: 'Submit',
                            onClick: updateProfile,
                          ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
    );
  }

  Widget getProfileWidget() {
    final data = Provider.of<FileProvider>(context);

    if (data.selectedFilePath.isNotEmpty) {
      imagePath = '';
    }

    if (imagePath.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
            height: 75.0, width: 75.0, fit: BoxFit.cover, imageUri + imagePath),
      );
    }

    if (data.selectedFilePath.isEmpty) {
      return const Icon(Icons.drive_folder_upload, color: kAppColor, size: 35);
    }

    // if (data.isFileUpload) {
    //   return const CircularProgressIndicator();
    // }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.file(
        File(data.selectedFilePath),
        height: 75.0,
        width: 75.0,
        fit: BoxFit.cover,
      ),
    );
  }

  void updateProfile() {
    final data = Provider.of<FileProvider>(context, listen: false);
    final appdata = Provider.of<AppController>(context, listen: false);
    String name = nameController.text.trim();
    String nick_name = nick_nameController.text.trim();
    String email = emailController.text.trim();
    String phone = numberController.text.trim();
    String dob  = _dateController.text.trim();
    String doa   = _anniversaryController.text.trim();

    String address = addressController.text.trim();
    String city = cityController.text.trim();
    String zipcode = zipController.text.trim();

    if (name.isEmpty) {
      Helper.showSnackBar(context, 'Enter your name', Colors.red);
      return;
    }
    if(SessionManager.getLoginWith()=='ARTIST'){
      if (nick_name.isEmpty) {
        Helper.showSnackBar(context, 'Enter your Business  name', Colors.red);
        return;
      }
    }

    if (!Helper.isEmailValid(email)) {
      Helper.showSnackBar(context, 'Enter your Valid email', Colors.red);
      return;
    }
    if (phone.isEmpty) {
      Helper.showSnackBar(context, 'Enter your Phone Number', Colors.red);
      return;
    }
    if (address.isEmpty) {
      Helper.showSnackBar(context, 'Enter your Address ', Colors.red);
      return;
    }
    if (city.isEmpty) {
      Helper.showSnackBar(context, 'Enter your city ', Colors.red);
      return;
    }
    if (initialState == 'Select State') {
      Helper.showSnackBar(context, ' Please Select Your State', Colors.red);
      return;
    }
    if (zipcode.isEmpty) {
      Helper.showSnackBar(context, 'Enter your Zipcode ', Colors.red);
      return;
    }
    if (_gender.isEmpty) {
      Helper.showSnackBar(context, 'Please Select Your Gender ', Colors.red);
      return;
    }

    if (imagePath.isEmpty) {
      if (data.selectedFilePath.isEmpty) {
        Helper.showSnackBar(
            context, 'Please Upload your Profile Image', Colors.red);
        return;
      }
    }

    Map<String, String> body = {
      'id': SessionManager.getUserId(),
      'type': SessionManager.getLoginWith(),
      'name': name,
      'nick_name': nick_name,
      'email': email,
      'contact': phone,
      'dob': dob,
      'doa': doa,
      'address': address,
      'city': city,
      'state': initialState == 'Select State' ? '' : initialState,
      'zip': zipcode,
      'gender': _gender
    };

    setState(() {
      isUpdate = true;
    });

    ApiHelper.updateProfile(body, data.selectedFilePath).then((value) {
      setState(() {
        isUpdate = false;
      });

      if (value.apiStatus!.toLowerCase() == 'true') {
        SessionManager.setUserName(value.data!.name!);
        SessionManager.setUserEmail(value.data!.email!);
        SessionManager.setProfileImage('${value.path!}/${value.data!.images!}');
        SessionManager.setProfileUpdate('1');
        Helper.showSnackBar(
            context, 'Profile Update Successfully', Colors.green);
        appdata.setProfileImage('${value.path!}/${value.data!.images!}');
        Navigator.pop(context, true);
       // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
      } else {
        Helper.showSnackBar(context, 'Failed to Update Profile', Colors.red);
      }
    });
  }
}
