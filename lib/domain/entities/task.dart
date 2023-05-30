import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final DateTime updatedDateTime;

  @HiveField(4)
  final DateTime createdDateTime;

  Task(
      {required this.id,
      required this.title,
      required this.description,
      required this.updatedDateTime,
      required this.createdDateTime});

  Task copyWith(
      {String? id,
      String? title,
      String? description,
      DateTime? createdDateTime,
      DateTime? updatedDateTime}) {
    return Task(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdDateTime: createdDateTime ?? this.createdDateTime,
        updatedDateTime: updatedDateTime ?? this.updatedDateTime);
  }

  @override
  List<Object?> get props => [id, title, description];
}
