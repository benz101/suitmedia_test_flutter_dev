import 'package:equatable/equatable.dart';

abstract class ChoosingUserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChooseUser extends ChoosingUserEvent {}


class ClearUser extends ChoosingUserEvent {}
