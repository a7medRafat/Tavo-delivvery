import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/modules/home/view/widgets/CategoryItemComponent.dart';
import 'package:fooddelivery/config/style/app_fonts.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/models/CategoryModel.dart';
import 'package:fooddelivery/modules/home/view_model/home_view_model.dart';
import 'package:fooddelivery/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class HomeCategory extends StatelessWidget {
  const HomeCategory({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: StreamBuilder<List<CategoryModel>>(
        stream: categoryDBService.categories(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(
              snapshot.error.toString(),
              style: AppFonts.bodyText2,
            ).center();
          }

          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return noDataWidget(errorMessage: errorMessage).center();
            } else {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(top: 16, bottom: 16, right: 16),
                itemBuilder: (context, index) {
                  return CategoryItemComponent(category: snapshot.data![index]);
                },
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
              );
            }
          }
          return Loader().center();
        },
      ),
    ).visible(viewModel.searchText.isEmpty);
  }
}
