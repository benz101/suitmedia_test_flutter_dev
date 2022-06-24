import 'package:equatable/equatable.dart';
import 'package:suitmedia_test_flutter_dev/model/user.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitiation extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final User user;
  const UserSuccess(this.user);
}

class UserError extends UserState {
  final User user;
  const UserError(this.user);
}

class UserMoreLoading extends UserState {}

class UserMoreSuccess extends UserState {
  final User user;
  const UserMoreSuccess(this.user);
}

class UserMoreError extends UserState {
  final User user;
  const UserMoreError(this.user);
}
