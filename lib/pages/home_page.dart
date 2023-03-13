import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/provider/todo_provider.dart';
import 'package:todo_app/share/dialog_box.dart';
import 'package:todo_app/share/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TodoProvider>(context, listen: false).getAllTodos();
    });

    super.initState();
  }

  final _controller = TextEditingController();
  String error = "";
  void onSave() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        Provider.of<TodoProvider>(context, listen: false)
            .addTodo(_controller.text);
        _controller.clear();
      });
      Navigator.of(context).pop();
    }
    // db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
              controller: _controller,
              onSave: onSave,
              onCancel: () => Navigator.of(context).pop());
        });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat.yMMMEd().format(now);
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: const Text("TO DO"),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: GestureDetector(
        onTap: createNewTask,
        child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 17, 111, 187),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
            )),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todo, child) {
          if (todo.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Todo> data = todo.todos;
          var completed = 0;
          for (var i = 0; i < data.length; i++) {
            if (data[i].completed == true) {
              completed++;
            }
          }
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Have a beautiful day!",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: Color.fromARGB(255, 6, 54, 136)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(formattedDate,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 6, 54, 136))),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Tasks: ${data.length}",
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 6, 54, 136))),
                      ),
                      Expanded(
                        child: Text("Completed: $completed",
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 6, 54, 136))),
                      ),
                      Expanded(
                        child: Text("Unfinished: ${data.length - completed}",
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 6, 54, 136))),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 1,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return ToDoTile(
                          taskName: data[index].title ?? "",
                          taskCompleted: data[index].completed ?? true,
                          onChanged: (value) {
                            setState(() {
                              if (data[index].completed == false) {
                                data[index].completed = true;
                              } else {
                                data[index].completed = false;
                              }
                            });
                          },
                          onTap: () {
                            setState(() {
                              setState(() {
                                data.removeAt(index);
                              });
                            });
                          },
                        );
                      }),
                  const SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
