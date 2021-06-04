import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomBottomAppBarItem {
  CustomBottomAppBarItem(
      {required this.icon, required this.title, this.key, this.hasNew = false});

  IconData icon;
  String title;
  bool hasNew;
  dynamic key;
}

// ignore: must_be_immutable
class CustomBottomAppBar extends StatefulWidget {
  CustomBottomAppBar({
    this.items,
    this.height: 50.0,
    this.iconSize: 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.onTabSelected,
    this.currentIndex,
  });

  final List<CustomBottomAppBarItem>? items;
  final double height;
  final double iconSize;
  final Color? backgroundColor;
  final Color? color;
  final Color? selectedColor;
  final ValueChanged<int?>? onTabSelected;
  int? currentIndex;

  @override
  State<StatefulWidget> createState() => CustomBottomAppBarState();
}

class CustomBottomAppBarState extends State<CustomBottomAppBar>
    with SingleTickerProviderStateMixin {
  Orientation? orientation;

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items!.length, (int index) {
      return _buildTabItem(
        item: widget.items![index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Divider(
            height: 0,
            color: Colors.black87,
            thickness: 0.2,
          ),
          Stack(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: items,
              ),
            ],
          ),
        ],
      ),
      color:
          widget.backgroundColor ?? Theme.of(context).bottomAppBarTheme.color,
    );
  }

  Widget _buildTabItem({
    required CustomBottomAppBarItem item,
    int? index,
    ValueChanged<int?>? onPressed,
  }) {
    Color? color =
        widget.currentIndex == index ? widget.selectedColor : widget.color;
    IconData icon = item.icon;
    String title = item.title;
    List<Widget> content = [
      Column(
        children: [Icon(icon, color: color), title.text.color(color!).make()],
      ),
    ];
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: GestureDetector(
          onTap: () => onPressed!(index),
          child: AnimatedContainer(
            key: item.key,
            duration: Duration(seconds: 2),
            decoration: BoxDecoration(),
            child: (GetPlatform.isMobile)
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: content,
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: content,
                  ),
          ),
        ),
      ),
    );
  }

  _updateIndex(int? index) {
    widget.onTabSelected!(index);

    setState(() {
      widget.currentIndex = index;
    });
  }
}
