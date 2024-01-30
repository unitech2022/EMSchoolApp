import 'package:dio/dio.dart';
import 'package:em_school/core/enums/loading_status.dart';
import 'package:em_school/core/utlis/api_constatns.dart';
import 'package:em_school/features/common/models/home_responnse.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utlis/app_model.dart';
part 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  StudentCubit() : super(const StudentState());

  static StudentCubit get(context) => BlocProvider.of<StudentCubit>(context);

  changeCurrentIndexNav(int newIndex) {
    emit(state.copyWith(currentNavIndex: newIndex));
  }

  Future getHomeData({context, userId}) async {
    emit(state.copyWith(
      getHomeUserState: RequestState.loading,
    ));
    var dio = Dio();
    final params = <String, dynamic>{
      'userId': userId,
    };
    var response = await dio.get('${ApiConstants.baseUrl}/home/get-hoeme-user?',
        queryParameters: params,
      options: Options(

        followRedirects: false,
        // will not throw errors
        validateStatus: (status) => true,

      ),
    );

    debugPrint("${response.statusCode} ===== getHomeData");
    if (response.statusCode == 200) {
  HomeResponse homeResponse=    HomeResponse.fromJson(response.data);
    favFound.clear();

      for (var element in homeResponse.favorites) {
        favFound
            .addAll({element.lessonId: element.lessonId});
      }


      emit(state.copyWith(
          homeResponse: homeResponse,    getHomeUserState: RequestState.loaded,));
    } else {
      emit(state.copyWith(
        getHomeUserState: RequestState.error,
      ));
    }
  }
}
