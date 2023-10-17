import 'package:cuidapet_mobile/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_default_button.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressDetailPage extends StatefulWidget {

  final PlaceModel place;

  const AddressDetailPage({
    super.key,
    required this.place,
  });

  @override
  State<AddressDetailPage> createState() => _AddressDetailPageState();
}

class _AddressDetailPageState extends State<AddressDetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: context.primaryColor,
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Text(
            "Confirme seu endereço",
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.place.lat, widget.place.lng),
                zoom: 16,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("AddressID"),
                  position: LatLng(widget.place.lat, widget.place.lng),
                  infoWindow: InfoWindow(
                    title: widget.place.address,
                  ),
                ),
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: widget.place.address,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Endereço",
                suffixIcon: Icon(
                  Icons.edit,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: "Complemento",
              ),
            ),
          ),
          SizedBox(
            width: 0.9.sw,
            height: 60.h,
            child: CuidapetDefaultButton(
              label: "Salvar",
              onPressed: () {},
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}