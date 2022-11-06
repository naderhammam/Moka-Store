import 'package:equatable/equatable.dart';

class ItemDetails extends Equatable {
  final String title;
  final String description;
  final String image;
  final String price;
  final String discount;
  final String id;
  final String rate;
  final String? category;

  const ItemDetails({
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.discount,
    required this.id,
    required this.rate,
    this.category = '',
  });

  @override
  List<Object?> get props => [
        title,
        description,
        image,
        price,
        discount,
        id,
        rate,
        category,
      ];
}
