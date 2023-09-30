
import 'package:flutter/material.dart';
import 'package:game_list/core.dart';
import 'package:game_list/model/list_model.dart';
import '../../../model/favorit_model.dart';
import '../database_sqflite/FavDatabase.dart';
import '../view/favorit_view.dart';

class FavoritController extends State<FavoritView> {
    static late FavoritController instance;
    late FavoritView view;

    @override
    void initState() {
        instance = this;
        super.initState();
        print("1");
        read();
        print("1");
    }

    @override
    void dispose() => super.dispose();

    @override
    Widget build(BuildContext context) => widget.build(context, this);

    List<FavoriteModel> dataListFavorite = [];
    bool isLoading = false;
    List<Results> results = [];

    Future read() async {
        setState(() {
            isLoading = true;
        });
        dataListFavorite = await FavDatabase.instance.readAll();
        print("Length List " + dataListFavorite.length.toString());
        setState(() {
            isLoading = false;
        });
    }

    Future<void> refresh() async {
        await read();
    }

    showDeleteDialog(BuildContext context, String? name) {
        Widget cancelButton = TextButton(
            child: Text("Tidak"),
            onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
            }
        );
        Widget okButton = TextButton(
            child: Text("Hapus"),
            onPressed: () async {
                setState(() {});
                await FavDatabase.instance.delete(name);
                read();
                setState(() {});
                Navigator.push(context, MaterialPageRoute(builder:(context) => HomeView()));
                Navigator.pop(context);
                Navigator.of(context, rootNavigator: true).pop('dialog');

            });

        AlertDialog alert = AlertDialog(
            content: Text("Apakah anda yakin ingin menghapus?"),
            actions: [cancelButton, okButton],
        );

        showDialog(
            context: context,
            builder: (BuildContext context) {
                return alert;
            },
        );
    }
}