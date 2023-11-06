part of '../home_page.dart';

class _HomeSupplierTab extends StatelessWidget {

  final HomeController controller;

  const _HomeSupplierTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HomeTabHeader(controller: controller),
        Observer(
          builder: (context) {
            return AnimatedSwitcher(
              duration: const Duration(
                milliseconds: 400,
              ),
              child: controller.supplierPageTypeSelected == SupplierPageType.list
                ? _HomeSupplierList()
                : _HomeSupplierGrid(),
            );
          }
        ),
      ],
    );
  }
}

class _HomeTabHeader extends StatelessWidget {

  final HomeController controller;

  const _HomeTabHeader({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          const Text("Estabelecimentos"),
          const Spacer(),
          InkWell(
            child: Observer(
              builder: (context) {
                return Icon(
                  Icons.view_headline,
                  color: controller.supplierPageTypeSelected == SupplierPageType.list
                    ? Colors.black
                    : Colors.grey,
                );
              }
            ),
            onTap: () => controller.changeTabSupplier(SupplierPageType.list),
          ),
          InkWell(
            child: Observer(
              builder: (context) {
                return Icon(
                  Icons.view_comfy,
                  color: controller.supplierPageTypeSelected == SupplierPageType.list
                    ? Colors.black
                    : Colors.grey,
                );
              }
            ),
            onTap: () => controller.changeTabSupplier(SupplierPageType.grid),
          ),
        ],
      ),
    );
  }
}

class _HomeSupplierList extends StatelessWidget {
  const _HomeSupplierList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _HomeSupplierGrid extends StatelessWidget {
  const _HomeSupplierGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}