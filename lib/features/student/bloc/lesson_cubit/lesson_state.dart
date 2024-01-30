part of 'lesson_cubit.dart';

class LessonState extends Equatable {
  final RequestState? getLessonDetailsState;
  final RequestState? addCommentState;
  final RequestState? addEXCompletedState;
  final LessonDetailsResponse? lessonDetailsResponse;
  final RequestState? addLikedState;
  final bool isLike;

  final int idSelected;
  final int timer;
  final bool? fullScreen;

  // rate
  final RequestState? addRateState;
  final RateResponse? rateResponse;

  const LessonState({
    this.getLessonDetailsState,
    this.isLike=false,
    this.addLikedState,
    this.addCommentState,
    this.addEXCompletedState,
    this.fullScreen = false,
    this.idSelected = 0,
    this.timer = 0,
    this.lessonDetailsResponse,
    this.addRateState,
    this.rateResponse,
  });

  LessonState copyWith(
          {int? currentNavIndex,
          final RequestState? getLessonDetailsState,
          final RequestState? addLikedState,
          final bool? isLike,
          final RequestState? addCommentState,
          final LessonDetailsResponse? lessonDetailsResponse,
          final RequestState? addEXCompletedState,
          final bool? fullScreen,
          final int? timer,
          final int? idSelected,
          final RequestState? addRateState,
          final RateResponse? rateResponse}) =>
      LessonState(
        getLessonDetailsState:
            getLessonDetailsState ?? this.getLessonDetailsState,
        addLikedState: addLikedState ?? this.addLikedState,
        lessonDetailsResponse:
            lessonDetailsResponse ?? this.lessonDetailsResponse,
        addCommentState: addCommentState ?? this.addCommentState,
        fullScreen: fullScreen ?? this.fullScreen,
        idSelected: idSelected ?? this.idSelected,
        timer: timer ?? this.timer,
        addEXCompletedState: addEXCompletedState ?? this.addEXCompletedState,
        addRateState: addRateState ?? this.addRateState,
        rateResponse: rateResponse ?? this.rateResponse,
        isLike: isLike ?? this.isLike,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        getLessonDetailsState,
        lessonDetailsResponse,
        addCommentState,
        fullScreen,
        idSelected,
        addLikedState,
        isLike,
        addEXCompletedState,
        timer,
        addRateState,
        rateResponse
      ];
}
