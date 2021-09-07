import 'package:flutter/material.dart';

class Job {
  Job({@required this.name, @required this.ratePerHour, @required this.id});

  final int ratePerHour;
  final String name;
  final String id;

  factory Job.fromMap(Map<String, dynamic> data, String docmentId) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    final int ratePerHour = data['ratePerHour'];
    return Job(
      name: name,
      ratePerHour: ratePerHour,
      id: docmentId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ratePerHour': ratePerHour,
    };
  }
}
