# RFW Banner App Todo List (2 Hour Implementation)

Quick implementation of three banner pages using Remote Flutter Widgets: Default, Hero, and Minimal.

## 🎯 Goal
Create three different banner types using RFW that can be dynamically switched in the app.

## ⏰ Time Estimate: 2 Hours Max

## 📋 Quick Implementation Plan

### Phase 1: Setup (30 minutes)
- [x] Create `lib/banner/` directory
- [x] Create basic banner models and enum
- [x] Create simple banner controller (RFW handles its own state)

### Phase 2: RFW Templates (45 minutes)
- [x] Create `default_banner.rfwtxt` - standard banner
- [x] Create `hero_banner.rfwtxt` - large prominent banner  
- [x] Create `minimal_banner.rfwtxt` - compact banner
- [x] Add sample data for each banner type

### Phase 3: Integration (30 minutes)
- [x] Create `RfwBannerWidget` wrapper
- [x] Add banner type selector UI
- [x] Integrate with main app

### Phase 4: Testing & Polish (15 minutes)
- [ ] Test banner switching
- [ ] Add basic error handling
- [ ] Quick visual polish

## 📁 Simple File Structure
```
lib/banner/
├── models/
│   ├── banner_model.dart          # Banner data model & enum
│   └── banner_controller.dart     # Simple controller for type selection
├── widgets/
│   └── rfw_banner_widget.dart     # Main RFW wrapper
├── rfwtxt/
│   ├── default_banner.rfwtxt      # Standard banner
│   ├── hero_banner.rfwtxt         # Large banner
│   └── minimal_banner.rfwtxt      # Compact banner
└── banner_page.dart               # Demo page with selector
```

## 🔧 Implementation Details

### Banner Types
1. **Default**: Title + subtitle + button (120px height)
2. **Hero**: Large title + CTA + background (200px height)  
3. **Minimal**: Single line + small action (60px height)

### Sample Data Structure
```json
{
  "title": "Banner Title",
  "subtitle": "Banner description text",
  "buttonText": "Action",
  "backgroundColor": "0xFF2196F3"
}
```

### RFW Features to Use
- Core widgets: `Container`, `Text`, `Column`, `Row`
- Material widgets: `ElevatedButton`, `Card`
- Event handling for button taps
- Dynamic colors and text from data
- RFW Runtime and DynamicContent for state management

## ✅ Success Criteria
- [ ] Three working banner templates
- [ ] Banner type switching functionality
- [ ] Clean, responsive layouts
- [ ] Basic event handling (button taps)
- [ ] No crashes or major bugs

---

*Keep it simple, focus on core functionality, get it working quickly.* 