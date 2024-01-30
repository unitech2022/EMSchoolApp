import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:em_school/core/helpers/helper_functions.dart';
import 'package:em_school/core/utlis/app_model.dart';
import 'package:em_school/core/utlis/utils.dart';

import 'package:em_school/features/common/models/lesson_model.dart';
import 'package:em_school/features/common/models/rate_response.dart';

import 'package:em_school/features/student/ui/navigation_student_screen/navigation_student_screen.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../core/enums/loading_status.dart';
import '../../../../core/utlis/api_constatns.dart';
import '../student_cubit/student_cubit.dart';

part 'lesson_state.dart';

class LessonCubit extends Cubit<LessonState> {
  LessonCubit() : super(const LessonState());

  static LessonCubit get(context) => BlocProvider.of<LessonCubit>(context);
  late YoutubePlayerController controller;

  bool likedLesson = false;

  int likes = 0;

  Future getLessonDetails({context, lessonId, isComment = false}) async {
    emit(state.copyWith(
      getLessonDetailsState: RequestState.loading,
    ));
    var dio = Dio();
    final params = <String, dynamic>{
      'lessonId': lessonId.toString(),
      'userId': currentUser!.user.id
    };
    var response = await dio.get(
        '${ApiConstants.baseUrl}/Lessons/get-Lesson-details?',
        queryParameters: params);

    debugPrint("${response.statusCode} ===== getLessonDetails");
    if (response.statusCode == 200) {
      LessonDetailsResponse lessonModel =
          LessonDetailsResponse.fromJson(response.data);
      likedLesson = lessonModel.liked;
      likes = lessonModel.lesson.liks;
      if (!isComment) {
        controller = YoutubePlayerController(
          initialVideoId: lessonModel.lesson.linkVidio,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        );
      }

      debugPrint("${lessonModel.comments.length} ===== getLessonDetails");
      emit(LessonState(
        lessonDetailsResponse: lessonModel,
        getLessonDetailsState: RequestState.loaded,isLike: lessonModel.liked
      ));
    } else {
      emit(state.copyWith(
        getLessonDetailsState: RequestState.error,
      ));
    }
  }

// loke lesson
  Future addLikeLesson({context, lessonId}) async {
    likedLesson = !likedLesson;
    if (likedLesson) {
      likes += 1;
      
    }else{
      likes -= 1;
    }
    emit(state.copyWith(addRateState: RequestState.loading,isLike: likedLesson));
    var data = FormData.fromMap(
        {'lessonId': lessonId.toString(), 'userId': currentUser!.user.id});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/likes/add-Like',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}addLikeLesson");
    if (response.statusCode == 200) {
      emit(state.copyWith(addLikedState: RequestState.loaded));
    } else {
      emit(state.copyWith(addLikedState: RequestState.error));
    }
  }

// add comment
  Future addComment({context, lessonId, comment}) async {
    emit(state.copyWith(
      addCommentState: RequestState.loading,
    ));
    var data = FormData.fromMap({
      'LessonId': lessonId,
      'UserId': currentUser!.user.id,
      'Text': comment
    });

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Comments/add-Comment',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}    addComment");
    if (response.statusCode == 200) {
      emit(state.copyWith(
        addCommentState: RequestState.loaded,
      ));

      await getLessonDetails(
          context: context, lessonId: lessonId, isComment: false);
    } else {
      emit(state.copyWith(
        addCommentState: RequestState.error,
      ));
    }
  }

// add reply
  Future addReply({context, commentId, lessonId, text}) async {
    emit(state.copyWith(
      addCommentState: RequestState.loading,
    ));
    var data = FormData.fromMap(
        {'CommentId': commentId, 'UserId': currentUser!.user.id, 'Text': text});
    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Replys/add-Reply',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}    addReply");
    if (response.statusCode == 200) {
      emit(state.copyWith(
        addCommentState: RequestState.loaded,
      ));

      await getLessonDetails(
          context: context, lessonId: lessonId, isComment: false);
    } else {
      emit(state.copyWith(
        addCommentState: RequestState.error,
      ));
    }
  }

// add Rate
  Future addRateLesson({context, lessonId, comment, stare}) async {
    emit(state.copyWith(addRateState: RequestState.loading));
    var data = FormData.fromMap({
      'lessonId': lessonId.toString(),
      'UserId': currentUser!.user.id,
      'Comment': 'thanks',
      'Stare': stare.toString()
    });

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/rates/add-rate',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    debugPrint("${response.statusCode}addRateLesson");
    if (response.statusCode == 200) {
      RateResponse rateResponse = RateResponse.fromJson(response.data);

      showToast(msg: rateResponse.message, color: Colors.green);
      emit(state.copyWith(
          addRateState: RequestState.loaded, rateResponse: rateResponse));
      await getLessonDetails(context: context, lessonId: lessonId);
    } else {
      emit(state.copyWith(addRateState: RequestState.error));
    }
  }

  Future addExerciseCompleted(
      {context, lessonId, finalDegree, result, subjectId}) async {
    showUpdatesLoading(context);
    emit(state.copyWith(
      addEXCompletedState: RequestState.loading,
    ));
    var data = FormData.fromMap({
      'LessoinId': lessonId.toString(),
      'StudantId': currentUser!.user.id,
      'subjectId': subjectId,
      "Final": finalDegree.toString(),
      'Result': result.toString()
    });

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/exrecies/add-ex-completed',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode.toString()} ===>  addExerciseCompleted");
    if (response.statusCode == 200) {
      pop(context);
      pushPage(
          context,
          BlocProvider(
            create: (context) => StudentCubit(),
            child: const NavigationStudentScreen(),
          ));
      emit(state.copyWith(
        addEXCompletedState: RequestState.loaded,
      ));
    } else {
      pop(context);
      showToast(msg: "حدث خطآ", color: Colors.red);
      emit(state.copyWith(
        addEXCompletedState: RequestState.error,
      ));
    }
  }

  currentAnswer(int newValue) async {
    emit(state.copyWith(idSelected: newValue));
  }

  changeFullScreen(bool newValue) {
    emit(state.copyWith(fullScreen: newValue));
  }

  final player = AudioPlayer();

  Future playSound({file}) async {
    player.stop();
    AssetSource source = AssetSource(file);
    await player.play(source);
  }

  Timer? timer;
  int start = 0;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 5 * 60) {
          timer.cancel();
          start = 0;
          emit(state.copyWith(timer: 0));
        } else {
          start++;
          emit(state.copyWith(timer: start));
        }
      },
    );
  }

  cancelTimer() {
    if (timer != null || timer!.isActive) {
      timer!.cancel();
      start = 0;
      // emit(state.copyWith(timer:0));
    }
  }
}
