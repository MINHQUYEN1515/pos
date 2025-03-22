import 'package:pos/data/local_model/table.dart';

abstract class ITableRepo {
  Future<List<Table>> getAll();
  Future<bool> insertTable(Table table);
}
