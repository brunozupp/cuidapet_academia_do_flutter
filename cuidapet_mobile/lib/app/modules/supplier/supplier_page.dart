import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/modules/supplier/widgets/supplier_detail_widget.dart';
import 'package:cuidapet_mobile/app/modules/supplier/widgets/supplier_service_widget.dart';
import 'package:flutter/material.dart';

class SupplierPage extends StatefulWidget {
  const SupplierPage({super.key});

  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {

  late ScrollController _scrollController;
  final ValueNotifier<bool> sliverCollapsedVN = ValueNotifier(false);

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
      body: CustomScrollView(
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
                  child: const Text(
                    "Clinica Central ABC",
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
                "LOGO",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SupplierDetailWidget(),
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
              (context, index) => SupplierServiceWidget(),
              childCount: 10
            ),
          ),
        ],
      ),
    );
  }
}