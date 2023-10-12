// ignore_for_file: always_use_package_imports

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../example/data/models/example_user_response.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @POST('/token')
  Future<ExampleUserResponse> getUser();
}
