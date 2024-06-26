import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../services/api_service.dart';

part 'create_user_event.dart';
part 'create_user_state.dart';

class CreateUserBloc extends Bloc<CreateUserEvent, CreateUserState> {
  final ApiService apiService;

  CreateUserBloc(this.apiService) : super(CreateUserInitial()) {
    on<CreateUserEvent>((event, emit) async {
      if (event is CreateUser) {
        emit(UserLoading());
        try {
          final response = await apiService.createUser(event.name, event.job);
          if (response.statusCode == 201) {
            emit(UserSuccess());
          } else {
            emit(UserFailure('Failed to create user'));
          }
        } catch (e) {
          emit(UserFailure(e.toString()));
        }
      } else if (event is SelectJob) {
        emit(JobSelected(event.job));
      }
    });
  }
}
