import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class GenericPaginateFireStore<T> extends StatelessWidget {
  final Query query;
  final Widget Function(BuildContext, T, int) itemBuilder;
  final T Function(Map<String, dynamic>) fromJson;
  final int itemsPerPage;
  final bool isLive;
  final List<ChangeNotifier>? listeners;

  const GenericPaginateFireStore({
    super.key,
    required this.query,
    required this.itemBuilder,
    required this.fromJson,
    this.itemsPerPage = 10,
    this.isLive = true,
    this.listeners,
  });

  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
      itemBuilderType: PaginateBuilderType.listView,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, documentSnapshot, index) {
        T item =
            fromJson(documentSnapshot[index].data() as Map<String, dynamic>);
        return itemBuilder(context, item, index);
      },
      query: query,
      isLive: isLive,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemsPerPage: itemsPerPage,
      bottomLoader: const CircularProgressIndicator(),
      initialLoader: const CircularProgressIndicator(),
      onEmpty: SizedBox(
        width: context.width(),
        height: context.height() * 0.75,
        child: noDataWidget(
          errorMessage: appStore.translate('noDataFound'),
        ).center(),
      ),
      onError: (e) => Center(
        child: Text(
          e.toString(),
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
