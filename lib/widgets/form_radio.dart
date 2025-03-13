import 'package:easy_formz/models/form_config.dart';
import 'package:easy_formz/themes/easy_formz_theme.dart';
import 'package:easy_formz/widgets/form_label.dart';
import 'package:easy_formz/widgets/form_warning_label.dart';
import 'package:flutter/material.dart';

class FormRadio extends StatelessWidget {
   FormRadio({
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
          Column(
            children: config.props.options!
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 24.0,
                          width: 24.0,
                          child: Radio(
                            value: e.value,
                            groupValue: selectedValue,
                            fillColor: WidgetStateColor.resolveWith((states) {
                              if (states.contains(WidgetState.selected)) {
                                return theme.valueColor;
                              } else {
                                return theme.borderColor;
                              }
                            }),
                            onChanged: (value) {
                              onChanged(e.value);
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            onChanged(e.value);
                          },
                          child: Text(
                            e.label,
                            style: theme.optionTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          FormWarningLabel(
            theme: theme,
            isWarned: config.props.isWarned,
          ),
        ],
      ),
    );
  }
}
