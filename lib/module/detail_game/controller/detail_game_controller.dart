
import 'package:flutter/material.dart';
import 'package:game_list/core.dart';
import 'package:game_list/model/game_detail.dart';
import '../../../model/favorit_model.dart';
import '../../favorit/database_sqflite/FavDatabase.dart';
import '../view/detail_game_view.dart';

class DetailGameController extends State<DetailGameView> {
    static late DetailGameController instance;
    late DetailGameView view;

    @override
    void initState() {
        instance = this;
        getGameDetail();
        super.initState();
    }

    @override
    void dispose() => super.dispose();

    @override
    Widget build(BuildContext context) => widget.build(context, this);

    GameDetail? gameDetail;

    Future getGameDetail() async{
        setState(() {});
        gameDetail = await ApiServices().getGameDetail(id: widget.id);
        setState(() {});
    }

    bool checkExist = false;
    Color colorChecked = Colors.red;

    Future<void> removeFromFavorite(FavoriteModel favorite) async{
        try {
            setState(() {});
            await FavDatabase.instance.delete(favorite.name.toString());
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Removed from favorites')),
            );
            setState(() {
                checkExist = true;
            });
        }catch (e) {
            print(e);
        }
    }

    Future <void> addToFavorites(FavoriteModel favorite) async{
        try{
            await FavDatabase.instance.create(favorite);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Added to favorites')),
            );
            setState(() {
                checkExist = false;
            });
        }catch (e) {
            print(e);
        }
    }

    Future<bool> isFavorite(FavoriteModel favorite) async{
        bool exist = await FavDatabase.instance.read(favorite.name.toString());
        return exist;
    }

    void updateState() {
        setState(() {
            // Update your state variables here
        });
    }
}