import 'package:flutter/material.dart';
import 'dart:convert';

// Entities são classes para trabalhar com o meu Banco de Dados Local
class AddressEntity {

  final int? id;
  final String address;
  final double lat;
  final double lng;
  final String additional;

    AddressEntity({
    required this.address,
    required this.lat,
    required this.lng,
    required this.additional,
    this.id
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'address': address,
      'lat': lat.toString(),
      'lng': lng.toString(),
      'additional': additional,
    };
  }

  factory AddressEntity.fromMap(Map<String, dynamic> map) {
    return AddressEntity(
      id: map['id']?.toInt(),
      address: map['address'] ?? '',
      lat: double.tryParse(map['lat']) ?? 0.0,
      lng: double.tryParse(map['lng']) ?? 0.0,
      additional: map['additional'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressEntity.fromJson(String source) => AddressEntity.fromMap(json.decode(source));

  AddressEntity copyWith({
    ValueGetter<int?>? id,
    String? address,
    double? lat,
    double? lng,
    String? additional    
  }) {
    return AddressEntity(
      id: id != null ? id() : this.id,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      additional: additional ?? this.additional
    );
  }
}
