
import 'package:flutter/material.dart';

import '../../../core/utils/colors.dart';


class TabBarWidget extends StatefulWidget {
  const TabBarWidget({super.key});

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TabBar(
            indicator: UnderlineTabIndicator(
              borderSide:
              BorderSide(color: ColorsManager.blue, width: 3),
              insets: EdgeInsets.symmetric(horizontal: 70),
            ),
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: ColorsManager.blue,
            unselectedLabelColor: ColorsManager.grey,
            dividerHeight: 1,
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            tabs: [
              Tab(text: "About"),
              Tab(text: "Location"),
              Tab(text: "Reviews"),
            ],
          ),
        ),


      ],
    );
  }
}