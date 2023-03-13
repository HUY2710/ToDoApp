import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/service/todo_service.dart';

class TodoProvider extends ChangeNotifier {
  final _service = TodoService();
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;
  bool isLoading = true;

  Future<void> getAllTodos() async {
    isLoading = true;
    notifyListeners();
    final respone = await _service.callApi();
    _todos = respone;
    isLoading = false;
    notifyListeners();
  }

  Future<void> addTodo(String title) async {
    final response = await post(
      Uri.parse('https://jsonplaceholder.typicode.com/todos'),
      body: jsonEncode(
        {
          'userId': 1,
          'id': 1,
          'title': title,
          'completed': false,
        },
      ),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      final newTodo = Todo.fromJson(jsonDecode(response.body));
      _todos.add(newTodo);
      notifyListeners();
    } else {
      throw Exception('Failed to add todo');
    }
  }

  Future<void> deleteById(int id) async {
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/todos/$id');
    final response = await delete(uri);
    if (response.statusCode == 200) {
      final deleteTodo = _todos.where((element) => element.id != id).toList();
      _todos = deleteTodo;
      notifyListeners();
    } else {
      throw Exception('Failed to add todo');
    }
  }
}
