import 'package:flutter/material.dart';

class InfoField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool isEditing;
  final VoidCallback onEditPressed;
  final VoidCallback onSavePressed;

  const InfoField({
    Key? key,
    required this.title,
    required this.controller,
    required this.isEditing,
    required this.onEditPressed,
    required this.onSavePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              isEditing
                  ? TextField(
                controller: controller,
              )
                  : Text(controller.text),
            ],
          ),
        ),
        isEditing
            ? TextButton(
          onPressed: onSavePressed,
          child: Text('Save'),
        )
            : TextButton(
          onPressed: onEditPressed,
          child: Text('Edit'),
        ),
      ],
    );
  }
}
