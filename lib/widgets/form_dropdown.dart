// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:easy_formz/models/form_config.dart';
import 'package:easy_formz/themes/easy_formz_theme.dart';
import 'package:easy_formz/widgets/form_label.dart';
import 'package:easy_formz/widgets/form_warning_label.dart';

class FormDropdown extends StatelessWidget {
   FormDropdown({
    super.key,
    required this.config,
    required this.onChanged,
    EasyFormzTheme? theme,
  }) : theme = theme ?? EasyFormzTheme();

  final FormConfig config;
  final EasyFormzTheme theme;
  final Function(dynamic value) onChanged;

  @override
  Widget build(BuildContext context) {
    String selectedValue = config.value ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          FormLabel(
            label: config.label,
            theme: theme,
            isRequired: config.props.isRequired,
          ),
          PopupMenuButton(
            position: PopupMenuPosition.under,
            offset: const Offset(1, 0),
            itemBuilder:
                (context) =>
                    config.props.options!
                        .map(
                          (value) => PopupMenuItem(
                            value: config.value,
                            child: Text(value.label),
                            onTap: () {
                              onChanged(value);
                            },
                          ),
                        )
                        .toList(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      config.props.isWarned
                          ? theme.warningColor
                          : theme.borderColor,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedValue.isEmpty ? 'Select Option' : selectedValue,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    color: theme.iconColor,
                    size: theme.iconSize,
                  ),
                ],
              ),
            ),
          ),
          FormWarningLabel(theme: theme, isWarned: config.props.isWarned),
        ],
      ),
    );
  }
}
