import 'package:docdoc/presentation/widgets/home_widgets/sort_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/utils/colors.dart';

class SearchWidget extends StatefulWidget {
  final Function(String)? onSearchChanged;

  const SearchWidget({super.key, this.onSearchChanged});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 303,
          height: 46,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: ColorsManager.white2,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                SvgPicture.asset("assets/icons/search.svg"),
                SizedBox(width: size.width * 0.02),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    cursorColor: ColorsManager.grey,
                    onChanged: (value) {
                      if (widget.onSearchChanged != null) {
                        widget.onSearchChanged!(value);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(color: ColorsManager.lightGrey),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => const SortBottomSheet(),
            );
          },
          icon: SvgPicture.asset("assets/icons/sort.svg"),
        ),
      ],
    );
  }
}