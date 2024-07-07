/// An enumeration representing the position of the DateTimeToast notification.
///
/// The [DateTimeToastPosition] enum provides options for specifying the
/// position of the toast notification, including top, center, and bottom.
// ignore_for_file: public_member_api_docs

library;

import 'package:oktoast/oktoast.dart' as ok_toast;

enum DateTimeToastPosition {
  top,
  center,
  bottom;

  /// Converts the DateTimeToastPosition enum to the corresponding okToast.ToastPosition.
  ok_toast.ToastPosition get okToastPosition {
    switch (this) {
      case top:
        return ok_toast.ToastPosition.top;
      case center:
        return ok_toast.ToastPosition.center;
      case bottom:
        return ok_toast.ToastPosition.bottom;
    }
  }
}
