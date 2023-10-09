import 'dart:async';

import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:chewie/chewie.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../components/custom_text_widget.dart';
import '../helper/constants.dart';
import '../helper/helper.dart';
import '../network/api_helper.dart';

class ShowVideoWidget extends StatefulWidget {
  const ShowVideoWidget({super.key,required this.videoUrl});
  final String videoUrl;

  @override
  State<ShowVideoWidget> createState() => _ShowVideoState();
}

class _ShowVideoState extends State<ShowVideoWidget> {
  late VideoPlayerController _videoPlayerController1;
  late VideoPlayerController _videoPlayerController2;
  late ChewieController _chewieController;
  @override
  void initState() {

    super.initState();
    _videoPlayerController1 = VideoPlayerController.network(widget.videoUrl);
    _videoPlayerController2 = VideoPlayerController.network((widget.videoUrl));
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 16/9,
      autoPlay: true,
      looping: false,
      // Try playing around with some of these other options:

      // showControls: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
    );

    _videoPlayerController1.addListener(() {
      if (_videoPlayerController1.value.position ==
          _videoPlayerController1.value.duration) {
        print('video Ended');

      }
    });
  }
  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 18),
      elevation: 0.0,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15.0),
              color: kAppColor,
              child: Row(
                children: [
                   Expanded(
                    child: CustomTextWidget(
                      text: '',
                      textColor: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: () {

                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.cancel_outlined,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 400,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SafeArea(
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
class EventVideoWidget extends StatefulWidget {
  const EventVideoWidget({super.key,required this.videoUrl,this.type='USER',required this.id,required this.onclick});
  final String videoUrl;
  final String type;
  final String id;
  final VoidCallback onclick;


  @override
  State<EventVideoWidget> createState() => _EventVideoWidgetState();
}

class _EventVideoWidgetState extends State<EventVideoWidget> {
  late VideoPlayerController _videoPlayerController1;
  late VideoPlayerController _videoPlayerController2;
  late ChewieController _chewieController;
  @override
  void initState() {

    super.initState();
    _videoPlayerController1 = VideoPlayerController.network(widget.videoUrl);
    _videoPlayerController2 = VideoPlayerController.network((widget.videoUrl));
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: false,
      showControls: false,
      // Try playing around with some of these other options:

      // showControls: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
    );

    _videoPlayerController1.addListener(() {
      if (_videoPlayerController1.value.position ==
          _videoPlayerController1.value.duration) {
        print('video Ended');

      }
    });
  }
  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieController.dispose();
    super.dispose();
  }
  bool isvideo=false;
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return ShowVideoWidget(
                videoUrl:widget.videoUrl,
              );
            });
      },
      child: Column(
        children: [
          Container(
            height: 110,
            width: 110,
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
              border: Border.all(color: Colors.black),
            ),
            child: Chewie(
              controller: _chewieController,
            ),
          ),
          const SizedBox(height: 5.0),
          Visibility(
            visible: widget.type=='Dashboard',
            child: InkWell(
              onTap:widget.onclick,
              child: const CustomTextWidget(
                text: 'Remove',
                textColor: Colors.red,
                fontSize: 12.0,
                textDecoration: TextDecoration.underline,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    );
  }
  void deleteArtistVidio(String id) {

    Helper.showLoaderDialog(context, message: 'remove.......');
    Map<String, String> body = {
      'id': id,
    };
    print(body);
    ApiHelper.deleteArtistVidio(body).then((value) {
      Navigator.pop(context);
      if (value.apiStatus!.toLowerCase() == 'true') {
        Helper.showToastMessage('Remove', Colors.red);
        setState(() {
          isvideo=false;
        });

      } else {
        Helper.showToastMessage(value.result!, Colors.red);
      }
    });
  }
}

