import 'package:equatable/equatable.dart';

enum PersonType { man, woman, kids }

enum BrandType {
  Adidas(brand: 'adidas'),
  Boutique_Moschino(brand: 'Boutique Moschino'),
  Blend(brand: 'blend');

  final String brand;

  const BrandType({required this.brand});
}

typedef PersonTypeMap = Map<String, PersonType>;
typedef PersonTypeMapInVerse = Map<PersonType, String>;
typedef BrandTypeMap = Map<String, BrandType>;
typedef BrandTypeMapInverse = Map<BrandType, String>;
typedef JsonMap = Map<String, dynamic>;

PersonTypeMap $PersonType = {
  'man': PersonType.man,
  'woman': PersonType.woman,
  'kids': PersonType.kids,
};
PersonTypeMapInVerse $PersonTypeInVerse = {
  PersonType.man: 'man',
  PersonType.woman: 'woman',
  PersonType.kids: 'kids',
};
BrandTypeMap $BrandType = {
  'Boutique Moschino': BrandType.Boutique_Moschino,
  'adidas': BrandType.Adidas,
  'blend': BrandType.Blend,
};
BrandTypeMapInverse $BrandTypeInVerse = {
  BrandType.Boutique_Moschino: 'Boutique Moschino',
  BrandType.Adidas: 'adidas',
  BrandType.Blend: 'blend'
};

final class Product {
  final String uId;
  final String image;
  final String name;
  final String desc;
  final int price;
  final int discountPrice;
  final int discountRate;
  final int rate;
  bool isFavorite;
  bool isCart;
  final String color;
  final String size;
  final List<dynamic> images;
  final PersonType personType;
  final String brand;
  int quantity;

  Product({
    required this.uId,
    required this.image,
    required this.name,
    required this.desc,
    required this.price,
    required this.discountPrice,
    required this.discountRate,
    required this.rate,
    required this.isFavorite,
    required this.isCart,
    required this.color,
    required this.size,
    required this.images,
    required this.personType,
    required this.brand,
    this.quantity = 0,
  });

  factory Product.fromJson(JsonMap json) => Product(
        uId: json['uId'],
        image: json['image'],
        name: json['name'],
        desc: json['desc'],
        price: json['price'],
        discountPrice: json['discountPrice'],
        discountRate: json['discountRate'],
        rate: json['rate'],
        isFavorite: json['isFavorite'],
        isCart: json['isCart'],
        color: json['color'],
        size: json['size'],
        images: json['images'],
        personType: $PersonType[json['personType']]!,
        brand: $BrandType[json['brand']]!.brand,
      );

  JsonMap get toMap => {
        'uId': uId,
        'image': image,
        'name': name,
        'desc': desc,
        'price': price,
        'discountPrice': discountPrice,
        'discountRate': discountRate,
        'rate': rate,
        'isFavorite': isFavorite,
        'isCart': isCart,
        'color': color,
        'size': size,
        'images': images,
        'personType': $PersonTypeInVerse[personType],
        'brand': brand,
      };
}
