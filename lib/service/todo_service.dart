import 'dart:convert';

import 'package:http/http.dart';
import 'package:todo_app/model/todo.dart';

class TodoService {
  Future<List<Todo>> callApi() async {
    var uri = Uri.parse("https://jsonplaceholder.typicode.com/todos");
    var response = await get(uri);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List;
      final listToDo = jsonResponse.map((e) {
        return Todo(
            id: e["id"],
            title: e["title"],
            userId: e["userId"],
            completed: e["completed"]);
      }).toList();
      return listToDo;
    }
    throw "Somethong went Wrong";
  }
}
