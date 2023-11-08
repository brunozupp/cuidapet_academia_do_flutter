import 'package:cuidapet_mobile/app/core/helpers/debouncer.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';

class HomeAppbar extends SliverAppBar {

  HomeAppbar({
    required HomeController controller,
    super.key,
  }) : super(
    expandedHeight: 100,
    collapsedHeight: 100,
    pinned: true,
    elevation: 0,
    flexibleSpace: _CuidapetAppBar(
      controller: controller,
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    )
  );
}

class _CuidapetAppBar extends StatelessWidget {
  final HomeController controller;
  final _debouncer = Debouncer(milliseconds: 500);
  
  _CuidapetAppBar({
    required this.controller,
  });

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
          onPressed: () {
            controller.goToAddressPage();
          },
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
                  onChanged: (value) {
                    _debouncer.run(() { 
                      controller.filterSupplierByName(value);
                    });
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: const Icon(
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