import 'package:equatable/equatable.dart';
class Task extends Equatable{
  final String title;
  final dynamic icon;
  final String color;
  final List<dynamic>? todos;
  const Task({
    required this.title,
    required this.icon,
    required this.color,
    this.todos
});
  Task copyWith({
    String? title,
    int? icon,
    String? color,
    List<dynamic>? todos,
}) => Task(
    title: title ?? this.title,
    color: color ?? this.color,
    icon: icon ?? this.icon,
    todos: todos ?? this.todos,
  );
  factory Task.fromJson(Map<String, dynamic> json)=>Task(
    title: json['title'],
    icon: json['icon'],
    color: json['color'],
    todos: json['todos'],
  );
  Map<String,dynamic> toJson() =>  {
    'title' : title,
    'icon' : icon,
    'color' : color,
    'todos' : todos
  };
  @override
  List<Object?> get props => [title,icon,color];
}