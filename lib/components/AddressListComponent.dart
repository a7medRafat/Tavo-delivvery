import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:fooddelivery/models/AddressModel.dart';
import 'package:fooddelivery/utils/Colors.dart';

import '../main.dart';
import '../models/UserModel.dart';

// ignore: must_be_immutable
class AddressListComponent extends StatefulWidget {
  static String tag = '/AddressListComponent';
  UserModel? userData;
  bool? isOrder;

  AddressListComponent({super.key, this.userData, this.isOrder});

  @override
  AddressListComponentState createState() => AddressListComponentState();
}

class AddressListComponentState extends State<AddressListComponent> {
  Future removeAddress(int index) async {
    appStore.setLoading(true);

    widget.userData!.listOfAddress!.removeAt(index);
    widget.userData!.updatedAt = DateTime.now();

    await userDBService
        .updateDocument(widget.userData!.toJson(), appStore.userId)
        .then((value) {
      toast(appStore.translate('removed'));

      appStore.setLoading(false);
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString());
    });
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.userData!.listOfAddress.validate().isEmpty) {
      return Text(appStore.translate('no_address_found'),
              style: secondaryTextStyle())
          .center();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemBuilder: (_, index) {
        AddressModel addressModel = widget.userData!.listOfAddress![index];

        return Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: boxDecorationWithShadow(
            borderRadius: radius(12),
            boxShadow: defaultBoxShadow(),
            backgroundColor:
                appStore.isDarkMode ? scaffoldSecondaryDark : Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(addressModel.address.validate(),
                  style: boldTextStyle(size: 14),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis),
              4.height,
              Text(addressModel.otherDetails.validate(),
                  style: secondaryTextStyle()),
              8.height,
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(Icons.delete, color: colorPrimary).onTap(() {
                    showConfirmDialog(context,
                            appStore.translate('delete_address_confirmation'))
                        .then((value) {
                      if (value ?? false) {
                        removeAddress(index);
                      }
                    });
                  }),
                ],
              )
            ],
          ),
        ).onTap(() {
          if (widget.isOrder.validate()) {
            appStore.setAddressModel(addressModel);
            finish(context, addressModel);
          }
        });
      },
      itemCount: widget.userData!.listOfAddress.validate().length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
    );
  }
}
