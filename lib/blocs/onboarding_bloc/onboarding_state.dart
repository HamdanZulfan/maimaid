part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingState {}

final class OnboardingInitial extends OnboardingState {}

class OnboardingPageState extends OnboardingState {
  final int currentPage;

  OnboardingPageState(this.currentPage);
}
