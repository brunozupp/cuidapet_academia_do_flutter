import 'dart:async';
import 'package:cuidapet_mobile/app/core/life_cycle/page_life_cycle_state.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:cuidapet_mobile/app/modules/address/address_controller.dart';
import 'package:cuidapet_mobile/app/modules/address/widgets/address_search_widget/address_search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

part 'widgets/address_item.dart';
part 'widgets/address_search_widget/address_search_widget.dart';

class AddressPage extends StatefulWidget {

  const AddressPage({ Key? key }) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends PageLifeCycleState<AddressController, AddressPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: context.primaryColorDark,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            children: [
              Text(
                "Adicione ou escolha um endereço",
                style: context.textTheme.headlineMedium?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _AddressSearchWidget(
                searchResultCallback: (PlaceModel place) {
                  controller.goToAddressDetail(place);
                },
              ),
              const SizedBox(
                height: 30,
              ),
              ListTile(
                onTap: () {
                  controller.myLocation();
                },
                leading: const CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 30,
                  child: Icon(
                    Icons.near_me,
                    color: Colors.white,
                  ),
                ),
                title: const Text(
                  "Localização atual",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Observer(
                builder: (context) {
                  return Column(
                    children: controller.addresses.map((e) => _ItemTile(address: e.address)).toList(),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}