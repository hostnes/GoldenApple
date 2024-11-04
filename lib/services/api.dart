import 'dart:io';

import 'package:dio/dio.dart';

class ConnectServer {
  // static var base_url = 'http://31.128.42.158:8003/api/';
  static var base_url = 'http://127.0.0.1:8000/api/';

  static Dio dio = Dio();

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // COMMON
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////

  static Future<List<dynamic>> auth(email, pass) async {
    String url = '${base_url}users/?email=${email}&password=${pass}';
    Response response = await dio.get(url);
    List<dynamic> responseData = response.data;
    return responseData;
  }

  static Future<Map<String, dynamic>> register(email, pass, pass2) async {
    var body = {'email': email, 'password': pass, "password2": pass2};
    String url = '${base_url}users/';
    Response response = await dio.post(url, data: body);
    Map<String, dynamic> responseData = response.data;
    return responseData;
  }

  static Future<List<Map<String, dynamic>>> getPosts() async {
    String url = '${base_url}posts/';
    Response response = await Dio().get(url);
    List<dynamic> responseData = response.data;

    List<Map<String, dynamic>> posts =
        responseData.map((data) => Map<String, dynamic>.from(data)).toList();

    return posts;
  }

  static Future<Map<String, dynamic>> postPost(FormData body) async {
    String url = '${base_url}posts/';
    Response response = await dio.post(url, data: body);
    Map<String, dynamic> responseData = response.data;
    return responseData;
  }

  static Future<List<Map<String, dynamic>>> getUsers(user_id) async {
    String url = '${base_url}users/?owner_id=$user_id';
    Response response = await dio.get(url);
    List<dynamic> responseData = response.data;
    List<Map<String, dynamic>> users =
        responseData.map((data) => Map<String, dynamic>.from(data)).toList();
    return users;
  }

  static Future<Map<String, dynamic>> likeUser(user_id, target_user_id) async {
    String url = '${base_url}like/';
    Response response = await dio.post(url,
        data: {"user_id": user_id, "target_user_id": target_user_id});
    Map<String, dynamic> responseData = response.data;
    return responseData;
  }

  static void unlikeUser(userLikeId) async {
    String url = '${base_url}like/$userLikeId/';
    Response response = await dio.delete(url);
  }

  static void offLike(userLikeId) async {
    String url = '${base_url}like/$userLikeId/';
    Response response = await dio.patch(url, data: {'is_already_liked': "True"});
  }

  static Future<List<Map<String, dynamic>>> myLikes(user_id) async {
    String url = '${base_url}likes/received/?user_id=$user_id';
    Response response = await dio.get(url);
    List<dynamic> responseData = response.data;
    List<Map<String, dynamic>> users =
        responseData.map((data) => Map<String, dynamic>.from(data)).toList();
    return users;
  }

  static Future<List<dynamic>> myMatches(user_id) async {
    String url = '${base_url}matches/?user_id=$user_id';
    Response response = await dio.get(url);
    List<dynamic> responseData = response.data;
    List<Map<String, dynamic>> users =
        responseData.map((data) => Map<String, dynamic>.from(data)).toList();
    return users;
  }
}
