import 'package:flutter/material.dart';
import 'package:rfw_banner_app/banner/models/banner_controller.dart';
import 'package:rfw_banner_app/banner/models/banner_model.dart';
import 'package:rfw_banner_app/banner/widgets/rfw_banner_widget.dart';

/// Demo page showcasing the three RFW banner types
class BannerPage extends StatefulWidget {
  const BannerPage({super.key});

  @override
  State<BannerPage> createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  late final BannerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = BannerController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onBannerEvent(String eventName, Map<String, dynamic> eventData) {
    // Handle banner events (button taps, etc.)
    debugPrint('Banner Event: $eventName with data: $eventData');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Banner action: $eventName'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RFW Banner Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Banner Type Selector
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Banner Type:',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                ListenableBuilder(
                  listenable: _controller,
                  builder: (context, _) {
                    return Wrap(
                      spacing: 8,
                      children: BannerType.values.map((type) {
                        final isSelected = _controller.currentType == type;
                        return ChoiceChip(
                          label: Text(type.displayName),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              _controller.setBannerType(type);
                            }
                          },
                          selectedColor:
                              Theme.of(context).colorScheme.primaryContainer,
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),

          // RFW Banner Widget - Direct display
          Expanded(
            child: ListenableBuilder(
              listenable: _controller,
              builder: (context, _) {
                return RfwBannerWidget(
                  bannerType: _controller.currentType,
                  bannerData: _controller.currentBannerData,
                  onEvent: _onBannerEvent,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
