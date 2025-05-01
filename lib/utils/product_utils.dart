import 'package:pos/data/local_model/extra.dart';
import 'package:pos/data/local_model/local_model.dart';
import 'package:pos/extensions/date_time_extension.dart';
import 'package:uuid/uuid.dart';

class ProductUtils {
  ProductUtils._();
  static Product createProduct(
      {required String name,
      required double price,
      required String type,
      required String code,
      List<Extra>? extras}) {
    return Product(
        hiveId: Uuid().v4(),
        name: name,
        price: price,
        type: type,
        code: code,
        craetedAt: DateTime.now().format(),
        updatedAt: DateTime.now().format(),
        extras: extras);
  }
}
