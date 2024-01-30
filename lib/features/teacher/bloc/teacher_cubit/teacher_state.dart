part of 'teacher_cubit.dart';

class TeacherState extends Equatable {
  final HomeTeacherResponse? homeTeacherResponse;
  final RequestState getHomeTeacherState;
  final RequestState? addCourseState;
  final int currentNavIndex;
  final RequestState? changeDataState;
  final RequestState? addLessonState;
  final RequestState? imageLessonState;
  final String? imageLesson;

  const TeacherState(
      {this.imageLessonState,
      this.imageLesson, this.addLessonState,
      this.changeDataState,
      this.addCourseState,
      this.currentNavIndex = 0,
      this.homeTeacherResponse,
      this.getHomeTeacherState = RequestState.loading});

  TeacherState copyWith(
          {int? currentNavIndex,
          final RequestState? getHomeTeacherState,
          final HomeTeacherResponse? homeTeacherResponse,
          final RequestState? addCourseState,
          final RequestState? changeDataState,
            final RequestState? imageLessonState,
             final RequestState? addLessonState,
  final String? imageLesson
          
          }) =>
      TeacherState(
          currentNavIndex: currentNavIndex ?? this.currentNavIndex,
          getHomeTeacherState: getHomeTeacherState ?? this.getHomeTeacherState,
          homeTeacherResponse: homeTeacherResponse ?? this.homeTeacherResponse,
          addCourseState: addCourseState ?? this.addCourseState,
          changeDataState: changeDataState ?? this.changeDataState,
               imageLessonState: imageLessonState ?? this.imageLessonState,
          imageLesson: imageLesson ?? this.imageLesson,
           addLessonState: addLessonState ?? this.addLessonState
          
          );

  @override
  // TODO: implement props
  List<Object?> get props => [
        currentNavIndex,
        homeTeacherResponse,
        getHomeTeacherState,
        addCourseState,
        changeDataState,
        imageLesson,imageLessonState,addLessonState
      ];
}
