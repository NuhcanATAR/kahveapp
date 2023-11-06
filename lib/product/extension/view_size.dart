import 'package:flutter/material.dart';

// class ViewSizeModel {
//   ViewSizeModel(BuildContext context) : _context = context;
//   final BuildContext _context;

//   Size get mediaSize => MediaQuery.sizeOf(_context);
// }
extension ViewSizeModelExtension on BuildContext {
  Size get mediaSize => MediaQuery.sizeOf(this);
  //  EdgeInsets get paddedMediaSize => EdgeInsets.all(10.0);
}
