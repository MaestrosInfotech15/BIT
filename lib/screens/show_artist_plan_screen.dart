import 'package:book_indian_talents_app/components/custom_button_widget.dart';
import 'package:flutter/material.dart';

import '../components/custom_loader_widget.dart';
import '../components/custom_text_widget.dart';
import '../helper/constants.dart';
import '../helper/helper.dart';
import '../helper/session_manager.dart';
import '../model/show_addplan.dart';
import '../network/api_helper.dart';
import '../widgets/add_plan_widget.dart';
import '../widgets/show_plan_widget.dart';

class ShowArtistPlanScreen extends StatefulWidget {
  static const String id = 'show_artist_plan_screen';

  const ShowArtistPlanScreen({super.key});

  @override
  State<ShowArtistPlanScreen> createState() => _ShowArtistPlanScreenState();
}

class _ShowArtistPlanScreenState extends State<ShowArtistPlanScreen> {
  late Future<ShowAddPlan> showPlanfuture;

  Future<ShowAddPlan> showplan() async {
    return ApiHelper.showPlan(SessionManager.getUserId());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showPlanfuture = showplan();
    setState(() {
      showPlanfuture = showplan();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: 'Service & Charges',
          textColor: Colors.black,
          fontWeight: FontWeight.w700,
        ),
        actions: [

          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CustomButtonWidget(text: 'Add Service',
              textColor: Colors.white,
              width: 100,

              height: 30,
              radius:20,
              fontSize: 12,
              onClick: () {
                showDialog(
                    context: context,
                    builder: (context) =>
                    const AddPlanDialogWidget())
                    .then((value) {
                  if (value != null) {
                    if (value == true) {
                      setState(() {
                        showPlanfuture = showplan();
                      });
                    }
                  }
                });
              },),
          ),

        ],
      ),
      body: FutureBuilder<ShowAddPlan>(
          future: showPlanfuture,
          builder: (context, response) {
            if (response.connectionState ==
                ConnectionState.waiting) {
              return const CustomLoaderWidget();
            }
            if (response.data!.apiStatus!.toLowerCase() ==
                'false') {
              return const Center(
                child: CustomTextWidget(
                    text: 'No Plan added', textColor: Colors.red),
              );
            }
            List<ShowPlanData> showPlanlist = response.data!.data!;

            if (showPlanlist.isEmpty) {
              return const Center(
                child: CustomTextWidget(
                    text: 'No Plan added', textColor: Colors.red),
              );
            }

            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ShowPlanWidget(
                  showPlanData: showPlanlist[index],
                  onTap: () {
                    deleteArtistPlan(showPlanlist[index].id!);
                  },
                );
              },
              shrinkWrap: true,
              itemCount: showPlanlist.length,
            );
          }),
    );
  }

  void deleteArtistPlan(String id) {
    Helper.showLoaderDialog(context, message: 'deleting.......');
    Map<String, String> body = {
      'plan_id': id,
    };
    ApiHelper.deleteArtistPlan(body).then((value) {
      Navigator.pop(context);
      if (value.apiStatus!.toLowerCase() == 'true') {
        Helper.showToastMessage('Successfully Delete', Colors.green);
        setState(() {
          showPlanfuture = showplan();
        });
      } else {
        Helper.showToastMessage(value.result!, Colors.red);
      }
    });
  }
}
