part of '../home_page.dart';

class _HomeCategoriesWidget extends StatelessWidget {

  final HomeController controller;

  const _HomeCategoriesWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Observer(
        builder: (context) {
          return Center(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: controller.listCategories.length,
              itemBuilder: (context, index) {
          
                final category = controller.listCategories[index];
          
                return _CategoryItem(category, controller);
              },
            ),
          );
        }
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {

  final HomeController _controller;
  final SupplierCategoryModel _categoryModel;

  const _CategoryItem(this._categoryModel, this._controller);

  static const categoriesIcons = {
    "P": Icons.pets,
    "V": Icons.local_hospital,
    "C": Icons.store_mall_directory,
  };

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _controller.filterSupplierCategory(_categoryModel);
      },
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Observer(
              builder: (context) {
                return CircleAvatar(
                  backgroundColor: _controller.supplierCategoryFilterSelected?.id == _categoryModel.id
                    ? context.primaryColor
                    : context.primaryColorLight,
                  radius: 30,
                  child: Icon(
                    categoriesIcons[_categoryModel.type],
                    size: 30,
                    color: Colors.black,
                  ),
                );
              }
            ),
            const SizedBox(
              height: 10,
            ),
            Text(_categoryModel.name)
          ],
        ),
      ),
    );
  }
}