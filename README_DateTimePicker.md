# Purpose

Provides a date/time picker that uses Cupertino Scroll Widgets to set month/day/year and hour/minute/second in a small sized widget (default/optimal size is 230w X 250h)

## Features

Uses less space then other widgets, is a good in-line option.

## Usage

There are three(3) was to utilize this package:

1 - To have the DateTime Picker appears as an overlay, use **dateTimeOverlayRoute**:

```dart
       TextButton(
          key: globalKey,
          onPressed: () async {
            final dateTime = await Navigator.of(context).push(
              dateTimeOverlayRoute<DateTime?>(
                globalKey: globalKey,
                dateTime: DateTime.now(),
                offset: const Offset(0, -180),
              ),
            );
            if (dateTime != null) {
              setState(() => content = dateTime.toIso8601String());
            }
          },
          child: Text(content),
        )
```

2 - Call **UIDateTime** directly:

```dart
          UIDateTimePicker(
              onDateTimeSelected: (dateTime) =>
                  debugPrint(dateTime.toIso8601String()))
```

3 - Call **UIDateTimePrompt** :

```dart
       UIDateTimePrompt(
          key: gKey,
          initialDateTime: DateTime.now(),
          onSelected: (dateTime) {
            setState(() {
              final str = dateTime?.toIso8601String() ?? 'No Date Selected';
              prompt = Text(str, style: const TextStyle(fontSize: 21));
            });
          },
          promptWidget: prompt,
        )
```

## Widget declaration

PageRouteBuilder:

```dart
PageRouteBuilder dateTimeOverlayRoute<T>({
  required GlobalKey globalKey,
  DateTime? dateTime,
  Offset offset = const Offset(0, 0),
})
```

UIDateTimePicker

```dart
UIDateTimePicker({
    super.key,
    required this.onDateTimeSelected,
    DateTime? dateTime,
    DateFormat? dateFormat,
    this.pickerTextStyle = _kPickerTextStyle,
    this.titleTextStyle = _kTitleTextStyle,
    this.datePickerColor = _kDatePickerColor,
    this.dateText = _kDateButtonText,
    this.headerColor = _kHeaderColor,
    this.acceptButton = const AquaButton(
      mainRadius: 22.0,
      materialColor: Colors.green,
    ),
    this.showFirstWidget = true,
    this.size = _kDefaultSize,
    this.textColor = _kTextColor,
    this.timePickerColor = _kTimePickerColor,
    this.timeText = _kTimeButtonText,
  })  : dateTime = dateTime ?? DateTime.now(),
        dateFormat = dateFormat ?? _kDateFormat;
```

## Example

The ***/example*** folder has examples for all methods.

## Finally

Be kind to each other!
