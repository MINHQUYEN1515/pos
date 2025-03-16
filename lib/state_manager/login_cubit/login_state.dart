import 'package:equatable/equatable.dart';
import 'package:pos/core/constants/enum.dart';

class LoginState extends Equatable {
  final LoadStatus status;
  const LoginState({this.status = LoadStatus.initial});
  @override
  List<Object?> get props => [status];
  LoginState copyWith({LoadStatus? status}) {
    return LoginState(status: status ?? this.status);
  }
}
