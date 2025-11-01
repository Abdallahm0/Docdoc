import 'package:flutter/material.dart';

class ReviewsTab extends StatelessWidget {
  const ReviewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          leading: CircleAvatar(child: Icon(Icons.person)),
          title: Text("Eslam"),
          subtitle: Text("Very professional and kind."),
          trailing: Icon(Icons.star, color: Colors.amber),
        ),
      ],
    );
  }
}