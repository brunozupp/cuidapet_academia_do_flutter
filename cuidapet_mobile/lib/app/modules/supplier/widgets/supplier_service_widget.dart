import 'package:cuidapet_mobile/app/core/helpers/text_formatter.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/models/supplier_services_model.dart';
import 'package:flutter/material.dart';

class SupplierServiceWidget extends StatelessWidget {

  final SupplierServicesModel service;

  const SupplierServiceWidget({super.key, required this.service});

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
      trailing: Icon(
        Icons.add_circle,
        size: 30,
        color: context.primaryColor,
      ),
    );
  }
}