import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../models/user_model.dart';
import '../../services/api_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ApiService apiService;

  UserBloc(this.apiService) : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<DeleteUser>(_onDeleteUser);
    on<FetchUserDetail>(_onFetchUserDetail);
    on<UpdateUser>(_onUpdateUser);
  }

  void _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());

    try {
      final users = await apiService.fetchUsers();
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  void _onDeleteUser(DeleteUser event, Emitter<UserState> emit) async {
    emit(UserDeleting());

    try {
      await apiService.deleteUser(event.userId);
      emit(UserDeleteSuccess());
      add(FetchUsers()); // Refresh the user list after deletion
    } catch (e) {
      emit(UserDeleteFailure(e.toString()));
    }
  }

  void _onFetchUserDetail(
      FetchUserDetail event, Emitter<UserState> emit) async {
    emit(UserLoading());

    try {
      final user = await apiService.fetchUserDetail(event.userId);
      emit(UserDetailLoaded(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  void _onUpdateUser(UpdateUser event, Emitter<UserState> emit) async {
    emit(UserUpdating());

    try {
      await apiService.updateUser(event.userId, event.data);
      emit(UserUpdateSuccess());
      add(FetchUsers()); // Refresh the user list after update
    } catch (e) {
      emit(UserUpdateFailure(e.toString()));
    }
  }
}
