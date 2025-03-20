import 'package:easy_formz/easy_formz.dart';

class FormWarningLabel extends StatelessWidget {
  const FormWarningLabel({
    super.key,
    required this.isWarned,
    required this.theme,
  });
  final bool isWarned;
  final EasyFormzTheme theme;

  @override
  Widget build(BuildContext context) {
    if (isWarned) {
      return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          'Please fill the form correctly',
          style: theme.warningTextStyle,
        ),
      );
    }

    return const SizedBox();
  }
}
