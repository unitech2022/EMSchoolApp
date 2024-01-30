part of 'subject_cubit.dart';

class SubjectState extends Equatable {
  final RequestState? getSubjectDetailsState;
  final SubjectDetailsResponse? subjectDetailsResponse;
  final UnitResponse? unitResponse;

  const SubjectState(
      { this.getSubjectDetailsState,this.unitResponse,
       this.subjectDetailsResponse});

  SubjectState copyWith(
          {int? currentNavIndex,
          final RequestState? getSubjectDetailsState,
            final UnitResponse? unitResponse,
          final SubjectDetailsResponse? subjectDetailsResponse}) =>
      SubjectState(
          getSubjectDetailsState:
              getSubjectDetailsState ?? this.getSubjectDetailsState,
          unitResponse:
          unitResponse ?? this.unitResponse,
          subjectDetailsResponse:
              subjectDetailsResponse ?? this.subjectDetailsResponse);

  @override
  // TODO: implement props
  List<Object?> get props => [getSubjectDetailsState, subjectDetailsResponse,unitResponse];
}
