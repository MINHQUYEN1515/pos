import 'package:pos/data/local_model/table.dart';
import 'package:pos/data/repositories/interface/table_repo.dart';
import 'package:pos/data/service/interface/table_service.dart';
import 'package:pos/utils/logger.dart';

class TableRepo extends ITableRepo {
  late ITableService _tableService;
  TableRepo(this._tableService);
  @override
  Future<List<TablePos>> getAll() async {
    List<TablePos> _temp = [];
    try {
      _temp = await _tableService.getAll();
    } catch (e) {
      logger.e(e);
    }
    return _temp;
  }

  @override
  Future<bool> insertTable(TablePos table) async {
    try {
      await _tableService.insert(table);
      return true;
    } catch (e) {
      logger.e(e);
    }
    return false;
  }

  @override
  Future clear() async {
    try {
      await _tableService.clear();
    } catch (e) {
      logger.e(e);
    }
  }
}
