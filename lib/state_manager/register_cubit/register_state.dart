import 'package:equatable/equatable.dart';
import 'package:pos/core/constants/enum.dart';

class RegisterState extends Equatable {
  final LoadStatus status;
  const RegisterState({this.status = LoadStatus.initial});
  @override
  List<Object?> get props => [status];
  RegisterState copyWith({LoadStatus? status}) {
    return RegisterState(status: status ?? this.status);
  }
}
