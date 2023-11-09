import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/modules/supplier/widgets/supplier_detail_widget.dart';
import 'package:cuidapet_mobile/app/modules/supplier/widgets/supplier_service_widget.dart';
import 'package:flutter/material.dart';

class SupplierPage extends StatelessWidget {
  const SupplierPage({super.key});

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
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [ // O que acontece quando começo o scroll e vai diminuindo a imagem
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