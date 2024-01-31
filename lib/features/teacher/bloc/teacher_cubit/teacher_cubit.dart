import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:em_school/core/helpers/helper_functions.dart';
import 'package:em_school/core/utlis/app_model.dart';
import 'package:em_school/features/common/models/answer_for_add.dart';
import 'package:em_school/features/common/models/course_model.dart';
import 'package:em_school/features/common/models/home_teacher_response.dart';
import 'package:em_school/features/common/models/quiz_model.dart';
import 'package:em_school/features/common/models/subject_model.dart';
import 'package:em_school/features/common/models/unit_model.dart';
import 'package:em_school/features/teacher/ui/navigation_teacher_screen/navigation_teacher_screen.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/enums/loading_status.dart';
import '../../../../core/utlis/api_constatns.dart';
part 'teacher_state.dart';

class TeacherCubit extends Cubit<TeacherState> {
  TeacherCubit() : super(const TeacherState());

  static TeacherCubit get(context) => BlocProvider.of<TeacherCubit>(context);

  changeCurrentIndexNav(int newIndex) {
    emit(state.copyWith(currentNavIndex: newIndex));
  }

  Future getHomeData({context, userId}) async {
    emit(state.copyWith(
      getHomeTeacherState: RequestState.loading,
    ));
    var dio = Dio();
    final params = <String, dynamic>{
      'userId': userId,
    };
    var response = await dio.get(
      '${ApiConstants.baseUrl}/home/get-home-teacher?',
      queryParameters: params,
      options: Options(
        followRedirects: false,
        // will not throw errors
        validateStatus: (status) => true,
      ),
    );

    debugPrint("${response.statusCode} ===== getHomeData");
    if (response.statusCode == 200) {
      HomeTeacherResponse homeResponse =
          HomeTeacherResponse.fromJson(response.data);

      emit(state.copyWith(
        homeTeacherResponse: homeResponse,
        getHomeTeacherState: RequestState.loaded,
      ));
    } else {
      emit(state.copyWith(
        getHomeTeacherState: RequestState.error,
      ));
    }
  }

// add course
  Future addCourse({context, nameAr, nameEng}) async {
    emit(state.copyWith(addCourseState: RequestState.loading));
    var data = FormData.fromMap({
      'SubjectId': currentUser!.user.subjectId.toString(),
      'TeacherId': currentUser!.user.id,
      'NameAr': nameAr,
      'NameEng': nameEng,
      'Image': 'not'
    });

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Courses/add-Course',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}addCourse");
    if (response.statusCode == 200) {
      pop(context);
      emit(state.copyWith(addCourseState: RequestState.loaded));
      await getHomeData(context: context, userId: currentUser!.user.id);
    } else {
      emit(state.copyWith(addCourseState: RequestState.error));
    }
  }

// delete the course
  Future deleteCourse({context, nameAr, nameEng, courseId}) async {
    emit(state.copyWith(addCourseState: RequestState.loading));
    var data = FormData.fromMap({'CourseId': courseId.toString()});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Courses/delete-Course',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}delete-Course");
    if (response.statusCode == 200) {
      showToast(msg: "تم الحذف بنجاح", color: Colors.red);
      emit(state.copyWith(addCourseState: RequestState.loaded));
      await getHomeData(context: context, userId: currentUser!.user.id);
    } else {
      emit(state.copyWith(addCourseState: RequestState.error));
    }
  }

