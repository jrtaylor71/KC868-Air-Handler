# Changelog

All notable changes to the KC868-A8S ESPHome Air Handler project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-11-17

### Added
- Initial release of KC868-A8S ESPHome air handler configuration
- Complete HVAC control system replacement for Rheem RHWB air handler
- Custom thermostat interface with full 4-wire (G, Y1, Y2, W) + flow switch support
- Multi-speed blower control (Low, Med-Low, Med-High, High)
- Hydronic pump control with safety features
- Daily pump exercise system (3:00 AM, 6-minute duration, 24-hour tracking)
- Configurable timing delays:
  - Heating ON delay (coil warm-up before blower)
  - Heating OFF delay (pump run-on after heat call ends)
  - Cooling OFF delay (blower run-on after cooling ends)
- Accessory control:
  - Electronic Air Cleaner (EAC) with per-mode enable/disable
  - Humidifier control (heat mode only)
- Flow switch safety integration for open-loop systems
- Temperature monitoring with DS18B20 sensors (heat/cool coils)
- Comprehensive status reporting and diagnostics
- VS Code workspace configuration with ESPHome tasks
- Complete documentation suite:
  - Project overview and system specifications
  - Terminal-by-terminal wiring diagrams
  - Configuration and tuning guide
  - Troubleshooting procedures

### Technical Details
- **Platform**: ESPHome on ESP32-D0WD-V3
- **Hardware**: KC868-A8S (8-channel relay controller)
- **I/O Expansion**: PCF8574 chips (0x22 inputs, 0x24 outputs)
- **Communication**: Home Assistant Native API with encryption
- **Sensors**: DS18B20 temperature sensors on one-wire bus
- **Safety Features**: Flow switch integration, pump exercise system
- **Control Logic**: Priority-based HVAC mode selection with sophisticated delay handling

### Configuration Options
- AC Configuration: Single-stage or Two-stage operation
- Blower speed mapping for each mode (Cool Stage 1/2, Heat)
- Configurable timing delays (0-120 seconds)
- Individual accessory enable/disable per HVAC mode
- Flow switch usage toggle
- Pump exercise enable/disable

### Problem Solved
- Eliminates excessive pump cycling from factory Rheem RHWB board
- Provides enhanced control and monitoring capabilities
- Adds Home Assistant integration for remote monitoring and control
- Implements intelligent pump exercise to prevent circulation pump seizure

### Files
- `kc868-a8s-airhandler.yaml` - Main ESPHome configuration (770 lines)
- `docs/` - Complete documentation suite
- `kc868-a8s-air_handler.code-workspace` - VS Code workspace
- `secrets.yaml.example` - Template for WiFi credentials

### Known Issues
- DS18B20 sensor addresses use placeholder values (0x0000... and 0x1111...)
- Requires physical sensor address discovery during first deployment

### Next Steps
- Flash configuration to KC868-A8S device
- Discover and update DS18B20 sensor addresses from device logs
- Complete physical wiring per documentation
- Commission and test all HVAC modes
## [1.1.0] - 2025-11-17

### Added
- **Blower Safety Controls**: Individual blower speed switches are now hidden from Home Assistant to prevent multiple speeds being activated simultaneously
- **Manual Blower Override**: New safe manual control system with single override switch
- **Manual Blower Speed Selector**: Dropdown selector for safe speed selection (Off/Low/Med-Low/Med-High/High)
- **Blower Control Mode Status**: Shows whether blower is in AUTO or MANUAL mode
- **Read-only Blower Status Sensors**: Individual binary sensors showing current blower speed states

### Changed
- **Blower Speed Switches**: Now marked as `internal: true` to hide from Home Assistant interface
- **HVAC Logic**: Updated to handle manual override mode while maintaining all existing safety features
- **Accessory Control**: EAC and humidifier remain off during manual blower operation (unless heat call is active)

### Safety Improvements
- **Motor Protection**: Prevents accidental activation of multiple blower speeds
- **Manual Override Safety**: Manual mode only affects blower speed, all other HVAC logic remains active
- **Flow Switch Integration**: Flow switch safety still applies in manual mode during heat calls
- **Pump Protection**: Hydronic pump still operates normally during manual blower operation with heat calls

### Technical Details
- Manual override implemented with template switches and selectors
- Blower control logic updated to prioritize manual override when enabled
- All existing timing delays, safety features, and accessory controls preserved
- Home Assistant interface now shows safe control options only

This update addresses the safety concern of multiple blower speeds being controllable simultaneously while maintaining all existing functionality and adding convenient manual override capabilities.
