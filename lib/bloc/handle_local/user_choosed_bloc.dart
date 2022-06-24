import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suitmedia_test_flutter_dev/bloc/event/choosing_user_event.dart';
import 'package:suitmedia_test_flutter_dev/model/user_choosed.dart';

class UserChoosedBloc extends Bloc<ChoosingUserEvent, UserChoosed> {
  UserChoosed userChoosed =
      UserChoosed(id: 0, email: '', firstName: '', lastName: '', avatar: '');
  UserChoosedBloc()
      : super(UserChoosed(
            id: 0, email: '', firstName: '', lastName: '', avatar: '')) {
    on<ChooseUser>((event, emit) {
      emit(UserChoosed(
          id: userChoosed.id,
          email: userChoosed.email,
          firstName: userChoosed.firstName,
          lastName: userChoosed.lastName,
          avatar: userChoosed.avatar));
    });

    on<ClearUser>((event, emit) {
      emit(UserChoosed(
          id: 0, email: '', firstName: '', lastName: '', avatar: ''));
    });
  }
}
