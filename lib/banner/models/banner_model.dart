/// Banner types enum for the three different banner styles
enum BannerType {
  standard,
  hero,
  minimal,
}

/// Extension to get display names for banner types
extension BannerTypeExtension on BannerType {
  String get displayName {
    switch (this) {
      case BannerType.standard:
        return 'Default Banner';
      case BannerType.hero:
        return 'Hero Banner';
      case BannerType.minimal:
        return 'Minimal Banner';
    }
  }

  String get fileName {
    switch (this) {
      case BannerType.standard:
        return 'default_banner';
      case BannerType.hero:
        return 'hero_banner';
      case BannerType.minimal:
        return 'minimal_banner';
    }
  }
}

/// Simple banner data model for RFW dynamic content
class BannerData {
  const BannerData({
    required this.title,
    this.subtitle,
    this.buttonText,
    this.backgroundColor,
  });

  final String title;
  final String? subtitle;
  final String? buttonText;
  final String? backgroundColor;

  /// Convert to map for RFW DynamicContent
  Map<String, Object> toMap() {
    return {
      'title': title,
      if (subtitle != null) 'subtitle': subtitle!,
      if (buttonText != null) 'buttonText': buttonText!,
      if (backgroundColor != null) 'backgroundColor': backgroundColor!,
    };
  }

  /// Sample data for different banner types
  static BannerData defaultBanner() {
    return const BannerData(
      title: '🎉 Welcome to SDUI Banner!',
      subtitle: 'This banner is rendered from Remote Flutter Widget!',
      buttonText: 'Get Started',
      backgroundColor: '0xFF2196F3',
    );
  }

  static BannerData heroBanner() {
    return const BannerData(
      title: 'Transform Your Experience',
      subtitle: 'Join thousands of users who love our platform',
      buttonText: 'Join Now',
      backgroundColor: '0xFF4CAF50',
    );
  }

  static BannerData minimalBanner() {
    return const BannerData(
      title: 'New Update Available',
      buttonText: 'Update',
      backgroundColor: '0xFF9E9E9E',
    );
  }
}
