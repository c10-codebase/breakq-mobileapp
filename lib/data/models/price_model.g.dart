// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Price _$PriceFromJson(Map<String, dynamic> json) {
  return Price(
    price: (json['price'] as num)?.toDouble(),
    discount: (json['discount'] as num)?.toDouble(),
    extraOffer: (json['extra_Offer'] as num)?.toDouble(),
    delivery: (json['delivery_Charges'] as num)?.toDouble(),
    totalAmnt: (json['final_Amount'] as num)?.toDouble(),
    savings: (json['savings'] as num)?.toDouble(),
  );
}
