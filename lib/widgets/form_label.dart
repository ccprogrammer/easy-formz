import 'package:easy_formz/themes/easy_formz_theme.dart';
import 'package:flutter/material.dart';

class FormLabel extends StatelessWidget {
  const FormLabel({
    super.key,
    required this.label,
    required this.isRequired,
    required this.theme,
  });
  final EasyFormzTheme theme;

  final String label;
  final bool? isRequired;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Flexible(
            child: Text(
              label,
              style: theme.labelTextStyle,
            ),
          ),
          if (isRequired ?? false)
            Text(
              '*',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: theme.warningColor,
              ),
            ),
        ],
      ),
    );
  }
}
