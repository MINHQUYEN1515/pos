import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:get_it/get_it.dart';
import 'package:pos/core/constants/local_constants.dart';
import 'package:pos/data/local_model/local_model.dart';
import 'package:pos/data/repositories/interface/iauth_repo.dart';
import 'package:pos/data/repositories/interface/iorder_item.dart';
import 'package:pos/data/repositories/interface/iproduct_repo.dart';
import 'package:pos/data/repositories/interface/table_repo.dart';
import 'package:pos/server/request/order_temp_request.dart';
import 'package:pos/server/routes/route.dart';
import 'package:pos/utils/logger.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:uuid/uuid.dart';

import 'reponse/reponse.dart';

class Server {
  static final Server instane = Server._internal();
  factory Server() => instane;
  Server._internal();
  static final _route = Router();
  late final ITableRepo _table = GetIt.I.get<ITableRepo>();
  late final IProductRepo _product = GetIt.I.get<IProductRepo>();
  late final IAuthRepo _auth = GetIt.I.get<IAuthRepo>();
  late final IOrderItemRepo _orderItemRepo = GetIt.I.get<IOrderItemRepo>();
  void initRoutes() async {
    //LOGIN

    _route.post(RouteConstants.login, (Request request) async {
      final body = await request.readAsString();
      final data = jsonDecode(body);
      logger.i(data);
      final username = data['username'];
      final password = data['password'];
      final permission = data['permission'];
      if (permission != 'User') {
        ResponseData responseData = ResponseData(
            status: true, data: "CHỈ CÓ USER MỚI ĐƯỢC ĐĂNG NHẬP", message: "");
        return Response.unauthorized(jsonEncode(responseData), headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
        });
      }
      bool user = await _auth.login(
          user: UserLocal(username: username, password: password));
      if (user) {
        ResponseData responseData = ResponseData(
            status: true,
            data: UserLocal(
                    username: username,
                    password: password,
                    permission: Permission.user)
                .toJson(),
            message: "LOGIN SUCCESS");
        return Response.ok(jsonEncode(responseData), headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
        });
      } else {
        ResponseData responseData =
            ResponseData(status: false, data: "FAILD", message: "LOGIN FAILD");
        return Response.unauthorized(jsonEncode(responseData), headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
        });
      }
    });

    // GET TABLE
    _route.get(RouteConstants.table, (Request request) async {
      try {
        List<TablePos> tables = await _table.getAll();
        final tablesJson = tables.map((t) => t.toJson()).toList();
        ResponseData responseData =
            ResponseData(status: true, data: tablesJson, message: "Success");
        return Response.ok(jsonEncode(responseData), headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
        });
      } catch (e) {
        logger.e(e);
        return Response.notFound("NOT DATA");
      }
    });
    //GET PRODUCT
    _route.get(RouteConstants.product, (req) async {
      try {
        List<Product> products = await _product.getAll();
        final productJson = products.map((e) => e.toJson()).toList();
        ResponseData responseData =
            ResponseData(status: true, data: productJson, message: "Success");
        return Response.ok(jsonEncode(responseData), headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
        });
      } catch (e) {
        logger.e(e);
        return Response.notFound("NOT DATA");
      }
    });
    //FILLTER TABLE
    _route.post(RouteConstants.fillterTable, (Request request) async {
      try {
        final body = await request.readAsString();
        final data = jsonDecode(body);
        logger.i(data);
        final fillter = data['fillter'];
        var table = await _table.getAll();
        table = table.where((e) => e.position == fillter).toList();
        final tablesJson = table.map((t) => t.toJson()).toList();
        ResponseData responseData =
            ResponseData(status: true, data: tablesJson, message: "Success");
        return Response.ok(jsonEncode(responseData), headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
        });
      } catch (e) {
        logger.e(e);
        return Response.notFound("NOT DATA");
      }
    });
    //GET ORDER_TEMP
    _route.get(RouteConstants.orderTemp + '/<id>', (Request req) async {
      try {
        String id = req.params['id'].toString();
        var orderTemp = await _orderItemRepo.getAll();

        orderTemp = orderTemp.where((e) => e.tableId.toString() == id).toList();
        logger.i(orderTemp);

        final orderTempJson = orderTemp.map((t) => t.toJson()).toList();
        ResponseData responseData =
            ResponseData(status: true, data: orderTempJson, message: "Success");
        return Response.ok(jsonEncode(responseData), headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
        });
      } catch (e) {
        logger.e(e);
        return Response.notFound("NOT DATA");
      }
    });
    // POST ORDER_TEMP
    _route.post(RouteConstants.createOrderTemp, (Request req) async {
      try {
        final body = await req.readAsString();
        final data = jsonDecode(body);
        OrderTempRequest request = OrderTempRequest.fromJson(data);
        var temp = await _orderItemRepo.findOrder(
            productId: request.orderItem.product!.code!,
            tableId: request.tableId);
        temp = temp?.position == request.position ? temp : null;
        if (temp == null) {
          await _orderItemRepo.insertData(request.orderItem);
        } else {
          temp.quantity = temp.quantity! + 1;
          temp.totalAmount = temp.quantity! * temp.product!.price!;
          List<Extra> _extraTemp = [];
          _extraTemp.addAll(temp.extras ?? []);
          _extraTemp.addAll(request.orderItem.extras ?? []);

          var grouped = groupBy(_extraTemp, (Extra p) => p.name);
          // Gộp lại thành danh sách mới chỉ chứa 1 item mỗi category với tổng tiền
          List<Extra> result = grouped.entries.map((entry) {
            String? name = entry.key;
            double total =
                entry.value.fold(0, (sum, p) => sum + (p.price * p.quantity));
            int quantity = entry.value.fold(0, (sum, p) => sum + p.quantity);
            return Extra(
                hiveId: Uuid().v4(),
                name: name,
                quantity: quantity,
                total: total,
                price:
                    entry.value.first.price); // dùng tên category luôn cho name
          }).toList();
          temp = temp.copyWith(extras: result);
          await _orderItemRepo.updateOrder(order: temp);
        }
        ResponseData responseData = ResponseData(
            status: true,
            data: "CREATE ORDER TEMP SUCCESS",
            message: "Success");
        return Response.ok(jsonEncode(responseData), headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
        });
      } catch (e) {
        logger.e(e);
        return Response.notFound("NOT DATA");
      }
    });
    //POST ORDER
    _route.post(RouteConstants.order, (Request req) async {
      try {
        final body = await req.readAsString();
        final json = jsonDecode(body);
        TablePos? table = TablePos.fromJson(json['table']);
        if (table == null) return false;
        var data = await _orderItemRepo.getAll();
        data = data.where((e) => e.tableId == table.tableId).toList();
        double _price = 0;
        data.forEach((e) {
          _price += e.totalAmount!;
          e.extras?.forEach((ele) {
            _price += ele.total!;
          });
        });

        table.status = AppConstants.TABLE_USING;
        table.amount = _price;
        table.userName = json['username'];
        await _table.updateTable(table: table);
        ResponseData responseData = ResponseData(
            status: true,
            data: "CREATE ORDER TEMP SUCCESS",
            message: "Success");
        return Response.ok(jsonEncode(responseData), headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
        });
      } catch (e) {
        logger.e(e);
        return Response.notFound("NOT DATA");
      }
    });
    // Gói middleware + handler
    final handler =
        const Pipeline().addMiddleware(logRequests()).addHandler(_route.call);

    final server = await serve(handler, InternetAddress.anyIPv4, 8080);
    logger
        .i('🚀 API đang chạy tại http://${server.address.host}:${server.port}');
  }
}
