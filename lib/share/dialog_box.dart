import 'package:flutter/material.dart';
import 'package:todo_app/util/my_button.dart';

class DialogBox extends StatelessWidget {
  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  TextEditingController controller = TextEditingController();
  VoidCallback onSave;
  VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.blue[100],
      title: const Text(
        "Add a new task",
        style: TextStyle(color: Color.fromARGB(255, 6, 54, 136)),
      ),
      content: SizedBox(
        height: 150,
        child: Center(
          child: Column(
            children: [
              TextFormField(
                controller: controller,
                maxLines: 2,
                decoration: InputDecoration(
                    hintText: "Add a new task",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyButton(
                    text: "Save",
                    onPressed: onSave,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  MyButton(
                    text: "Cancel",
                    onPressed: onCancel,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
