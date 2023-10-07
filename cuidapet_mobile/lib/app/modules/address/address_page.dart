import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

part 'widgets/address_item.dart';

class AddressPage extends StatefulWidget {

  const AddressPage({ Key? key }) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {

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
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(20),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )
                  ),
                ),
              ),
              const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 30,
                  child: Icon(
                    Icons.near_me,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Localização atual",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  _AddressItem(),
                  _AddressItem(),
                  _AddressItem(),
                  _AddressItem(),
                  _AddressItem(),
                  _AddressItem(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}