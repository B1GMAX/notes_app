import 'package:flutter/material.dart';

class NoteWidget extends StatelessWidget {
  final String name;
  final String? image;
  final String date;
  final String id;
  final Function(String) onRemove;

  const NoteWidget({
    required this.image,
    required this.name,
    required this.date,
    required this.id,
    required this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      background: Container(color: Colors.red),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onRemove(id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Text(
              date,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    name,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                if (image != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      image!,
                      height: 90,
                      width: 90,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        return loadingProgress == null
                            ? child
                            : const SizedBox(
                                height: 90,
                                width: 90,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                      },
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
