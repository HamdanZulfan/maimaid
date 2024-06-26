part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class FetchUsers extends UserEvent {}

class DeleteUser extends UserEvent {
  final String userId;

  DeleteUser(this.userId);
}

class FetchUserDetail extends UserEvent {
  final String userId;

  FetchUserDetail(this.userId);
}

class UpdateUser extends UserEvent {
  final String userId;
  final Map<String, dynamic> data;

  UpdateUser(this.userId, this.data);
}
