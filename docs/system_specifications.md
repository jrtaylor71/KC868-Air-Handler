# KC868-A8S Air Handler System Specifications

## Hardware Specifications

### KC868-A8S Controller
- **Microcontroller**: ESP32-WROOM-32 module
- **Power Supply**: 12V DC, 1-2A typical
- **Relays**: 8 channels, 10A @ 250VAC / 10A @ 30VDC each
- **Digital Inputs**: 8 channels via PCF8574 (24V compatible with proper interface)
- **Communication**: WiFi 802.11 b/g/n, Ethernet optional
- **GPIO**: Multiple available for sensors and expansion
- **Operating Temperature**: -10°C to +70°C
- **Dimensions**: Standard DIN rail mounting

### Power Supply (UMLIFE 24V→12V Converter)
- **Model**: Amazon B094ZTG5S8
- **Input**: AC 5-30V or DC 5-48V
- **Output**: Adjustable 2.5-35V DC, up to 2A
- **Efficiency**: >85%
- **Protection**: Short circuit, overvoltage, thermal

### Temperature Sensors (DS18B20)
- **Temperature Range**: -55°C to +125°C
- **Accuracy**: ±0.5°C from -10°C to +85°C
- **Resolution**: 9-12 bit (configurable)
- **Interface**: 1-Wire digital
- **Power**: 3.0V to 5.5V

### Custom Thermostat
- **Microcontroller**: ESP32-S3
- **Power Input**: 24 VAC via full-wave bridge
- **Regulation**: LM2596T-5 (24V→5V), AMS1117-3.3 (5V→3.3V)
- **Outputs**: 4 DPDT relays (UC2-3NJ)
- **Current Capacity**: 5A @ 24VDC per relay

## Electrical Specifications

### Power Distribution
- **Primary Power**: 24 VAC transformer (40VA minimum recommended)
- **Control Power**: 12V DC @ 1-2A for KC868-A8S
- **Thermostat Power**: 5V DC @ 0.5A via internal regulation
- **Total System Load**: ~50-60VA including all control circuits

### Relay Ratings
- **Contact Rating**: 10A @ 250VAC, 10A @ 30VDC
- **Blower Circuits**: Line voltage (120V/240V depending on motor)
- **HVAC Controls**: 24 VAC typical
- **Switching Frequency**: Maximum 10Hz per relay

### Input Specifications
- **Signal Type**: Dry contact or isolated 24V
- **Input Impedance**: 10kΩ pull-up via PCF8574
- **Voltage Tolerance**: 0-5V logic levels
- **Response Time**: <100ms with filtering

## Performance Specifications

### Timing Capabilities
- **Heating On Delay**: 0-120 seconds, 5-second resolution
- **Heating Off Delay**: 0-120 seconds, 30-second resolution  
- **Cooling Off Delay**: 0-120 seconds, 30-second resolution
- **Pump Exercise**: 6 minutes, once daily at 3:00 AM
- **Script Execution**: <10ms typical response time

### Temperature Monitoring
- **Update Rate**: 30 seconds per sensor
- **Accuracy**: ±0.5°C in operating range
- **Sensor Locations**: Heat coil, cool coil
- **Cable Length**: Up to 10 feet with proper pull-up

### Communication
- **WiFi Standards**: 802.11 b/g/n, 2.4GHz
- **Protocol**: ESPHome native API, encrypted
- **Update Rate**: 1-second state updates
- **Reliability**: Auto-reconnect, watchdog protection

## System Capacity

### Blower Control
- **Speed Steps**: 4 discrete speeds (Low, Med-Low, Med-High, High)
- **Motor Types**: PSC motors with multiple taps
- **Safety**: Only one speed active at any time
- **Switching**: Make-before-break prevention logic

### HVAC Load Types
- **Hydronic Pump**: 24 VAC or 120 VAC control input
- **Electronic Air Cleaner**: 24 VAC enable signal
- **Humidifier**: 24 VAC solenoid valve
- **Condenser Contactor**: 24 VAC coil (thermostat-controlled)

### Control Logic Capacity
- **Simultaneous Calls**: Handles multiple thermostat calls with priority
- **Mode Priority**: Heat > Cool Stage 2 > Cool Stage 1 > Fan Only
- **Safety Interlocks**: Flow switch monitoring, pump exercise logic
- **Fault Handling**: Automatic recovery, status reporting

## Environmental Specifications

### Operating Conditions
- **Temperature Range**: -10°C to +70°C (KC868-A8S)
- **Humidity**: 5% to 95% RH (non-condensing)
- **Altitude**: Up to 2000m above sea level
- **Vibration**: Suitable for HVAC equipment mounting

### Installation Requirements
- **Enclosure**: NEMA 1 minimum, NEMA 4 recommended for basement/utility areas
- **Ventilation**: Minimum 6 inches clearance around power supply
- **Mounting**: DIN rail or panel mount options
- **Accessibility**: Service access required for configuration changes

## Compliance and Standards

### Safety Standards
- **Electrical**: Follow local electrical codes for line voltage connections
- **HVAC**: Maintains all original safety interlocks
- **Control**: Low voltage control circuits isolated from line voltage

### Communication Standards
- **WiFi**: FCC Part 15, IC RSS-247
- **ESPHome**: Open source, actively maintained
- **Home Assistant**: Local control, no cloud dependency

## Expansion Capabilities

### Future Expansion Options
- **Additional Sensors**: Multiple DS18B20 on same bus
- **More Outputs**: Expansion boards available for KC868 series
- **Advanced Features**: OTA updates, custom automation logic
- **Integration**: MQTT, REST API, custom protocols supported

### Upgrade Path
- **Hardware**: Compatible with KC868-A16 for more I/O
- **Software**: ESPHome provides ongoing feature updates
- **Integration**: Future Home Assistant features automatically supported