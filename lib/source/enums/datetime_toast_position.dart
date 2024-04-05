/// An enumeration representing the position of the DateTimeToast notification.
///
/// The [DateTimeToastPosition] enum provides options for specifying the
/// position of the toast notification, including top, center, and bottom.
library;

import 'package:oktoast/oktoast.dart' as ok;

enum DateTimeToastPosition {
  top,
  center,
  bottom;

  /// Converts the DateTimeToastPosition enum to the corresponding okToast.ToastPosition.
  ok.ToastPosition get okToastPosition {
    switch (this) {
      case top:
        return ok.ToastPosition.top;
      case center:
        return ok.ToastPosition.center;
      case bottom:
        return ok.ToastPosition.bottom;
    }
  }
}
