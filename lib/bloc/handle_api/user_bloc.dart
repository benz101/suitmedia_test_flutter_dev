import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suitmedia_test_flutter_dev/bloc/event/user_event.dart';
import 'package:suitmedia_test_flutter_dev/bloc/state/user_state.dart';
import 'package:suitmedia_test_flutter_dev/model/user.dart';
import 'package:suitmedia_test_flutter_dev/service/api_service.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  int page = 1;
  final APIService _apiService = APIService();
  UserBloc() : super(UserInitiation()) {
    on<GetUserList>((event, emit) async {
      emit(UserLoading());
      try {
        final response = await _apiService.getUserList(1, 10);
        emit(UserSuccess(response));
      } catch (e) {
        emit(UserError(User(
            page: 0,
            perPage: 0,
            total: 0,
            totalPages: 0,
            data: [],
            support: Support(url: '', text: ''))));
      }
    });

    on<GetMoreUserList>((event, emit) async {
      emit(UserMoreLoading());
      try {
        final response = await _apiService.getUserList(page, 10);
        emit(UserMoreSuccess(response));
      } catch (e) {
        emit(UserMoreError(User(
            page: 0,
            perPage: 0,
            total: 0,
            totalPages: 0,
            data: [],
            support: Support(url: '', text: ''))));
      }
    });
  }
}
