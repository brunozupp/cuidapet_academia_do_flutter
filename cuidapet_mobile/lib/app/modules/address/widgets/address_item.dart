part of '../address_page.dart';

class _AddressItem extends StatelessWidget {

  final String address;
  final String additional;
  final VoidCallback onTap;

  const _AddressItem({
    Key? key,
    required this.address,
    required this.additional,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: ListTile(
        onTap: onTap,
        leading: const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.location_on,
            color: Colors.black,
          ),
        ),
        title: Text(
          address,
        ),
        subtitle: Text(
          additional,
        ),
      ),
    );
  }
}
