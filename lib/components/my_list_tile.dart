import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String message;
  final String userEmail;
  const MyListTile({super.key, required this.message, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
      child: Container(
        color: Theme.of(context).colorScheme.primary,
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(12)),
        
        child: ListTile(
          title: Text(message),
          subtitle: Text(
            userEmail,
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
        ),
      ),
    );
    ;
  }
}
