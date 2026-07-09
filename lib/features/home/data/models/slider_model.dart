
import '../../domain/entities/slider_entity.dart';

class SliderModel extends SliderEntity {

  SliderModel(super.image);

  factory SliderModel.fromJeson(Map<String,dynamic> json){
    return SliderModel(json['image'] ?? '');
  }

}