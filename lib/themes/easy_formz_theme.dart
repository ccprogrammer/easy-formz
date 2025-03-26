import 'package:easy_formz/easy_formz.dart';

class EasyFormzTheme {
  final TextStyle labelTextStyle;
  final Color borderColor;
  final double borderWidth;
  final Color valueColor;
  final TextStyle optionTextStyle;
  final TextStyle warningTextStyle;
  final Color warningColor;
  final Color iconColor;
  final double iconSize;
  final String warningText;

  EasyFormzTheme({
    this.labelTextStyle = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
    ),
    this.borderColor = Colors.black12,
    this.borderWidth = 1.6,
    this.valueColor = Colors.purple,
    this.optionTextStyle = const TextStyle(),
    this.warningTextStyle = const TextStyle(color: Colors.red),
    this.warningColor = Colors.red,
    this.iconColor = Colors.black54,
    this.iconSize = 24,
    this.warningText = 'Please fill the form correctly',
  });
}
