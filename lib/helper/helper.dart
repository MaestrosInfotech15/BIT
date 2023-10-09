

import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class Helper {
  static showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: CustomTextWidget(
          text: message,
          textColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static showToastMessage(String message, Color color) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 14.0);
  }
  static showLoaderDialog(BuildContext context, {String message = 'Loading'}) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(
            color: kAppColor,
          ),
          Container(
            margin: const EdgeInsets.only(left: 15.0),
            child: CustomTextWidget(
              text: message,
              textColor: kTextColor,
            ),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static String formattedDate(DateTime selectedDate) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(selectedDate);
    return formatted;
  }

  static String convertDate(String inputDate) {
    DateTime date = DateTime.parse(inputDate);

    return DateFormat('dd-MM-yyyy').format(date);
    print(formattedDate); // Output: 03-06-2023
  }

  static String getCurrentDateTime() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd, hh:mm:ss a');
    final String formatted = formatter.format(DateTime.now());
    return formatted;
  }

  static String formatTime(String time) {
    DateTime start;
    if (time.contains('AM') || time.contains('PM')) {
      start = DateFormat("H:m a").parse(time);
    } else {
      start = DateFormat("H:m").parse(time);
    }

    final DateFormat formatter = DateFormat('hh:mm: a');
    final String formatted = formatter.format(start);

    return formatted;
  }

  static void launchApp(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch');
    }
  }
  static whatsapp() async{
    var contact = "+917987737702";
    var androidUrl = "whatsapp://send?phone=$contact&text=Hi, I need some help";
    var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

    try{
      if(Platform.isIOS){
        await launchUrl(Uri.parse(iosUrl));
      }
      else{
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception{
    }
  }

  static String timeAgoCustom(String dateTime) {
    // <-- Custom method Time Show  (Display Example  ==> 'Today 7:00 PM')
    // WhatsApp Time Show Status Shimila

    final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm a');

    DateTime d = formatter.parse(dateTime);

    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (diff.inDays > 0) return DateFormat.E().add_jm().format(d);
    // if (diff.inHours > 0) return "Today ${DateFormat('jm').format(d)}";
    if (diff.inHours > 0) return "Today";
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    return "Just now";
  }

  static Future<String> downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName.png';
    final Response response = await get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static Future<Uint8List> generateThumbnail(String videoUrl) async {
    final thumbnail = await VideoThumbnail.thumbnailData(
      video: videoUrl,
      imageFormat: ImageFormat.PNG,
      maxWidth: 128, // Specify the width of the thumbnail
      quality: 50,  // Specify the quality of the thumbnail (0 to 100)
    );
    return thumbnail!;

  }
  static String getFileSizeString({required int bytes, int decimals = 0}) {
    const suffixes = ["b", "kb", "mb", "gb", "tb"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }
  static bool isEmailValid(String email) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)
    ;
  }

}
