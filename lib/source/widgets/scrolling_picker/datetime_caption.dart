part of 'ui_datetime_picker.dart';

class DateTimeCaption extends StatelessWidget {
  final String caption;

  const DateTimeCaption({
    super.key,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) => AutoSizeText(
        caption,
        style: Theme.of(context).extension<DateTimePickerTheme>()!.marqueeStyle,
        maxLines: 1,
        minFontSize: 24,
      );
}
