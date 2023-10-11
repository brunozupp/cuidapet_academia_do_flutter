part of '../address_page.dart';

class _AddressSearchWidget extends StatefulWidget {

  const _AddressSearchWidget({ super.key });

  @override
  State<_AddressSearchWidget> createState() => _AddressSearchWidgetState();
}

class _AddressSearchWidgetState extends State<_AddressSearchWidget> {

  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(
      style: BorderStyle.none,
      color: Colors.black,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(20),
      child: TypeAheadFormField<PlaceModel>(
        itemBuilder: (_, item) {
          return _ItemTile(
            address: item.address,
          );
        },
        onSuggestionSelected: onSuggestionSelected,
        suggestionsCallback: suggestionsCallback,
        textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.location_on,
            ),
            hintText: "Insira um endereço",
            border: border,
            disabledBorder: border,
            enabledBorder: border,
          ),
        ),
      ),
    );
  }

  FutureOr<Iterable<PlaceModel>> suggestionsCallback(String pattern) {
    return [];
  }

  void onSuggestionSelected(PlaceModel suggestion) {
  
  }
}

class _ItemTile extends StatelessWidget {

  final String address;

  const _ItemTile({
    Key? key,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_on),
      title: Text(address),
    );
  }
}
