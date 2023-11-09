import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class SupplierServiceWidget extends StatelessWidget {
  const SupplierServiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Banho"),
      subtitle: Text(r"R$ 10,00"),
      leading: CircleAvatar(
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