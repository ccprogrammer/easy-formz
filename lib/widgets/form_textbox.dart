// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:easy_formz/models/form_config.dart';
import 'package:easy_formz/themes/easy_formz_theme.dart';
import 'package:easy_formz/widgets/form_label.dart';
import 'package:easy_formz/widgets/form_warning_label.dart';

class FormTextBox extends StatefulWidget {
  FormTextBox({
    super.key,
    required this.config,
    required this.onChanged,
    EasyFormzTheme? theme,
  }) : theme = theme ?? EasyFormzTheme();

  final FormConfig config;
  final EasyFormzTheme theme;
  final Function(dynamic value) onChanged;

  @override
  State<FormTextBox> createState() => _FormTextBoxState();
}

class _FormTextBoxState extends State<FormTextBox> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.text = widget.config.value ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          FormLabel(
            theme: widget.theme,
            label: widget.config.label,
            isRequired: widget.config.props.isRequired,
          ),
          TextFormField(
            controller: textController,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 16,
              ),
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color:
                      widget.config.props.isWarned
                          ? Colors.red.withOpacity(0.6)
                          : widget.theme.borderColor,
                ),
              ),
            ),
            onChanged: (value) {
              widget.onChanged(value);
            },
          ),
          FormWarningLabel(
            theme: widget.theme,
            isWarned: widget.config.props.isWarned,
          ),
        ],
      ),
    );
  }
}
