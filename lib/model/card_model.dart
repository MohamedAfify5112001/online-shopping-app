import 'package:equatable/equatable.dart';

final class CardModel extends Equatable {
  final String nameOnCard;
  final String cardNumber;
  final String expireDate;
  final String cvv;
  final bool isDefault;
  final bool isMasterCardOrVisa;
  const CardModel({
    required this.nameOnCard,
    required this.cardNumber,
    required this.expireDate,
    required this.cvv,
    this.isDefault = false,
    required this.isMasterCardOrVisa,
  });

  factory CardModel.fromMap(JsonMap json) => CardModel(
        nameOnCard: json['nameOnCard'],
        cardNumber: json['cardNumber'],
        expireDate: json['expireDate'],
        cvv: json['cvv'],
        isDefault: json['isDefault'],
        isMasterCardOrVisa: json['isMasterCardOrVisa'],
      );

  JsonMap get toMap => {
        'nameOnCard': nameOnCard,
        'cardNumber': cardNumber,
        'expireDate': expireDate,
        'cvv': cvv,
        'isDefault': isDefault,
        'isMasterCardOrVisa': isMasterCardOrVisa,
      };

  @override
  List<Object> get props => [
        nameOnCard,
        cardNumber,
        expireDate,
        cvv,
        isMasterCardOrVisa,
      ];
}

typedef JsonMap = Map<String, dynamic>;
