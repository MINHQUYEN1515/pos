import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/data/local_model/table.dart';
import 'package:pos/data/repositories/interface/table_repo.dart';
import 'package:pos/state_manager/setting_cubit/setting_state.dart';
import 'package:pos/ui/widgets/dialog/app_dialog.dart';
import 'package:pos/utils/logger.dart';
import 'package:pos/utils/table_utils.dart';

class SettingCubit extends Cubit<SettingState> {
  final ITableRepo _tableRepo;
  SettingCubit(this._tableRepo) : super(SettingState());
  void craeteTable({
    required String tableName,
    required String code,
    required int seats,
    required String position,
    String? imageBase64,
  }) async {
    emit(state.copyWith(status: LoadStatus.loading));
    Table table = TableUtils.createTable(
        tableName: tableName, code: code, seats: seats, position: position);

    try {
      await _tableRepo.insertTable(table);
      emit(state.copyWith(status: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
      logger.e(e);
      AppDialog.defaultDialog(message: "Vui lòng nhập đúng định dạng");
    }
  }
}
