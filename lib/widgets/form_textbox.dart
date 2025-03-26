import 'package:easy_formz/easy_formz.dart';

/// A widget that displays a text input form field.
class FormTextBox extends StatefulWidget {
  /// Creates a [FormTextBox] widget.
  ///
  /// The [config] and [onChanged] parameters are required.
  FormTextBox({
    super.key,
    required this.config,
    required this.onChanged,
    EasyFormzTheme? theme,
  }) : theme = theme ?? EasyFormzTheme();

  /// The configuration for the form field.
  final FormConfig config;

  /// The theme for the form field.
  final EasyFormzTheme theme;

  /// Callback when the form field value changes.
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
                  color: widget.config.props.isWarned
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
