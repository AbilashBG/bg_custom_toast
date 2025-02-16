# Changelog

All notable changes to this project will be documented in this file.

## [0.0.2] - 2025-02-16
### Added
- **Initial release** of `bg_custom_toast`, a fully customizable toast notification package for Flutter.
- **Multiple animations**:
    - `Slide`: The toast slides in from the top or bottom.
    - `Dynamic Island`: Expands smoothly, mimicking Apple's Dynamic Island animation.
    - `Fade`: Gradually fades in and out.
    - `Bounce`: Pops in with a bouncing effect.
    - `Flip`: Flips into the screen.
    - `Rotate`: Rotates while appearing.

- **Toast positioning**:
    - Display toast at the `Top`, `Center`, or `Bottom` of the screen.
    - Adjustable margin for precise placement.

- **Customizable appearance**:
    - Set **background color** and **text color**.
    - Configure **border radius** for rounded corners.
    - Adjust **padding** and **margin**.

- **Performance optimizations**:
    - Utilizes **animation controllers** for smooth transitions.
    - Lightweight and efficient, avoiding unnecessary widget rebuilds.
    - Automatically disposes animation controllers to prevent memory leaks.

- **Simple API**:
    - Show a toast with just one function call:
      ```dart
      BGCustomToast.show(
        context: context,
        message: "Hello, this is a toast!",
        position: ToastPosition.top,
        animation: ToastAnimation.slide,
      );
      ```

---
