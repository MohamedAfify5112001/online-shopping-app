import 'package:equatable/equatable.dart';

final class ShippingAddressModel extends Equatable {
  final String uId;
  final String fullName;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final bool isShippingAddressChoosing;
  const ShippingAddressModel({
    this.uId = '',
    required this.fullName,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    this.isShippingAddressChoosing = false,
  });

  factory ShippingAddressModel.fromMap(JsonMap json) => ShippingAddressModel(
        uId: json['uId'] ?? '',
        fullName: json['fullName'],
        address: json['address'],
        city: json['city'],
        state: json['state'],
        zipCode: json['zipCode'],
        country: json['country'],
        isShippingAddressChoosing: json['isShippingAddressChoosing'],
      );

  JsonMap get toMap => {
        'fullName': fullName,
        'address': address,
        'city': city,
        'state': state,
        'zipCode': zipCode,
        'country': country,
        'isShippingAddressChoosing': isShippingAddressChoosing,
      };

  @override
  List<Object> get props => [
        fullName,
        city,
        state,
        zipCode,
        country,
      ];
}

typedef JsonMap = Map<String, dynamic>;
