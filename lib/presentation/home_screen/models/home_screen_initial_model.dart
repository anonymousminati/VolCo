import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/presentation/home_screen/models/homescreenlist_item_model.dart';

class HomeScreenInitialModel{
  Rx<List<HomescreenlistItemModel>> homescreenlistItemList = Rx([
    HomescreenlistItemModel(
      martinezCannes: ImageConstant.imgVolunteeringCleaning.obs,
      presidenthotel: "Martinez Cannes".obs,
      parisfrance: "Paris, France".obs,
      fortyEight: "4.8".obs,
      reviews: "(4,378 reviews)".obs,
      price: "\$32".obs,
      night: "/ night".obs,
    ),
    HomescreenlistItemModel(
      martinezCannes: ImageConstant.imgVolunteeringCleaning.obs,
      presidenthotel: "Martinez Cannes2".obs,
      parisfrance: "Paris, France".obs,
      fortyEight: "4.8".obs,
      reviews: "(4,378 reviews)".obs,
      price: "\$32".obs,
      night: "/ night".obs,
    ),
  ]);

}