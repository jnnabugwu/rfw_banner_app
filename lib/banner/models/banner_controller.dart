import 'package:flutter/foundation.dart';
import 'package:rfw_banner_app/banner/models/banner_model.dart';

/// Simple controller to manage banner type selection and data
/// RFW will handle its own state management internally
class BannerController extends ChangeNotifier {
  BannerController() : _currentType = BannerType.standard;

  BannerType _currentType;

  /// Current banner type
  BannerType get currentType => _currentType;

  /// Get banner data for the current type
  BannerData get currentBannerData {
    switch (_currentType) {
      case BannerType.standard:
        return BannerData.defaultBanner();
      case BannerType.hero:
        return BannerData.heroBanner();
      case BannerType.minimal:
        return BannerData.minimalBanner();
    }
  }

  /// Switch to a different banner type
  void setBannerType(BannerType type) {
    if (_currentType != type) {
      _currentType = type;
      notifyListeners();
    }
  }

  /// Get all available banner types
  List<BannerType> get allBannerTypes => BannerType.values;
}
