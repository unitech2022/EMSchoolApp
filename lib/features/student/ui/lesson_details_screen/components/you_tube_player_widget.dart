import 'package:em_school/core/extensions/extensions_routing.dart';
import 'package:em_school/core/helpers/helper_functions.dart';
import 'package:em_school/features/student/bloc/lesson_cubit/lesson_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerWidget extends StatefulWidget {
  final YoutubePlayerController controller;

  final void Function(YoutubeMetaData) onEnded;

  const YouTubePlayerWidget({super.key, required this.controller, required this.onEnded});



  @override
  State<YouTubePlayerWidget> createState() => _YouTubePlayerWidgetState();
}

class _YouTubePlayerWidgetState extends State<YouTubePlayerWidget> {

  bool isFull = false;
  @override
  Widget build(BuildContext context) {
    return   SizedBox(

      height: isFull ? context.height : context.height / 2.5,
      width: double.infinity,
      child: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: YoutubePlayerBuilder(

              onEnterFullScreen: () {
                isFull = true;
                LessonCubit.get(context).changeFullScreen(true);
                setState(() {});
              },
              onExitFullScreen: () {
                isFull = false;
                LessonCubit.get(context).changeFullScreen(false);
                setState(() {});
              },
              player: YoutubePlayer(
                controller: widget.controller,
                showVideoProgressIndicator: true,

                progressColors: const ProgressBarColors(
                  playedColor: Colors.amber,
                  handleColor: Colors.amberAccent,
                ),
                onReady: () {
                  // _controller.pause();
                },
                onEnded: widget.onEnded,

                bottomActions: [
                  FullScreenButton(),
                  CurrentPosition(),
                  ProgressBar(isExpanded: true),
                  RemainingDuration()
                  // PlayPauseButton(),
                ],
              ),
              builder: (buildContext, widget) {
                return Container();
              },
            ),
          ),

          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: (){
               if (isFull){
                 SystemChrome.setPreferredOrientations(DeviceOrientation.values);

               }else{
                 pop(context);
               }

              },
              child: Container(
                padding: EdgeInsets.all(5.w),
                margin: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(.5)

                ),
                child: const Icon(
                  Icons.close,color: Colors.white,size: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

