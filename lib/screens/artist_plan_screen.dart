import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/components/neumorphism_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:book_indian_talents_app/model/show_addplan.dart';
import 'package:book_indian_talents_app/model/talents.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:book_indian_talents_app/widgets/booking_widget.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import '../components/custom_button_widget.dart';

class ArtistPlanScreen extends StatefulWidget {
  static const String id = 'artist_plan_screen';

  const ArtistPlanScreen({super.key, required this.data});

  final TalentData data;

  @override
  State<ArtistPlanScreen> createState() => _ArtistPlanScreenState();
}

class _ArtistPlanScreenState extends State<ArtistPlanScreen> {
  late Future<ShowAddPlan> showPlanFuture;

  Future<ShowAddPlan> getPlan() async {
    return ApiHelper.showPlan(widget.data.id!);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showPlanFuture = getPlan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: widget.data.nickName ?? 'My Plan',
          textColor: Theme.of(context).hintColor,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: FutureBuilder<ShowAddPlan>(
        future: showPlanFuture,
        builder: (context, response) {
          if (response.connectionState == ConnectionState.waiting) {
            return const CustomLoaderWidget();
          }
          if (response.data!.apiStatus!.toLowerCase() == 'false') {
            return const Center(
              child: CustomTextWidget(
                  text: 'No plan found', textColor: Colors.red),
            );
          }
          List<ShowPlanData> planList = response.data!.data!;

          if (planList.isEmpty) {
            return const Center(
              child: CustomTextWidget(
                text: 'No plan found',
                textColor: Colors.red,
              ),
            );
          }
          return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return ArtistPlanWidget(plan: planList[index], artistName:widget.data.nickName!,);
              },
              shrinkWrap: true,
              itemCount: planList.length);
        },
      ),
    );
  }
}

class ArtistPlanWidget extends StatelessWidget {
  const ArtistPlanWidget({super.key, required this.plan,required this.artistName});

  final ShowPlanData plan;
  final String artistName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
      child: NeumorphismWidget(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(
              text: plan.name ?? '',
              textColor: kAppColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 5),
        ReadMoreText(
          plan.details ?? '',
          trimLines: 2,
          colorClickableText: kAppColor,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'Read more',
          trimExpandedText: 'Show less',
          moreStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600,color:kAppColor),
          lessStyle:TextStyle(fontSize: 10, fontWeight: FontWeight.w600,color:kAppColor) ,
        ),
            // CustomTextWidget(
            //   text:
            //   textColor: Colors.black,
            //   fontSize: 10,
            //   fontWeight: FontWeight.w600,
            // ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: CustomTextWidget(
                    text: '₹${plan.amount}',
                    textColor: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),

                CustomButtonWidget(
                  text: 'Book Now',
                  onClick: () {
                    SessionManager.setNickName(artistName);
                    showDialog(
                        context: context,
                        builder: (context) => BookDialogWidget(plan: plan));
                  },
                  fontSize: 12.0,
                  radius: 25.0,
                  width: 120.0,
                  height: 35.0,
                )

              ],
            )
          ],
        ),
      ),
    );
  }
}

//todo:-------------------------------------------------------------------------
