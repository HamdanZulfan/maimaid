import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingPageState(0)) {
    on<NextPageEvent>((event, emit) {
      final nextPage = (state as OnboardingPageState).currentPage + 1;
      emit(OnboardingPageState(nextPage));
    });
    on<PrevPageEvent>((event, emit) {
      final prevPage = (state as OnboardingPageState).currentPage - 1;
      emit(OnboardingPageState(prevPage));
    });
  }
}
