import 'dart:convert';

import 'package:game_list/model/game_detail.dart';
import 'package:http/http.dart' as http;

import '../../model/list_model.dart';

class ApiServices {
  static String _apiKey = "bb420a041cac4586b10205de382a5166";

  Future getGameList() async{
    try{
      final response = await http.get(
        Uri.parse("https://api.rawg.io/api/games?key=$_apiKey"),
      );
    if(response.statusCode == 200){
      GameList gamesList = GameList.fromJson(jsonDecode(response.body));
      print(response.body);
      return gamesList;
    } else{
      throw Exception("Failed to load data");
    }
    } catch(e){
      print(e.toString());
    }
    }

    Future getGameDetail({required String id}) async{
    try{
      final response = await http.get(
      Uri.parse("https://api.rawg.io/api/games/$id?key=$_apiKey"),
      );
      if(response.statusCode == 200){
        GameDetail gameDetail = GameDetail.fromJson(jsonDecode(response.body));
        print(response.body);
        return gameDetail;
      } else{
        throw Exception("Failed to load data");
      }
    } catch(e){
      print(e.toString());
    }
  }

  // Future<List> getGamesList() async {
  //   var response = await Dio().get(_url);
  //   Map obj = response.data;
  //   return obj["results"];
  // }

// Future <List<GamesList>> getGameList() async{
//   final response = await http.get(Uri.parse(_url));
//   if(response.statusCode == 200){
//     final decodeData = jsonDecode(response.body)['results'] as List;
//     print(decodeData);
//     return decodeData.map((game) => GamesList.fromJson(game)).toList();
//   }else{
//     throw Exception("Failed to load data");
//   }
// }

}