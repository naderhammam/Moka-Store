import 'package:moka_store/moka/domain/entities/item_details.dart';

class ItemDetailsModel extends ItemDetails {
  const ItemDetailsModel({
    required super.title,
    required super.description,
    required super.image,
    required super.price,
    required super.discount,
    required super.id,
    required super.rate,
    super.category,
  });

  factory ItemDetailsModel.fromJson(Map<String, dynamic> json) {
    return ItemDetailsModel(
      title: json['title'],
      description: json['description'],
      image: json['image'],
      price: json['price'],
      discount: json['discount'],
      id: json['id'],
      rate: json['rate'],
      category: json['category'],
    );
  }
}
