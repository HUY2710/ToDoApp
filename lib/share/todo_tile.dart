import 'package:flutter/material.dart';

class ToDoTile extends StatelessWidget {
  ToDoTile(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      this.onChanged,
      this.onTap});

  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Checkbox(value: taskCompleted, onChanged: onChanged)),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 8,
              child: Text(
                taskName,
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                  onTap: onTap,
                  child: const Icon(Icons.delete, color: Colors.red)),
            )
          ],
        ),
      ),
    );
  }
}
