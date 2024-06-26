part of 'create_user_bloc.dart';

@immutable
sealed class CreateUserEvent {}

class CreateUser extends CreateUserEvent {
  final String name;
  final String job;

  CreateUser(this.name, this.job);
}

class SelectJob extends CreateUserEvent {
  final String job;

  SelectJob(this.job);
}
