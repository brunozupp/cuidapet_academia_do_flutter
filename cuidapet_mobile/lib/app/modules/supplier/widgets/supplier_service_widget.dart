import 'package:cuidapet_mobile/app/core/helpers/text_formatter.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/models/supplier_services_model.dart';
import 'package:cuidapet_mobile/app/modules/supplier/supplier_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SupplierServiceWidget extends StatelessWidget {

  final SupplierController controller;
  final SupplierServicesModel service;

  const SupplierServiceWidget({
    super.key,
    required this.controller,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(service.name),
      subtitle: Text(TextFormatter.formatReal(service.price)),
      leading: const CircleAvatar(
        child: Icon(
          Icons.pets,
        ),
      ),
      trailing: Observer(
        builder: (context) {

          final isSelected = controller.isServiceSelected(service);

          return IconButton(
            onPressed: () => controller.addOrRemoveService(service),
            icon: Icon(
              isSelected ? Icons.remove_circle : Icons.add_circle,
              size: 30,
              color: isSelected ? Colors.red : context.primaryColor,
            ),
          );
        }
      ),
    );
  }
}