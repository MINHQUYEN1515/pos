import 'package:pos/data/local_model/table.dart';

abstract class ITableRepo {
  Future<List<TablePos>> getAll();
  Future<bool> insertTable(TablePos table);
  Future clear();
}
