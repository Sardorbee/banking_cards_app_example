// To parse this JSON data, do
//
//     final cardModel = cardModelFromJson(jsonString);

import 'dart:convert';

List<CardModel> cardModelFromJson(String str) => List<CardModel>.from(json.decode(str).map((x) => CardModel.fromJson(x)));

String cardModelToJson(List<CardModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CardModel {
    int id;
    String cardType;
    String cardNumber;
    String bankName;
    double moneyAmount;
    CardCrrency? cardCurrency;
    DateTime expireDate;
    String iconImage;
    Colors colors;
    CardCrrency? cardCrrency;

    CardModel({
        required this.id,
        required this.cardType,
        required this.cardNumber,
        required this.bankName,
        required this.moneyAmount,
        required this.cardCurrency,
        required this.expireDate,
        required this.iconImage,
        required this.colors,
        required this.cardCrrency,
    });

    factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        id: json["id"],
        cardType: json["card_type"],
        cardNumber: json["card_number"],
        bankName: json["bank_name"],
        moneyAmount: json["money_amount"],
        cardCurrency: cardCrrencyValues.map[json["card_currency"]],
        expireDate: DateTime.parse(json["expire_date"]),
        iconImage: json["icon_image"],
        colors: Colors.fromJson(json["colors"]),
        cardCrrency: cardCrrencyValues.map[json["card_crrency"]],  
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "card_type": cardType,
        "card_number": cardNumber,
        "bank_name": bankName,
        "money_amount": moneyAmount,
        "card_currency": cardCrrencyValues.reverse[cardCurrency],
        "expire_date": expireDate.toIso8601String(),
        "icon_image": iconImage,
        "colors": colors.toJson(),
        "card_crrency": cardCrrencyValues.reverse[cardCrrency],
    };
}

enum CardCrrency { SO_M }

final cardCrrencyValues = EnumValues({
    "SO'M": CardCrrency.SO_M
});

class Colors {
    String colorA;
    String colorB;

    Colors({
        required this.colorA,
        required this.colorB,
    });

    factory Colors.fromJson(Map<String, dynamic> json) => Colors(
        colorA: json["color_a"],
        colorB: json["color_b"],
    );

    Map<String, dynamic> toJson() => {
        "color_a": colorA,
        "color_b": colorB,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
