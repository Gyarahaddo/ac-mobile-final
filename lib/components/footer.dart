import 'package:flutter/material.dart';

class CopyrightFooter extends StatelessWidget {
  final String content;

  const CopyrightFooter({
    super.key,
    required this.content
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          vertical: 10.0
      ).copyWith(bottom: 16.0),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                color: Theme.of(context).colorScheme.outline,
                width: 1,
              )
          )
      ),
      child: Text(
        content,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}