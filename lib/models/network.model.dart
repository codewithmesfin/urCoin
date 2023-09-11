import 'package:flutter/material.dart';

class NetworkModel {
  final int id;
  final String title;
  final Widget icon;
  final Color color; // Assuming 'greenColor' is an integer color value
  final String url;
  final String name;
  final String unit;

  NetworkModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.url,
    required this.name,
    required this.unit,
  });

  factory NetworkModel.fromJson(Map<String, dynamic> json) {
    return NetworkModel(
      id: json['id'] as int,
      title: json['title'] as String,
      icon: json['icon'],
      color: json['color'] as Color,
      url: json['url'] as String,
      name: json['name'] as String,
      unit: json['unit'] as String,
    );
  }
}
