# KC868-A8S Air Handler README

This project replaces a factory Rheem RHWB air handler control board with a KC868-A8S running ESPHome, providing enhanced control features and Home Assistant integration.

## Quick Start

1. **Review Documentation**
   - [`docs/project_overview.md`](docs/project_overview.md) - System overview and benefits
   - [`docs/wiring_diagram.md`](docs/wiring_diagram.md) - Complete wiring instructions
   - [`docs/configuration_guide.md`](docs/configuration_guide.md) - Setup and tuning

2. **Prepare Hardware**
   - KC868-A8S controller
   - 24V→12V power converter (Amazon B094ZTG5S8)
   - Two DS18B20 temperature sensors
   - 4.7kΩ resistor for sensor pull-up

3. **Flash ESPHome Configuration**
   - Update `secrets.yaml` with your WiFi credentials  
   - Flash `kc868-a8s-airhandler.yaml` to the KC868-A8S
   - Follow DS18B20 address discovery procedure in configuration guide

4. **Install and Wire System**
   - Follow terminal-by-terminal wiring diagram
   - Test with low-voltage circuits first
   - Commission with comprehensive system testing

## Key Features

### Enhanced Control
- **Configurable Delays**: Heating on/off delays and cooling off delay
- **Daily Pump Exercise**: Single 6-minute cycle at 3:00 AM (vs. multiple factory cycles)
- **Flow Switch Support**: Optional safety feature for open-loop systems
- **Separate EAC/Humidifier Control**: Individual relays for each accessory

### Smart Integration
- **Home Assistant**: Native ESPHome integration
- **Temperature Monitoring**: DS18B20 sensors on heat and cool coils
- **Status Reporting**: Real-time system mode and component status
- **OTA Updates**: Remote configuration updates via ESPHome

### Improved Efficiency
- **Smart Pump Control**: Eliminates excessive cycling that interferes with hot water
- **Variable Speed Control**: Four blower speeds with per-mode configuration
- **Priority Logic**: Heat > Cool 2 > Cool 1 > Cool off-delay > Fan only

## File Structure

```
kc868-a8s-air_handler/
├── kc868-a8s-airhandler.yaml    # Main ESPHome configuration
├── config/                       # Additional config files
├── docs/                        # Documentation
│   ├── project_overview.md      # System overview
│   ├── wiring_diagram.md        # Complete wiring guide  
│   ├── configuration_guide.md   # Setup and tuning
│   ├── troubleshooting.md       # Issue resolution
│   ├── system_specifications.md # Technical specifications
├── templates/                   # Configuration templates
└── schemas/                     # Validation schemas
```

## Hardware Requirements

- **KC868-A8S**: 8-channel relay controller with ESP32
- **Power Supply**: 24V AC transformer + 24V→12V DC converter
- **Thermostat**: Compatible with standard HVAC thermostat signals (G, Y1, Y2, W)
- **Sensors**: Two DS18B20 temperature sensors for coil monitoring
- **HVAC System**: Hydronic heat coil, multi-speed blower, standard A/C

## Safety Considerations

⚠️ **ELECTRICAL SAFETY**
- This project involves both low voltage (24V) and line voltage (120V/240V) circuits
- Disconnect all power before making connections
- Follow local electrical codes and regulations
- Consider professional installation for line voltage connections

⚠️ **HVAC SAFETY**  
- Maintain all original safety interlocks
- Test thoroughly before relying on system for heating/cooling
- Keep original control board for emergency backup
- Verify proper operation of all safety devices

## Support and Troubleshooting

1. **Check Documentation**: Start with [`docs/troubleshooting.md`](docs/troubleshooting.md)
2. **Enable Debug Logging**: Add debug logging to ESPHome configuration
3. **Monitor Home Assistant**: Use Developer Tools to check entity states
4. **Review Logs**: ESPHome logs provide detailed operational information

## Contributing

When making modifications:
1. Test changes thoroughly in a safe environment
2. Update documentation to reflect changes
3. Maintain compatibility with Home Assistant integration
4. Follow ESPHome best practices and conventions

## License

This project is provided as-is for educational and personal use. Users are responsible for ensuring compliance with local codes and safe installation practices.

---

**Disclaimer**: This project involves modification of HVAC control systems. Improper installation or configuration may result in equipment damage, reduced efficiency, or safety hazards. Professional consultation is recommended for complex installations.