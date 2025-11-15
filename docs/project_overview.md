# KC868-A8S ESPHome Air Handler Project Overview

## Project Background

This project replaces a factory Rheem RHWB air handler control board with a KC868-A8S (Kincony 8-channel relay controller) running ESPHome. The primary motivations for this replacement were:

1. **Fix excessive pump cycling**: The original board ran the hydronic pump multiple times per day, interfering with domestic hot water usage
2. **Add advanced features**: Implement configurable delays, pump exercise control, and temperature monitoring
3. **Enable smart home integration**: Connect to Home Assistant via ESPHome

## System Components

### Hardware
- **KC868-A8S**: 8-channel relay controller with ESP32
- **Custom Thermostat**: Built with ESP32-S3, LM2596T-5 regulator, and full-wave bridge
- **24V→12V Converter**: UMLIFE AC/DC buck converter (Amazon B094ZTG5S8)
- **DS18B20 Sensors**: Two temperature sensors for heat and cool coil monitoring
- **Rheem RHWB Air Handler**: Original unit with hydronic heat coil

### Key Features Implemented

#### Heating System
- **Heating On Delay**: Allows coil to warm before blower starts (0-120 seconds, 5-second steps)
- **Heating Off Delay**: Blower and pump run-on after heat call ends (0-120 seconds, 30-second steps)
- **Flow Switch Support**: Optional flow switch monitoring for open-loop systems
- **Daily Pump Exercise**: Runs once at 3:00 AM for 6 minutes if no heat call in last 24 hours

#### Cooling System
- **Two-Stage Cooling**: Configurable single or two-stage operation
- **Cooling Off Delay**: Separate blower run-on after cooling ends (0-120 seconds, 30-second steps)
- **Variable Speed Control**: Four blower speeds with configurable mapping per mode

#### Accessories
- **Electronic Air Cleaner (EAC)**: Separate relay with per-mode enable/disable
- **Humidifier**: Heat-only operation with separate relay
- **Temperature Monitoring**: DS18B20 sensors on heat and cool coils

## System Architecture

### Power Distribution
- 24 VAC transformer powers both thermostat and 24V→12V converter
- KC868-A8S runs on 12V DC from converter
- All HVAC loads remain on 24 VAC circuits

### Communication
- Thermostat outputs drive DPDT relays
- First pole switches 24 VAC to HVAC loads
- Second pole provides dry contacts to KC868-A8S inputs
- ESPHome provides Home Assistant integration via WiFi

### Control Logic Priority
1. Heat (with flow switch safety if enabled)
2. Cool Stage 2
3. Cool Stage 1
4. Cooling off-delay
5. Fan only

## Configuration Benefits

### Compared to Original Board
- **Single daily pump exercise** vs. multiple daily cycles
- **Configurable delays** vs. fixed DIP switch settings
- **Smart home integration** with status monitoring
- **Separate EAC and humidifier control** (8 relays vs. original shared output)
- **Coil temperature monitoring** for diagnostics

### Safety Features
- Only one blower speed active at a time
- Flow switch monitoring prevents dry coil operation (optional)
- Pump exercise only when heat hasn't run in 24 hours
- All original safety interlocks maintained

## Project Files

- `kc868-a8s-airhandler.yaml` - Main ESPHome configuration
- `docs/wiring_diagram.md` - Complete wiring specifications
- `docs/configuration_guide.md` - Setup and tuning instructions
- `docs/troubleshooting.md` - Common issues and solutions