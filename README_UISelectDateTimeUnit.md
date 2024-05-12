# UISelectDateTimeUnit Widget

A widget for selecting DateTimeUnit.

This widget allows users to select a DateTimeUnit, such as year, month, day, hour, minute, second,
millisecond, or microsecond. It provides radio buttons for each DateTimeUnit option.

## Parameters

- **initialUnit**: The initial DateTimeUnit selected when the widget is first built.
- **onChanged**: A callback function called whenever the selected DateTimeUnit changes.
- **showMillisecond**: Determines whether to display the millisecond option.
- **showMicroSecond**: Determines whether to display the microsecond option.

## Example

```dart
UISelectDateTimeUnit(
  initialUnit: DateTimeUnit.year,
  onChanged: (DateTimeUnit unit) {
    print('Selected DateTimeUnit: $unit');
  },
  showMillsecond: true,
  showMicroSecond: false,
)
```

## Usage

To use this widget, import it into your Flutter project and place it where needed. Provide the required parameters and handle the onChanged callback to react to changes in selected DateTimeUnit.

## Finally

Be kind to each other
