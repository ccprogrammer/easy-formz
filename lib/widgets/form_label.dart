import 'package:easy_formz/easy_formz.dart';

/// A widget that displays a label for a form field.
class FormLabel extends StatelessWidget {
  /// Creates a [FormLabel] widget.
  ///
  /// The [label], [isRequired], and [theme] parameters are required.
  const FormLabel({
    super.key,
    required this.label,
    required this.isRequired,
    required this.theme,
  });

  /// The theme for the label.
  final EasyFormzTheme theme;

  /// The text of the label.
  final String label;

  /// Indicates whether the form field is required.
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
