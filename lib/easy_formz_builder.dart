import 'package:easy_formz/controller/easy_formz_controller.dart';
import 'package:easy_formz/themes/easy_formz_theme.dart';
import 'package:flutter/material.dart';

import 'package:easy_formz/models/form_config.dart';
import 'package:easy_formz/widgets/form_textarea.dart';

import 'widgets/form_checkbox.dart';
import 'widgets/form_date.dart';
import 'widgets/form_dropdown.dart';
import 'widgets/form_multicheckbox.dart';
import 'widgets/form_radio.dart';
import 'widgets/form_textbox.dart';
import 'widgets/form_time.dart';

class EasyFormz extends StatefulWidget {
  const EasyFormz({
    super.key,
    required this.controller,
    this.theme,
    this.onFormValuesChanged,
    this.customBuilder,
    this.inputBuilder,
    this.textareaBuilder,
    this.dropdownBuilder,
    this.checkboxBuilder,
    this.multicheckboxBuilder,
    this.radioBuilder,
    this.dateBuilder,
    this.timeBuilder,
    this.errorBuilder,
  });
  final EasyFormzController controller;
  final EasyFormzTheme? theme;

  final Function(FormConfig config, dynamic value)? onFormValuesChanged;
  final Function(FormConfig config, Function(dynamic value) onValueChanged)?
  customBuilder;
  final Function(FormConfig config, Function(dynamic value) onValueChanged)?
  inputBuilder;
  final Function(FormConfig config, Function(dynamic value) onValueChanged)?
  textareaBuilder;
  final Function(FormConfig config, Function(dynamic value) onValueChanged)?
  dropdownBuilder;
  final Function(FormConfig config, Function(dynamic value) onValueChanged)?
  checkboxBuilder;
  final Function(FormConfig config, Function(dynamic value) onValueChanged)?
  multicheckboxBuilder;
  final Function(FormConfig config, Function(dynamic value) onValueChanged)?
  radioBuilder;
  final Function(FormConfig config, Function(dynamic value) onValueChanged)?
  dateBuilder;
  final Function(FormConfig config, Function(dynamic value) onValueChanged)?
  timeBuilder;

  final Function(FormConfig config)? errorBuilder;

  @override
  State<EasyFormz> createState() => _EasyFormzState();
}

class _EasyFormzState extends State<EasyFormz> {
  EasyFormzTheme get theme => widget.theme ?? EasyFormzTheme();
  List<FormConfig> get forms => widget.controller.forms;
  EasyFormzController get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: forms.length,
      itemBuilder: (context, index) {
        final FormConfig config = forms[index];

        if (config.isHidden) return const SizedBox.shrink();

        void onChanged(dynamic value) {
          widget.controller.setValue(config, value);
          widget.onFormValuesChanged?.call(config, value);
        }

        switch (config.type) {
          case 'input':
            if (widget.inputBuilder != null) {
              return widget.inputBuilder!(config, (value) => onChanged(value));
            }
            return FormTextBox(
              config: config,
              theme: theme,
              onChanged: (value) => onChanged(value),
            );
          case 'textarea':
            if (widget.textareaBuilder != null) {
              return widget.textareaBuilder!(
                config,
                (value) => onChanged(value),
              );
            }
            return FormTextArea(
              config: config,
              theme: theme,
              onChanged: (value) => onChanged(value),
            );
          case 'dropdown':
            if (widget.dropdownBuilder != null) {
              return widget.dropdownBuilder!(
                config,
                (value) => onChanged(value),
              );
            }
            return FormDropdown(
              config: config,
              theme: theme,
              onChanged: (value) => onChanged(value),
            );
          case 'checkbox':
            if (widget.checkboxBuilder != null) {
              return widget.checkboxBuilder!(
                config,
                (value) => onChanged(value),
              );
            }
            return FormCheckbox(
              config: config,
              theme: theme,
              onChanged: (value) => onChanged(value),
            );
          case 'multicheckbox':
            if (widget.multicheckboxBuilder != null) {
              return widget.multicheckboxBuilder!(
                config,
                (value) => onChanged(value),
              );
            }
            return FormMultiCheckbox(
              config: config,
              theme: theme,
              onChanged: (value) => onChanged(value),
            );
          case 'radio':
            if (widget.radioBuilder != null) {
              return widget.radioBuilder!(config, (value) => onChanged(value));
            }
            return FormRadio(
              config: config,
              theme: theme,
              onChanged: (value) => onChanged(value),
            );
          case 'date':
            if (widget.dateBuilder != null) {
              return widget.dateBuilder!(config, (value) => onChanged(value));
            }
            return FormDate(
              config: config,
              theme: theme,
              onChanged: (value) => onChanged(value),
            );
          case 'time':
            if (widget.timeBuilder != null) {
              return widget.timeBuilder!(config, (value) => onChanged(value));
            }
            return FormTime(
              config: config,
              theme: theme,
              onChanged: (value) => onChanged(value),
            );
        }
        return widget.customBuilder?.call(
              config,
              (value) => onChanged(value),
            ) ??
            widget.errorBuilder?.call(config) ??
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Failed to render form.'),
            );
      },
    );
  }
}
