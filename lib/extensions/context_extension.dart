import 'package:flutter/material.dart';

import '../custom_views/custom_bottom_sheet.dart';
import '../ui/bottomsheets/bet_amount_bottom_sheet.dart';

extension ContextExtension on BuildContext {
  Future<dynamic> showBetAmountBottomSheet() {
    return showCustomModalBottomSheet(
      context: this,
      builder: (context) => BetAmountBottomSheet(),
    );
  }
}
