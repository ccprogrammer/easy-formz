import 'package:easy_formz/easy_formz.dart';

/// A widget that displays a textarea form field.
class FormTextArea extends StatefulWidget {
  /// Creates a [FormTextArea] widget.
  ///
  /// The [config] and [onChanged] parameters are required.
  FormTextArea({
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
  State<FormTextArea> createState() => _FormTextAreaState();
}

class _FormTextAreaState extends State<FormTextArea> {
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
            minLines: 4,
            maxLines: 4,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.config.props.isWarned
                      ? widget.theme.warningColor
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
