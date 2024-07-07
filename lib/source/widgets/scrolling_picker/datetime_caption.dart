part of 'ui_datetime_picker.dart';

/// A caption widget for the DateTimePicker.
class DateTimeCaption extends StatelessWidget {
  /// Creates a caption widget for the DateTimePicker.
  const DateTimeCaption({
    required this.caption,
    super.key,
  });

  /// The caption to display.
  final String caption;

  @override
  Widget build(BuildContext context) => AutoSizeText(
        caption,
        style: DateTimePickerTheme.of(context).marqueeStyle,
        maxLines: 1,
        minFontSize: 24,
      );
}
