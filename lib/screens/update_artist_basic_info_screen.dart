import 'package:book_indian_talents_app/components/custom_button_widget.dart';
import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_field_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/components/neumorphism_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/helper/helper.dart';
import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:book_indian_talents_app/model/categories.dart';
import 'package:book_indian_talents_app/model/sub_category.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:book_indian_talents_app/provider/api_controller.dart';
import 'package:book_indian_talents_app/widgets/category_sub_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateArtistBasicInfoScreen extends StatefulWidget {
  static const String id = 'update_artist_info_screen';

  const UpdateArtistBasicInfoScreen({super.key});

  @override
  State<UpdateArtistBasicInfoScreen> createState() =>
      _UpdateArtistBasicInfoScreenState();
}

class _UpdateArtistBasicInfoScreenState
    extends State<UpdateArtistBasicInfoScreen> {
  final TextEditingController _feeController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _fbController = TextEditingController();
  final TextEditingController _youtubeController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();

  Map<String, String> catBody = {};
  List<String> catNameList = [];
  List<String> subCatNameList = [];

  bool isUpdate = false;
  bool backUpdate = false;
  bool isProfile = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBasicInfo();
    final data = Provider.of<ApiController>(context, listen: false);
    data.catNameList = [];
    data.subCatNameList = [];
  }

  void getBasicInfo() {
    final data = Provider.of<ApiController>(context, listen: false);
    catNameList .clear();
     subCatNameList.clear();
    setState(() {
      isProfile = true;
    });
    ApiHelper.getArtistBasicInfo().then((value) {
      setState(() {
        isProfile = false;
      });
      _fbController.text = value.data!.facebook ?? '';
      _aboutController.text = value.data!.about ?? '';
      _feeController.text = value.data!.fee ?? '';
      _youtubeController.text = value.data!.youtube ?? '';
      _instagramController.text = value.data!.instagram ?? '';
      _linkedinController.text = value.data!.linkedin ?? '';
      if(value.data!.category!.isNotEmpty){
        for(var cat in value.data!.category!){
          catNameList.add(cat.name!);
        }
      }
      if(value.data!.subcat!.isNotEmpty){
        for(var subcat in value.data!.subcat!){
          subCatNameList.add(subcat.subName!);
        }
      }
      data.setUpdateCategory(catNameList, subCatNameList);
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ApiController>(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, backUpdate);

        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: kAppBarColor,
          title: CustomTextWidget(
            text: 'Update Basic Info',
            textColor: Theme.of(context).primaryColorLight,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: isProfile
            ? const CustomLoaderWidget()
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(height: 20.0),
                    // const CustomTextWidget(
                    //     text: 'Your Fees',
                    //     fontWeight: FontWeight.w500,
                    //     fontSize: 14.0,
                    //     textColor: Colors.black),
                    // const SizedBox(height: 5.0),
                    // CustomTextFieldWidget(
                    //     hintText: 'Enter your fee',
                    //     controller: _feeController,
                    //     inputType: TextInputType.number,
                    //     inputAction: TextInputAction.next,
                    //     prefixIcon: Icons.person),

                    const SizedBox(height: 20.0),
                    const CustomTextWidget(
                        text: ' About me',
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        textColor: Colors.black),
                    const SizedBox(height: 5.0),
                    DescriptionTextField(
                        hintText: 'Enter about ',
                        controller: _aboutController,
                        inputType: TextInputType.multiline,
                        inputAction: TextInputAction.newline,
                        prefixIcon: Icons.email_outlined),
                    const SizedBox(height: 20.0),
                    const CustomTextWidget(
                        text: 'Instagram link',
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        textColor: Colors.black),
                    const SizedBox(height: 5.0),
                    CustomSocialTextFieldWidget(
                      hintText: 'Enter your instagram link',
                      controller: _instagramController,
                      inputType: TextInputType.url,
                      inputAction: TextInputAction.next,
                      image: 'assets/icons/instagram.png',
                    ),
                    const SizedBox(height: 20.0),
                    const CustomTextWidget(
                        text: 'YouTube link',
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        textColor: Colors.black),
                    const SizedBox(height: 5.0),
                    CustomSocialTextFieldWidget(
                        hintText: 'Enter your youtube link',
                        controller: _youtubeController,
                        inputType: TextInputType.url,
                        inputAction: TextInputAction.next,
                        image: 'assets/icons/youtube.png',),
                    const SizedBox(height: 20.0),
                    const CustomTextWidget(
                        text: 'Facebook link',
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        textColor: Colors.black),
                    const SizedBox(height: 5.0),
                    CustomSocialTextFieldWidget(
                        hintText: 'Enter your facebook link',
                        controller: _fbController,
                        inputType: TextInputType.url,
                        inputAction: TextInputAction.next,
                         image: 'assets/icons/facebook.png',),
                    const SizedBox(height: 20.0),
                    const CustomTextWidget(
                        text: 'LinkedIn link',
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        textColor: Colors.black),
                    const SizedBox(height: 5.0),
                    CustomSocialTextFieldWidget(
                        hintText: 'Enter your linkedin link',
                        controller: _linkedinController,
                        inputType: TextInputType.url,
                        inputAction: TextInputAction.done,
                         image: 'assets/icons/linkedin.png',),
                    const SizedBox(height: 15.0),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return const CategorySubCategoryWidget();
                          },
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              catBody = value as Map<String, String>;
                            });
                          }
                        });
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: NeumorphismWidget(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 15.0),
                            child: CustomTextWidget(
                              text: 'Update Category',
                              textColor: Theme.of(context).primaryColorLight,
                            )),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          data.catNameList.length,
                          (subIndex) => InkWell(
                            child: Container(
                              margin: const EdgeInsets.only(
                                  right: 5.0, bottom: 5.0),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                  color: kAppColor,
                                  borderRadius: BorderRadius.circular(25.0),
                                  border:
                                      Border.all(color: Colors.grey.shade400)),
                              child: CustomTextWidget(
                                text: data.catNameList[subIndex],
                                textColor: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0,
                              ),
                            ),
                            onTap: () {},
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          data.subCatNameList.length,
                          (subIndex) => InkWell(
                            child: Container(
                              margin: const EdgeInsets.only(
                                  right: 5.0, bottom: 5.0),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                  color: kAppBarColor,
                                  borderRadius: BorderRadius.circular(25.0),
                                  border:
                                      Border.all(color: kAppBarColor)),
                              child: CustomTextWidget(
                                text: data.subCatNameList[subIndex],
                                textColor: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0,
                              ),
                            ),
                            onTap: () {},
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: isUpdate
                          ? const CustomLoaderWidget()
                          : CustomButtonWidget(
                              radius: 25,
                              width: 150,
                              text: 'Update',
                              onClick: _updateInfo,
                            ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
      ),
    );
  }

  void _updateInfo() {
    String fee = _feeController.text.trim();
    String about = _aboutController.text.trim();
    String instagram = _instagramController.text.trim();
    String youtube = _youtubeController.text.trim();
    String linkedin = _linkedinController.text.trim();
    String facebook = _fbController.text.trim();

    setState(() {
      isUpdate = true;
    });

    Map<String, String> body = {
      'id': SessionManager.getUserId(),
      'fee': ' 0',
      'about': about,
      'instagram': instagram,
      'youtube': youtube,
      'linkedin': linkedin,
      'facebook': facebook,
      'name': SessionManager.getUserName()
    };

    body.addAll(catBody);

    print(body);

    ApiHelper.updateArtistBasicInfo(body).then((value) {
      setState(() {
        isUpdate = false;
        backUpdate = true;
      });

      if (value.apiStatus!.toLowerCase() == 'true') {
        Helper.showSnackBar(context, 'Update successfully', Colors.green);
        Navigator.pop(context);
      } else {
        Helper.showSnackBar(context, 'Failed to update profile', Colors.red);
      }
    });
  }
}
