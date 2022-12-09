import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:invoice/model/sign_response/sign_response.dart';

class ApiProvider extends GetxController {
  late Dio dio;
  static var uri = "https://ehti.onrender.com:443";
  static BaseOptions options = BaseOptions(
    baseUrl: uri,
    responseType: ResponseType.plain,
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );

  @override
  void onInit() {
    super.onInit();
    dio = Dio(options);
  }

  Future<SignResponse> signPdf(File file) async {
    Random rng = Random();
    String fileName = '${rng.nextInt(1000)}.pdf';
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    var response = await dio.post("/api/sign", data: formData);
    return SignResponse.fromJson(response.data);
  }
}
