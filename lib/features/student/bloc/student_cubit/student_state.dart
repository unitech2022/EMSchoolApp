part of 'student_cubit.dart';

class StudentState extends Equatable {


  final int currentNavIndex;
  final RequestState? getHomeUserState;
  final HomeResponse? homeResponse;


  const StudentState({this.currentNavIndex =2,this.getHomeUserState ,this.homeResponse});

  StudentState copyWith({
    int? currentNavIndex,
    final RequestState? getHomeUserState,

    final HomeResponse? homeResponse,
  }) =>
      StudentState(

          currentNavIndex: currentNavIndex ?? this.currentNavIndex,
          homeResponse: homeResponse ?? this.homeResponse
          ,  getHomeUserState: getHomeUserState ?? this.getHomeUserState

      );

  @override
  // TODO: implement props
  List<Object?> get props => [currentNavIndex,getHomeUserState,homeResponse];
}
