import 'package:cuidapet_mobile/app/core/life_cycle/page_life_cycle_state.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/modules/supplier/supplier_controller.dart';
import 'package:cuidapet_mobile/app/modules/supplier/widgets/supplier_detail_widget.dart';
import 'package:cuidapet_mobile/app/modules/supplier/widgets/supplier_service_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SupplierPage extends StatefulWidget {

  final int _supplierId;

  const SupplierPage({
    super.key,
    required int supplierId,
  }) : _supplierId = supplierId;

  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState extends PageLifeCycleState<SupplierController, SupplierPage> {

  late ScrollController _scrollController;
  final ValueNotifier<bool> sliverCollapsedVN = ValueNotifier(false);

  @override
  Map<String, dynamic>? get params => {'supplierId': widget._supplierId};

  void _listenerCollapsedAppBarTitle() {
    if(_scrollController.offset > 180 && !_scrollController.position.outOfRange) {
      sliverCollapsedVN.value = true;
    } else if(_scrollController.offset <= 180 && !_scrollController.position.outOfRange) {
      sliverCollapsedVN.value = false;
    }
  }

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    // Listener responsável pela lógica de aparecer/desaparecer com o título
    // em cima do appbar (quando fazer a rolagem para baixo e sumir a imagem de background)
    _scrollController.addListener(_listenerCollapsedAppBarTitle);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listenerCollapsedAppBarTitle);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Fazer agendamento"),
        icon: const Icon(
          Icons.schedule,
        ),
        backgroundColor: context.primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Observer(
        builder: (context) {

          final supplier = controller.supplierModel;

          if(supplier == null) {
            return const Text("Buscando dados do fornecedor");
          }

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                title: ValueListenableBuilder<bool>( // Usou essa técnica para evitar muitas chamadas de update (setState) ao método build como um todo, assim tendo um ganho grande em performance
                  valueListenable: sliverCollapsedVN,
                  builder: (context, value, child) {
                    return Visibility(
                      visible: value,
                      child: Text(
                        supplier.name,
                      ),
                    );
                  }
                ),
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [ // O que acontece quando começo o scroll e vai diminuindo a imagem
                    StretchMode.zoomBackground,
                    StretchMode.fadeTitle,
                  ],
                  background: Image.network(
                    supplier.logo,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SupplierDetailWidget(supplier: supplier),
              ),
              const SliverToBoxAdapter(
                child: Text(
                  "Serviços (0 selecionados)",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => SupplierServiceWidget(
                    service: controller.supplierServices[index],
                  ),
                  childCount: controller.supplierServices.length
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}