import 'package:cuidapet_mobile/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class HomeAppbar extends SliverAppBar {

  const HomeAppbar({
    super.key,
  }) : super(
    expandedHeight: 100,
    collapsedHeight: 100,
    pinned: true,
    elevation: 0,
    flexibleSpace: const _CuidapetAppBar(),
    iconTheme: const IconThemeData(
      color: Colors.black,
    )
  );
}

class _CuidapetAppBar extends StatelessWidget {
  const _CuidapetAppBar({super.key});

  @override
  Widget build(BuildContext context) {

    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: Colors.grey[200]!,
      )
    );

    return AppBar(
      title: const Padding(
        padding: EdgeInsets.only(
          bottom: 12,
        ),
        child: Text("Cuidapet"),
      ),
      centerTitle: true,
      backgroundColor: Colors.grey[100],
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.location_on,
            color: Colors.black,
          ),
        )
      ],
      elevation: 0,
      flexibleSpace: Stack(
        children: [
          Container(
            height: 110.h,
            color: context.primaryColor,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 0.9.sw,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(30),
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: Icon(
                      Icons.search,
                      size: 25,
                      color: Colors.grey,
                    ),
                    border: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}