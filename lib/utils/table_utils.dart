import 'package:pos/data/local_model/local_model.dart';
import 'package:pos/extensions/date_time_extension.dart';

class TableUtils {
  TableUtils._();
  static TablePos createTable({
    required String tableName,
    required String code,
    required int seats,
    required String position,
    String? imageBase64,
  }) {
    return TablePos(
      code: code,
      tableId: tableName,
      seats: seats,
      position: position,
      imageBase64: imageBase64,
      craetedAt: DateTime.now().format(),
    );
  }
}
