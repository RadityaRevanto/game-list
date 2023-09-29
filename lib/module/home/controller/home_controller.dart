
import 'package:flutter/material.dart';
import 'package:game_list/core.dart';
import 'package:game_list/model/list_model.dart';
import 'package:game_list/service/game/games_service.dart';
import '../view/home_view.dart';

class HomeController extends State<HomeView> {
    static late HomeController instance;
    late HomeView view;

    List<Map<String, dynamic>> allGames = [];
    List<Map<String, dynamic>> foundGames= [];
    bool isloaded = true;

    @override
    void initState() {
        instance = this;
        getGamesList();
        super.initState();
    }

    @override
    void dispose() {
        super.dispose();
    }

    @override
    Widget build(BuildContext context) => widget.build(context, this);

    GameList? gamesList;
    getGamesList() async {
        gamesList = await ApiServices().getGameList();
        if (gamesList == null) {
            print("data kosong atau tidak lengkap");
        } else {
            print(gamesList.toString());
            allGames = gamesList!.results?.map((data) {
                return {
                    'id': data.id.toString(),
                    'name': data.name.toString(),
                    'slug': data.slug.toString(),
                    'released': data.released.toString(),
                    'image': data.backgroundImage.toString(),
                };
            }).toList() ?? [];
            foundGames = allGames;
        }
        setState(() {
            isloaded = true;
        });
        setState(() {});
    }
    void runFilters(String enteredKeyword) {
        List<Map<String, dynamic>> results = [];
        if (enteredKeyword.isEmpty) {
            results = allGames;
        } else {
            results = allGames
                .where((user) =>
                user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
                .toList();
        }
        setState(() {
            foundGames = results;
        });
    }
}