  Future updateCourse({context, nameAr, nameEng, courseId}) async {
    emit(state.copyWith(addCourseState: RequestState.loading));
    var data = FormData.fromMap(
        {'Id': courseId.toString(), 'NameAr': nameAr, 'NameEng': nameEng});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Courses/update-Course',
      options: Options(
        method: 'PUT',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}UpdateCourse");
    if (response.statusCode == 200) {
      pop(context);
      emit(state.copyWith(addCourseState: RequestState.loaded));
      await getHomeData(context: context, userId: currentUser!.user.id);
    } else {
      emit(state.copyWith(addCourseState: RequestState.error));
    }
  }

// add unnit
  Future addUnit({context, courseId, nameAr, nameEng}) async {
    emit(state.copyWith(addCourseState: RequestState.loading));
    var data = FormData.fromMap({
      'NameAr': nameAr,
      'CourseId': courseId.toString(),
      'NameEng': nameEng,
      'ImageUrl': 'RF'
    });

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Units/add-Unit',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}addUnit");

    if (response.statusCode == 200) {
      emit(state.copyWith(addCourseState: RequestState.loaded));
      await getHomeData(context: context, userId: currentUser!.user.id);
      pop(context);
    } else {
      emit(state.copyWith(addCourseState: RequestState.error));
    }
  }

// update
  Future updateUnit({context, courseId, nameAr, nameEng, id}) async {
    emit(state.copyWith(addCourseState: RequestState.loading));
    var data = FormData.fromMap({
      'NameAr': nameAr,
      'CourseId': courseId.toString(),
      'NameEng': nameEng,
      "id": id.toString(),
    });

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Units/update-Unit',
      options: Options(
        method: 'PUT',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}update-Unit");

    if (response.statusCode == 200) {
      emit(state.copyWith(addCourseState: RequestState.loaded));
      await getHomeData(context: context, userId: currentUser!.user.id);
      pop(context);
    } else {
      emit(state.copyWith(addCourseState: RequestState.error));
    }
  }

// delete the unit
  Future deleteUnite({context, unitId}) async {
    emit(state.copyWith(addCourseState: RequestState.loading));
    var data = FormData.fromMap({'UnitId': unitId.toString()});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Units/delete-Unit',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}delete-Unit");
    if (response.statusCode == 200) {
      showToast(msg: "تم الحذف بنجاح", color: Colors.red);
      emit(state.copyWith(addCourseState: RequestState.loaded));
      await getHomeData(context: context, userId: currentUser!.user.id);
    } else {
      emit(state.copyWith(addCourseState: RequestState.error));
    }
  }

// add Lesson
  Future addLesson(
      {context,
      courseId,
      nameAr,
      nameEng,
      descAr,
      descEng,
      link,
      image,
      unitId}) async {
    emit(state.copyWith(addLessonState: RequestState.loading));
    var data = FormData.fromMap({
      'NameAr': nameAr,
      'UnitId': unitId.toString(),
      'NameEng': nameEng,
      'DescAr': descAr,
      'DescEng': descEng,
      'LinkVidio': link,
      'Image': image,
      'teacherId': currentUser!.user.id,
      'subjectId': currentUser!.user.subjectId
    });

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Lessons/add-Lesson',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      emit(state.copyWith(addLessonState: RequestState.loaded));
      await getHomeData(context: context, userId: currentUser!.user.id);
      pop(context);
    } else {
      emit(state.copyWith(addLessonState: RequestState.error));
    }
  }

// update Lesson
  Future updateLesson(
      {context, nameAr, nameEng, descAr, descEng, link, image, unitId,id}) async {
    emit(state.copyWith(addLessonState: RequestState.loading));
    var data = FormData.fromMap({
      'NameAr': nameAr,
      'UnitId': unitId.toString(),
      'NameEng': nameEng,
      'DescAr': descAr,
      'DescEng': descEng,
      'LinkVidio': link,
      'Image': image,
      "id":id.toString()
    });

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Lessons/update-Lesson',
      options: Options(
        method: 'PUT',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}update-Lesson");
    if (response.statusCode == 200) {
      emit(state.copyWith(addLessonState: RequestState.loaded));
      await getHomeData(context: context, userId: currentUser!.user.id);
      pop(context);
    } else {
      emit(state.copyWith(addLessonState: RequestState.error));
    }
  }

// delete lesson
 Future deleteLesson({context, lessonId}) async {
    emit(state.copyWith(addCourseState: RequestState.loading));
    var data = FormData.fromMap({'LessonId': lessonId.toString()});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/Lessons/delete-Lesson',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}delete-Lesson");
    if (response.statusCode == 200) {
      showToast(msg: "تم الحذف بنجاح", color: Colors.red);
      emit(state.copyWith(addCourseState: RequestState.loaded));
      await getHomeData(context: context, userId: currentUser!.user.id);
    } else {
      emit(state.copyWith(addCourseState: RequestState.error));
    }
  }

