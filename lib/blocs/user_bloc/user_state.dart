part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;

  UserLoaded(this.users);
}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}

class UserDeleting extends UserState {}

class UserDeleteSuccess extends UserState {}

class UserDeleteFailure extends UserState {
  final String error;

  UserDeleteFailure(this.error);
}

class UserDetailLoaded extends UserState {
  final User user;

  UserDetailLoaded(this.user);
}

class UserUpdating extends UserState {}

class UserUpdateSuccess extends UserState {}

class UserUpdateFailure extends UserState {
  final String error;

  UserUpdateFailure(this.error);
}
