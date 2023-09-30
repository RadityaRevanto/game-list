
import 'package:flutter/material.dart';
import 'package:game_list/core.dart';
import '../view/main_navigation_view.dart';

class MainNavigationController extends State<MainNavigationView> {
    static late MainNavigationController instance;
    late MainNavigationView view;

    @override
    void initState() {
        instance = this;
        super.initState();
        int requestindex=widget.halamanke;
        print( "nilai awal selectedIndex $selectedIndex");
        switch(requestindex){
            case 0:selectedIndex=selectedIndex; break;
            case 1:selectedIndex= selectedIndex+ widget.halamanke;break;
            case 2:selectedIndex= selectedIndex+ widget.halamanke;break;
            case 3:selectedIndex= selectedIndex+ widget.halamanke;break;

        }
        pageController = PageController(initialPage: widget.halamanke);

    }

    @override
    void dispose() => super.dispose();

    @override
    Widget build(BuildContext context) => widget.build(context, this);

    // int selectedIndex = 0;
    // updateIndex(int newIndex) {
    //     selectedIndex = newIndex;
    //     setState(() {});
    // }

    void onButtonPressed(int index) {
        print(index);
        setState(() {
            selectedIndex = index;
            print("selected index :$selectedIndex");
            print("selected index 2:$selectedIndex");

        });
        pageController.animateToPage(selectedIndex,
            duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
    }

    late PageController pageController;
    int selectedIndex = 0;
    bool colorful = false;

    List<Widget> listOfWidget = <Widget>[
        HomeView(), //0
        FavoritView(),//1
    ];

}
        
    