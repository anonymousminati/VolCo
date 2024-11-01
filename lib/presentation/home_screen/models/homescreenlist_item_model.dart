import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';

class HomescreenlistItemModel {
  HomescreenlistItemModel(
      {this.martinezCannes,
      this.presidenthotel,
      this.parisfrance,
      this.fortyEight,
      this.reviews,
      this.price,
      this.night,
      this.id}) {
    martinezCannes = martinezCannes ?? Rx(ImageConstant.imgVolunteeringCleaning);
    presidenthotel = presidenthotel ?? Rx("Martinez Cannes");
    parisfrance = parisfrance ?? Rx("Paris, France");
    fortyEight = fortyEight ?? Rx("4.8");
    reviews = reviews ?? Rx("(4,378 reviews)");
    price = price ?? Rx("\$32");
    night = night ?? Rx("/ night");
    id = id ?? Rx("");
  }
  Rx<String>? martinezCannes;
  Rx<String>? presidenthotel;
  Rx<String>? parisfrance;
  Rx<String>? fortyEight;
  Rx<String>? reviews;
  Rx<String>? price;
  Rx<String>? night;
  Rx<String>? id;
}
