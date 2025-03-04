import 'package:flutter/material.dart';

class SearchAndFriend extends StatelessWidget {
  const SearchAndFriend({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 279,
          height: 44,
          child: TextField(
            textAlign: TextAlign.left,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 5),
              prefixIcon: Icon(Icons.search),
              fillColor: Colors.grey,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          width: 44,
          height: 44,
          child: const Icon(
            Icons.child_friendly,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
