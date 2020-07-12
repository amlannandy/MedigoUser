import 'package:flutter/material.dart';

class DoctorArgs {

  final String id;
  final String name;
  final String imageUrl;
  final String field;

  const DoctorArgs({
    @required this.id,
    @required this.name,
    @required this.field,
    @required this.imageUrl,
  });

}