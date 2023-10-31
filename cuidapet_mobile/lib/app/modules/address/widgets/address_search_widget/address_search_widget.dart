part of '../../address_page.dart';

typedef AddressSelectedCallback = void Function(PlaceModel);

class _AddressSearchWidget extends StatefulWidget {

  final AddressSelectedCallback searchResultCallback;
  final PlaceModel? place;

  const _AddressSearchWidget({
    super.key,
    required this.searchResultCallback,
    this.place,
  });

  @override
  State<_AddressSearchWidget> createState() => _AddressSearchWidgetState();
}

class _AddressSearchWidgetState extends State<_AddressSearchWidget> {

  final searchTextEC = TextEditingController();
  final searchTextFN = FocusNode();

  final controller = Modular.get<AddressSearchController>();

  @override
  void initState() {
    super.initState();

    if(widget.place != null) {
      searchTextEC.text = widget.place?.address ?? "";
      searchTextFN.requestFocus();
    }
  }

  @override
  void dispose() {
    searchTextEC.dispose();
    searchTextFN.dispose();
    super.dispose();
  }

  final _border = OutlineInputBorder(
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
          controller: searchTextEC,
          focusNode: searchTextFN,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.location_on,
            ),
            hintText: "Insira um endereço",
            border: _border,
            disabledBorder: _border,
            enabledBorder: _border,
          ),
        ),
      ),
    );
  }

  Future<List<PlaceModel>> suggestionsCallback(String pattern) async {

    if(pattern.isNotEmpty) {
      return await controller.searchAddress(pattern);
    }

    return [];
  }

  void onSuggestionSelected(PlaceModel suggestion) {
    searchTextEC.text = suggestion.address;
    widget.searchResultCallback(suggestion);
  }
}

class _ItemTile extends StatelessWidget {

  final String address;
  final VoidCallback? onTap;

  const _ItemTile({
    Key? key,
    required this.address,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_on),
      title: Text(address),
      onTap: onTap,
    );
  }
}
