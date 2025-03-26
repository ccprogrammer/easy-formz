import 'package:easy_formz/easy_formz.dart';

/// A widget that displays a warning label if the form field is in a warned state.
class FormWarningLabel extends StatelessWidget {
  /// Creates a [FormWarningLabel] widget.
  ///
  /// The [isWarned] and [theme] parameters are required.
  const FormWarningLabel({
    super.key,
    required this.isWarned,
    required this.theme,
  });

  /// Indicates whether the form field is in a warned state.
  final bool isWarned;

  /// The theme for the warning label.
  final EasyFormzTheme theme;

  @override
  Widget build(BuildContext context) {
    if (isWarned) {
      return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(theme.warningText, style: theme.warningTextStyle),
      );
    }

    return const SizedBox();
  }
}
