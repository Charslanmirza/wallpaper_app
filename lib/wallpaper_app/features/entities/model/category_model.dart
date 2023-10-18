import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
   String? name;
   String? img;

  CategoryModel({
     this.name,
     this.img,
  });

  @override
  List<Object?> get props => [name, img];

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'] as String,
      img: json['img'] as String,
    );
  }
}
