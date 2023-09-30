
import 'package:flutter/material.dart';
import 'package:game_list/core.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import '../controller/main_navigation_controller.dart';

class MainNavigationView extends StatefulWidget {
    final int halamanke;
    const MainNavigationView({Key? key, required this.halamanke}) : super(key: key);

    Widget build(context, MainNavigationController controller) {
    controller.view = this;

    return Scaffold(
        body: Column(
            children: <Widget>[
                Expanded(
                    child: PageView(
                        physics:  NeverScrollableScrollPhysics(),
                        controller: controller.pageController,
                        children: controller.listOfWidget,
                    ),
                ),
            ],
        ),
        bottomNavigationBar: SlidingClippedNavBar(
            backgroundColor: Colors.white,
            onButtonPressed: controller.onButtonPressed,
            iconSize: 30,
            activeColor: const Color(0xFF01579B),
            selectedIndex: controller.selectedIndex,
            barItems: <BarItem>[
                BarItem(
                    icon: Icons.home,
                    title: 'Home',
                ),
                BarItem(
                    icon: Icons.favorite,
                    title: 'Favorite',
                ),
            ],
        ),
    );
    }

    @override
    State<MainNavigationView> createState() => MainNavigationController();
}
    