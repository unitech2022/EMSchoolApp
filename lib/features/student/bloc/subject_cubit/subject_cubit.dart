import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:em_school/core/enums/loading_status.dart';
import 'package:em_school/core/utlis/app_model.dart';
import 'package:em_school/features/common/models/subject_details_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utlis/api_constatns.dart';
import '../../../common/models/unit_model.dart';


part 'subject_state.dart';

class SubjectCubit extends Cubit<SubjectState> {
  SubjectCubit() : super(const SubjectState());

  static SubjectCubit get(context) => BlocProvider.of<SubjectCubit>(context);


  Future getSubjectDetails({context, subjectId}) async {
    emit(state.copyWith(
      getSubjectDetailsState: RequestState.loading,
    ));
    var dio = Dio();
    final params = <String, dynamic>{
      'subjectId': subjectId.toString(),
      "userId":currentUser!.user.id
    };
    var response = await dio.get(
        '${ApiConstants.baseUrl}/Subjects/get-subject-datails?',
        queryParameters: params);

    debugPrint("${response.statusCode} ===== getSubjectDetails");
    if (response.statusCode == 200) {
      SubjectDetailsResponse subjectDetailsResponse = SubjectDetailsResponse
          .fromJson(response.data);
      await getUnitDetails(context: context,
          courseId: subjectDetailsResponse.courses.isNotEmpty
              ? subjectDetailsResponse.courses[0].id
              : 0,
          isState: false);
      emit(state.copyWith(
        subjectDetailsResponse:subjectDetailsResponse, getSubjectDetailsState: RequestState.loaded,));
    } else {
      emit(state.copyWith(
        getSubjectDetailsState: RequestState.error,
      ));
    }
  }

List<UnitResponse>? unitResponses;

  Future getUnitDetails({context, courseId, isState = true}) async {
    if (isState) {
      emit(state.copyWith(
        getSubjectDetailsState: RequestState.loading,
      ));
    }
    var dio = Dio();
    final params = <String, dynamic>{
      'courseId': courseId.toString(),
    };
    var response = await dio.get(
        '${ApiConstants.baseUrl}/Units/get-units-bu-courseId?',
        queryParameters: params);

    debugPrint("${response.statusCode} ===== getUnitDetails");
    if (response.statusCode == 200) {

      unitResponses =List<UnitResponse>.from((response.data as List).map((e) => UnitResponse.fromJson(e)));

      if (isState) {
        emit(state.copyWith(

          getSubjectDetailsState: RequestState.loaded,));
      }
    } else {
      emit(state.copyWith(
        getSubjectDetailsState: RequestState.error,
      ));
    }
  }
}
