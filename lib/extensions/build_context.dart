import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  Size get mqSize => MediaQuery.sizeOf(this);
}
