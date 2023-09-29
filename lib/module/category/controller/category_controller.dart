
import 'package:flutter/material.dart';
import 'package:game_list/core.dart';
import '../../../model/list_model.dart';
import '../../../service/game/games_service.dart';
import '../view/category_view.dart';

class CategoryController extends State<CategoryView> {
    static late CategoryController instance;
    late CategoryView view;

    @override
    void initState() {
        instance = this;
        super.initState();
    }

    @override
    void dispose() => super.dispose();

    @override
    Widget build(BuildContext context) => widget.build(context, this);

}
        
    