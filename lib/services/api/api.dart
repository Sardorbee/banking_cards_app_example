import 'package:dio/dio.dart';

import '../model/card_model.dart';


class CardService {
  static Future<List<CardModel>?> fetchdata() async {
    Response response = await Dio().get('https://banking-api.free.mockoapp.net/user_cards');
    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      return data.map((item) => CardModel.fromJson(item)).toList();
    } else {
      throw Exception("Network Error");
    }
  }
}