part of '../home_page.dart';

class _HomeSupplierTab extends StatelessWidget {

  final HomeController controller;

  const _HomeSupplierTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HomeTabHeader(controller: controller),
        Expanded(
          child: Observer(
            builder: (context) {
              return AnimatedSwitcher(
                duration: const Duration(
                  milliseconds: 400,
                ),
                child: controller.supplierPageTypeSelected == SupplierPageType.list
                  ? _HomeSupplierList(controller: controller)
                  : _HomeSupplierGrid(controller: controller),
              );
            }
          ),
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

  final HomeController controller;

  const _HomeSupplierList({required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        Observer(
          builder: (context) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final supplier = controller.listSuppliersByAddress[index];
                  return _HomeSupplierListItemWidget(supplier: supplier);
                },
                childCount: controller.listSuppliersByAddress.length,
              ),
            );
          }
        ),
      ],
    );
  }
}

class _HomeSupplierListItemWidget extends StatelessWidget {

  final SupplierNearbyMeModel supplier;

  const _HomeSupplierListItemWidget({required this.supplier});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 30),
            width: 1.sw,
            height: 80.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(supplier.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 16,
                            ),
                            Text("${supplier.distance.toStringAsFixed(2)} km de distância")
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.all(10),
                  child: CircleAvatar(
                    backgroundColor: context.primaryColor,
                    maxRadius: 15,
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        
          Container(
            margin: const EdgeInsets.only(top: 5),
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[100]!,
                  width: 5,
                ),
                color: Colors.grey,
                borderRadius: BorderRadius.circular(100),
                image: DecorationImage(
                  image: NetworkImage(
                    supplier.logo,
                  ),
                  fit: BoxFit.contain,
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeSupplierGrid extends StatelessWidget {
  
  final HomeController controller;

    const _HomeSupplierGrid({
    required this.controller
  });


  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        Observer(
          builder: (context) {
            return SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _HomeSupplierGridItemWidget(
                  supplier: controller.listSuppliersByAddress[index],
                ),
                childCount: controller.listSuppliersByAddress.length,
              ), 
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
              ),
            );
          }
        ),
      ],
    );
  }
}

class _HomeSupplierGridItemWidget extends StatelessWidget {
  
  final SupplierNearbyMeModel supplier;

  const _HomeSupplierGridItemWidget({required this.supplier});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          margin: const EdgeInsets.only(
            top: 40,
            left: 10,
            right: 10,
            bottom: 10,
          ),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox.expand(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 40,
                left: 10,
                right: 10,
                bottom: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    supplier.name,
                    style: context.textTheme.titleSmall,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${supplier.distance.toStringAsFixed(2)} km de distância",
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[200],
          ),
        ),
        Positioned(
          top: 4,
          left: 0,
          right: 0,
          child: Center(
            child: CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(
                supplier.logo,
              ),
            ),
          ),
        ),
      ],
    );
  }
}