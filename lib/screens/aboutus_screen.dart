import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/model/aboutus.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:http/http.dart';

import '../components/custom_text_widget.dart';
import '../helper/constants.dart';

class AboutUsScreen extends StatefulWidget {
  static const String id = 'aboutus_screen';

  const AboutUsScreen({super.key,required this.type});

  final String type;

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  late Future<AboutUs> aboutfuture;

  Future<AboutUs> getAbout() async {
    return ApiHelper.getAboutus();
  }

 Future<AboutUs> getTermsServices() async {
    return ApiHelper.getTermsServices();
  }
Future<AboutUs> getprivacyPolicy() async {
    return ApiHelper.getprivacyPolicy();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.type=='About Me'){
      aboutfuture = getAbout();
    }else if(widget.type=='Terms of Services '){
      aboutfuture = getTermsServices();
    }else if(widget.type=='Privacy Policy '){
      aboutfuture = getprivacyPolicy();
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kAppBarColor,
          title: CustomTextWidget(
            text: widget.type,
            textColor: Theme.of(context).primaryColorLight,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: FutureBuilder<AboutUs>(
            future: aboutfuture,
            builder: (context, response) {
              if (response.connectionState == ConnectionState.waiting) {
                return CustomLoaderWidget();
              }
              if (response.data!.apiStatus!.toLowerCase() == 'false') {
                return Center(
                  child: CustomTextWidget(
                      text: response.data!.result!, textColor: Colors.red),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(image: AssetImage('assets/images/about_icon.png')),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: HtmlWidget(
                        response.data!.data!,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              );
            }));
  }
}
