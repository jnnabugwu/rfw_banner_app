import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rfw/formats.dart';
import 'package:rfw/rfw.dart';
import 'package:rfw_banner_app/banner/models/banner_model.dart';

/// Main RFW Banner Widget that loads and renders banner templates
class RfwBannerWidget extends StatefulWidget {
  const RfwBannerWidget({
    required this.bannerType,
    required this.bannerData,
    super.key,
    this.onEvent,
  });

  final BannerType bannerType;
  final BannerData bannerData;
  final void Function(String eventName, DynamicMap eventData)? onEvent;

  @override
  State<RfwBannerWidget> createState() => _RfwBannerWidgetState();
}

class _RfwBannerWidgetState extends State<RfwBannerWidget> {
  final Runtime _runtime = Runtime();
  final DynamicContent _data = DynamicContent();
  bool _isLoading = true;
  String? _error;

  // Library names for RFW
  static const LibraryName coreLibrary = LibraryName(['core', 'widgets']);
  static const LibraryName materialLibrary = LibraryName(['material']);
  static const LibraryName bannerLibrary = LibraryName(['banner']);

  @override
  void initState() {
    super.initState();
    _initializeRfw();
  }

  @override
  void didUpdateWidget(RfwBannerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.bannerType != widget.bannerType ||
        oldWidget.bannerData != widget.bannerData) {
      _updateBannerData();
      _loadBannerTemplate();
    }
  }

  Future<void> _initializeRfw() async {
    try {
      print('🔧 Initializing RFW...');

      // Register core and material widgets
      _runtime.update(coreLibrary, createCoreWidgets());
      _runtime.update(materialLibrary, createMaterialWidgets());

      // Load banner template and data
      await _loadBannerTemplate();
      _updateBannerData();

      print('✅ RFW initialization complete');

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('❌ RFW initialization failed: $e');
      setState(() {
        _error = 'Failed to initialize RFW: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadBannerTemplate() async {
    try {
      final fileName = widget.bannerType.fileName;
      final rfwtxtPath = 'lib/banner/rfwtxt/$fileName.rfwtxt';

      print('📄 Loading template: $rfwtxtPath');

      // Load the .rfwtxt file as string
      final rfwtxtContent = await rootBundle.loadString(rfwtxtPath);
      print('✅ Template loaded, length: ${rfwtxtContent.length}');

      // Parse the text format into a RemoteWidgetLibrary
      final library = parseLibraryFile(rfwtxtContent);
      print('✅ Template parsed successfully');

      // Update the runtime with the new library
      _runtime.update(bannerLibrary, library);
      print('✅ Runtime updated with banner library');
    } catch (e) {
      print('❌ Template loading failed: $e');
      setState(() {
        _error = 'Failed to load banner template: $e';
      });
    }
  }

  void _updateBannerData() {
    // Convert banner data to DynamicContent format that matches RFW templates
    final colorString = widget.bannerData.backgroundColor ?? '0xFF2196F3';
    // Convert hex string to integer (remove 0x prefix if present)
    final colorInt = int.parse(
        colorString.replaceAll('0x', '').replaceAll('0X', ''),
        radix: 16);

    final dataMap = {
      'title': widget.bannerData.title,
      'subtitle': widget.bannerData.subtitle ?? 'Default subtitle text',
      'buttonText': widget.bannerData.buttonText ?? 'Action',
      'backgroundColor': colorInt,
    };

    print('📊 Updating banner data: $dataMap');
    _data.update('data', dataMap);
  }

  void _handleEvent(String name, DynamicMap arguments) {
    // Call the provided event handler if available
    widget.onEvent?.call(name, arguments);

    // Default event handling for common actions
    if (name == 'bannerAction') {
      final type = arguments['type'] as String?;
      final banner = arguments['banner'] as String?;

      if (type == 'button_pressed') {
        debugPrint('Banner button pressed: $banner');
        // You can add default navigation or analytics here
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(
        '🏗️ Building RfwBannerWidget - isLoading: $_isLoading, error: $_error');

    if (_isLoading) {
      print('⏳ Showing loading indicator');
      return const SizedBox(
        height: 120,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_error != null) {
      print('❌ Showing error: $_error');
      return Container(
        height: 120,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.red.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red.shade300),
        ),
        child: Center(
          child: Text(
            _error!,
            style: TextStyle(
              color: Colors.red.shade700,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    print('🎯 Rendering RemoteWidget with bannerLibrary');
    return RemoteWidget(
      runtime: _runtime,
      data: _data,
      widget: const FullyQualifiedWidgetName(bannerLibrary, 'root'),
      onEvent: _handleEvent,
    );
  }

  @override
  void dispose() {
    _runtime.dispose();
    super.dispose();
  }
}
