# DateTimePickerTheme

`DateTimePickerTheme` provides a flexible way to apply custom themes to date and time pickers in Flutter applications. It includes predefined themes such as "Earth" and "Industrial" with light and dark variations. The package is built using Flutter's `ThemeExtension` to integrate seamlessly with existing themes.

## Features

- Two thematic categories: Earth and Industrial.
- Support for light and dark theme modes.
- Customizable text styles for various components of the date/time picker.

## Getting Started

### Installation

```yaml
dependencies:
  flutter:
    sdk: flutter
  ui_datetime_flutter:
    git: https://github.com/GitHubStuff/ui_datetime_flutter
```

### Usage

```dart
import 'package:ui_datetime_flutter/ui_datetime_flutter.dart';
```

To use DateTimePickerTheme, wrap your application or widget tree with Theme widget and apply the DateTimePickerTheme:

```dart
Theme(
  data: ThemeData(
    extensions: <ThemeExtension<dynamic>>[
      DateTimePickerTheme.lightEarth(), // Choose the theme variant here, or create your own
    ],
  ),
  child: MyApp(),
);
```

You can also retrieve and use the theme directly in your widgets:

```dart
final pickerTheme = DateTimePickerTheme.of(context);
// Use `pickerTheme` to style your widgets (default is Industrial)
```

## Themes

The package includes the following predefined themes:

### Earth Theme

#### Earth Light Variant

Backgrounds with natural earth tones.
White text for visibility.

#### Earth Dark Variant

Darker, soil-inspired tones with yellow text for contrast.

### Industrial Theme

***NOTE:*** This the default if **no theme extension** is specified in the MaterialApp.

Override example:

```dart
import 'package:ui_datetime_flutter/ui_datetime_flutter.dart';
   :
   :
 @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        extensions: [DateTimePickerTheme.lightEarth()],
      ),
      darkTheme: ThemeData.dark()
          .copyWith(extensions: [DateTimePickerTheme.darkEarth()]),
      themeMode: 
    :
    :
```

#### Industrial Light Variant

Grays and blues reminiscent of industrial equipment.
Standard white text.

#### Industrial Dark Variant

Dark grays and navy blues with bold yellow text for readability.
Each theme provides styles for picker background, date background, time background, and text styles for the marquee, header, and spinner components.

## Contributing

Contributions are welcome! Please feel free to fork the repository, make changes, and submit pull requests.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Finally

Be kind to each other.
