# BGCustomToast

BGCustomToast is a customizable and animated toast notification package for Flutter. It supports various animations and allows positioning at the top, center, or bottom of the screen. Additionally, you can add optional leading and trailing widgets, such as icons or images, for enhanced styling.

## Features

- Multiple animation types: Slide, Dynamic Island, Fade, Bounce, Flip, Rotate
- Customizable position: Top, Center, Bottom
- Custom duration, padding, margin, and border radius
- Custom background and text colors
- Supports leading and trailing widgets (Icons, Images, etc.)

## Installation

Add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  bg_custom_toast: latest_version
```

Then, run:

```sh
flutter pub get
```

## Usage

Import the package:

```dart
import 'package:bg_custom_toast/bg_custom_toast.dart';
```

### Show a Simple Toast

```dart
BGCustomToast.show(
  context: context,
  message: "This is a custom toast!",
);
```

### Customize Toast Appearance

```dart
BGCustomToast.show(
  context: context,
  message: "This is a custom toast!",
  position: ToastPosition.bottom,
  animation: ToastAnimation.fade,
  backgroundColor: Colors.blue,
  textColor: Colors.white,
  borderRadius: 20.0,
  padding: 12.0,
);
```

## Supported Animations

- **Slide**: Moves in from top/bottom
- **Dynamic Island**: Expands like Apple's Dynamic Island
- **Fade**: Smooth fade-in effect
- **Bounce**: Bouncing entrance
- **Flip**: Rotating flip effect
- **Rotate**: Subtle rotating effect

## Contributions

Feel free to submit issues or pull requests to improve this package!

## License

MIT License. See `LICENSE` file for details.

