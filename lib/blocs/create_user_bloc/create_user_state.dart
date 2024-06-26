part of 'create_user_bloc.dart';

@immutable
sealed class CreateUserState {}

final class CreateUserInitial extends CreateUserState {}

class UserLoading extends CreateUserState {}

class UserSuccess extends CreateUserState {}

class UserFailure extends CreateUserState {
  final String error;

  UserFailure(this.error);
}

class JobSelected extends CreateUserState {
  final String job;

  JobSelected(this.job);
}
