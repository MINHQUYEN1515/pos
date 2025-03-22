import 'package:equatable/equatable.dart';
import 'package:pos/core/constants/enum.dart';

class SettingState extends Equatable {
  final LoadStatus status;
  const SettingState({this.status = LoadStatus.initial});
  @override
  List<Object?> get props => [status];

  SettingState copyWith({LoadStatus? status}) {
    return SettingState(status: status ?? this.status);
  }
}
