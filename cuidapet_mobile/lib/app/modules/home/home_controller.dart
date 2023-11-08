import 'package:cuidapet_mobile/app/core/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/core/life_cycle/controller_life_cycle.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_loader.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_messages.dart';
import 'package:cuidapet_mobile/app/models/supplier_category_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_nearby_me_model.dart';
import 'package:cuidapet_mobile/app/services/address/i_address_service.dart';
import 'package:cuidapet_mobile/app/services/supplier/i_supplier_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

enum SupplierPageType {list, grid}

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store, ControllerLifeCycle {

  final IAddressService _addressService;
  final ISupplierService _supplierService;

  HomeControllerBase({
    required IAddressService addressService,
    required ISupplierService supplierService,
  }) : _addressService = addressService,
       _supplierService = supplierService;

  @readonly
  AddressEntity? _addressEntity;

  @readonly
  var _listCategories = <SupplierCategoryModel>[];

  @readonly
  var _supplierPageTypeSelected = SupplierPageType.list;

  @readonly
  var _listSuppliersByAddress = <SupplierNearbyMeModel>[];

  var _listSuppliersByAddressCache = <SupplierNearbyMeModel>[];

  @readonly
  SupplierCategoryModel? _supplierCategoryFilterSelected;

  late ReactionDisposer findSuppliersReactionDisposer;

  @override
  void onInit([Map<String, dynamic>? params]) {
    // Quando houver qualquer alteração na variável de endereço, vai chamar o método findSupplierByAddress
    findSuppliersReactionDisposer = reaction((_) => _addressEntity, (address) { 
      findSupplierByAddress();
    });
  }

  @override
  Future<void> onReady() async {
    
    try {
      CuidapetLoader.show();
      
      await _getAddressSelected();
      await _getCategories();
      
    } finally {
      CuidapetLoader.hide();
    }
  }

  @override
  void dispose() {
    findSuppliersReactionDisposer();
  }

  @action
  Future<void> _getAddressSelected() async {
    _addressEntity ??= await _addressService.getAddressSelected();
  
    if(_addressEntity == null) {
      await goToAddressPage();
    }
  }

  @action
  Future<void> goToAddressPage() async {
    final address = await Modular.to.pushNamed<AddressEntity>("/address/");

    if(address != null) {
      _addressEntity = address;
    }
  }

  @action
  Future<void> _getCategories() async {
    try {
      final categories = await _supplierService.getCategories();
      
      _listCategories = [...categories];
    } catch (e) {
      
      CuidapetMessages.alert("Erro ao buscar as categorias");

      throw Exception();
    }
  }

  @action
  void changeTabSupplier(SupplierPageType supplierPageType) {
    _supplierPageTypeSelected = supplierPageType;
  }

  @action
  Future<void> findSupplierByAddress() async {
    if(_addressEntity != null) {
      final suppliers = await _supplierService.findNearby(_addressEntity!);
    
      _listSuppliersByAddress = [...suppliers];
      _listSuppliersByAddressCache = [...suppliers];

      filterSupplier();
    } else {
      CuidapetMessages.alert("Para realizar a busca de petshops você precisa selecionar um endereço");
    }
  }

  @action
  void filterSupplierCategory(SupplierCategoryModel category) {

    if(_supplierCategoryFilterSelected == category) {
      _supplierCategoryFilterSelected = null;
    } else {
      _supplierCategoryFilterSelected = category;
    }

    filterSupplier();
  }

  @action
  void filterSupplier() {

    var suppliers = [..._listSuppliersByAddressCache];

    if(_supplierCategoryFilterSelected != null) {
      suppliers = suppliers.where((e) => e.category == _supplierCategoryFilterSelected!.id).toList();
    }

    _listSuppliersByAddress = [...suppliers];
  }
}