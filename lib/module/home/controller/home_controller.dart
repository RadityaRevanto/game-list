
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
        scrollController.addListener(() {
            double offset = scrollController.offset;
            double maxOffset = scrollController.position.maxScrollExtent;
            print("offset:  ${offset}");
            print("maxOffset ${maxOffset}");
            if(offset == maxOffset){
                nextPage();
            }
            // if (offset >= maxOffset * 0.7){
            //         nextPage();
            // }
        });
        super.initState();
    }

    @override
    void dispose() {
        super.dispose();
    }

    @override
    Widget build(BuildContext context) => widget.build(context, this);

    GameList? gamesList;

    int page = 1;
    ScrollController scrollController = ScrollController();
    bool loading = false;

    nextPage() async {
        page++;
        loading = true;
        gamesList = await ApiServices().getGameList(page: page);
        if (gamesList == null) {
            print("data kosong atau tidak lengkap");
        } else {
            print(gamesList.toString());
            List<Map<String, dynamic>> newGames = gamesList!.results?.map((data) {
                return {
                    'id': data.id.toString(),
                    'name': data.name.toString(),
                    'slug': data.slug.toString(),
                    'released': data.released.toString(),
                    'image': data.backgroundImage.toString(),
                };
            }).toList() ?? [];
            allGames.addAll(newGames); // Tambahkan data baru ke dalam allGames
        }
        setState(() {
            isloaded = true;
        });
    }




    getGamesList() async {
        gamesList = await ApiServices().getGameList(page: page);
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