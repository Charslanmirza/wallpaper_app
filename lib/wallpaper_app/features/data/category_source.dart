
import '../entities/model/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> categories = [];
  CategoryModel categorieModel = CategoryModel();

  //
  categorieModel.img =
      "https://images.pexels.com/photos/545008/pexels-photo-545008.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.name = "Street Art";
  categories.add(categorieModel);
  categorieModel = CategoryModel();

  //
  categorieModel.img =
      "https://images.pexels.com/photos/704320/pexels-photo-704320.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.name = "Wild Life";
  categories.add(categorieModel);
  categorieModel = CategoryModel();

  //
  categorieModel.img =
      "https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.name = "Nature";
  categories.add(categorieModel);
  categorieModel = CategoryModel();

  //
  categorieModel.img =
      "https://images.pexels.com/photos/466685/pexels-photo-466685.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.name = "City";
  categories.add(categorieModel);
  categorieModel = CategoryModel();

  //
  categorieModel.img =
      "https://images.pexels.com/photos/1434819/pexels-photo-1434819.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260";
  categorieModel.name = "Motivation";

  categories.add(categorieModel);
  categorieModel = CategoryModel();

  //
  categorieModel.img =
      "https://images.pexels.com/photos/2116475/pexels-photo-2116475.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.name = "Bikes";
  categories.add(categorieModel);
  categorieModel = CategoryModel();

  //
  categorieModel.img =
      "https://images.pexels.com/photos/1149137/pexels-photo-1149137.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.name = "Cars";
  categories.add(categorieModel);
  categorieModel = CategoryModel();

  return categories;
}