// get image
  getImageLesson(String image) {
    emit(state.copyWith(imageLesson: image));
  }


// getQuieszBByLessonId
Future getQuizesByLessonId({context,lessonId})async{
 emit(state.copyWith(
      getQuizesByLessonState: RequestState.loading,
    ));
    var dio = Dio();
    final params = <String, dynamic>{
      'lessonId': lessonId,
    };
    var response = await dio.get(
      '${ApiConstants.baseUrl}/quiz/get-Quizs-bylesson?',
      queryParameters: params,
      options: Options(
        followRedirects: false,
        // will not throw errors
        validateStatus: (status) => true,
      ),
    );

    debugPrint("${response.statusCode} ===== get-Quizs-bylesson");
    if (response.statusCode == 200) {



      emit(state.copyWith(
        quizes: List<QuizModel>.from((response.data as List).map((e) => QuizModel.fromJson(e))),
        getQuizesByLessonState: RequestState.loaded,
      ));
    } else {
      emit(state.copyWith(
        getQuizesByLessonState: RequestState.error,
      ));
    }
}

// add quiz
  Future addQuiz(List<AnswerForAdd> answers,
      {context, descAr, descEng, type, image, lessonId}) async {
    emit(state.copyWith(addLessonState: RequestState.loading));
    var data = FormData.fromMap({
      'lessonId': lessonId.toString(),

      'DescAr': descAr,
      'DescEng': descEng,

      'Image': image,
      'Type': type.toString(), // 1 = اختياري من غير صورة  0 = '   بصورة
      'File': image
    });

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/quiz/add-Quiz',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode}add-Quiz");
    if (response.statusCode == 200) {
      QuizModel quizModel = QuizModel.fromJson(response.data);
      for (var element in answers) {
        await addAnswer(
            quizId: quizModel.id,
            textAr: element.nameAr,
            textEng: element.nameEng,
            isCorrect: element.isCorrect);
        pushPage(context, const NavigationTeacherScreen());
        //  await   getHomeData(context: context);
      }
    } else {
      emit(state.copyWith(addLessonState: RequestState.error));
    }
  }

// add answer
  Future addAnswer({quizId, textAr, textEng, isCorrect}) async {
    var data = FormData.fromMap({
      'QuizId': quizId.toString(),
      'TextAr': textAr,
      'IsCorrect': isCorrect,
      'TextEng': textEng
    });

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/answers/add-Answer',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("addAnswer");
    if (response.statusCode == 200) {
    } else {}
  }

  CourseModel? courseModel;
  SubjectModel? subjectModel;
  UnitModel? unitModel;

  changDataSelector({value, type}) {
    emit(state.copyWith(changeDataState: RequestState.loading));
    if (type == 1) {
      courseModel = value;
    } else if (type == 2) {
      unitModel = value;
    }
    emit(state.copyWith(changeDataState: RequestState.loaded));
  }

// ** upload image
  Future uploadImage() async {
    File image;
    final picker = ImagePicker();

    var pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, // <- Reduce Image quality
        maxHeight: 500, // <- reduce the image size
        maxWidth: 500);

    if (pickedFile != null) {
      image = File(pickedFile.path);

      emit(state.copyWith(imageLessonState: RequestState.loading));

      String fileName = image.path.split('/').last;
      FormData data = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          image.path,
          filename: fileName,
        ),
      });
      final response =
          await Dio().post(ApiConstants.uploadImagesPath, data: data);
      debugPrint("${response.statusCode}uploadImage");
      if (response.statusCode == 200) {
        emit(state.copyWith(
            imageLessonState: RequestState.loaded, imageLesson: response.data));
      } else {
        emit(state.copyWith(imageLessonState: RequestState.error));
      }
    }
  }
}
