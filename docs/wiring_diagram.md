# KC868-A8S Air Handler Wiring Diagram

This document provides complete terminal-by-terminal wiring connections for the KC868-A8S ESPHome air handler replacement project.

## Hardware Components

- **24 VAC Transformer**: R (hot) and C (common) terminals
- **Custom Thermostat**: J1 connector with RC/RH, C, W, Y, G terminals and K1-K4 DPDT relays
- **KC868-A8S**: 12V+/GND power, IN1-IN8/IN-COM inputs, R1-R8 relays (COM/NO)
- **24V→12V Converter**: UMLIFE module with AC~ inputs and +Vout/-Vout outputs
- **Condenser Contactor**: 24 VAC coil
- **DS18B20 Sensors**: VCC/GND/DQ connections

## Power Distribution

### 24 VAC Transformer Connections
| From Device | From Terminal | To Device | To Terminal | Purpose |
|-------------|---------------|-----------|-------------|---------|
| Transformer | R (hot) | Thermostat | J1 RC/RH | Powers thermostat bridge |
| Transformer | C (common) | Thermostat | J1 C | Thermostat return |
| Transformer | R | 24→12V Converter | AC~ 1 | Converter AC input |
| Transformer | C | 24→12V Converter | AC~ 2 | Converter AC input |

### KC868-A8S Power Supply
| From Device | From Terminal | To Device | To Terminal | Purpose |
|-------------|---------------|-----------|-------------|---------|
| 24→12V Converter | +Vout (12V) | KC868-A8S | 12V+ | Main DC supply |
| 24→12V Converter | -Vout (GND) | KC868-A8S | GND/12V- | DC return |

**⚠️ Important**: Adjust converter output to 12.0-12.5V DC before connecting to KC868-A8S.

## Thermostat Signal Connections

### Input Common Reference
| From Device | From Terminal | To Device | To Terminal | Purpose |
|-------------|---------------|-----------|-------------|---------|
| KC868-A8S | IN-COM | Thermostat | K1 COM2 | Common for all inputs |
| KC868-A8S | IN-COM | Thermostat | K2 COM2 | (daisy-chain) |
| KC868-A8S | IN-COM | Thermostat | K3 COM2 | (daisy-chain) |
| KC868-A8S | IN-COM | Thermostat | K4 COM2 | (daisy-chain) |

### Individual Signal Inputs
| Function | From Device | From Terminal | To Device | To Terminal | ESPHome ID |
|----------|-------------|---------------|-----------|-------------|------------|
| Fan (G) | Thermostat | K1 NO2 | KC868-A8S | IN1 | tstat_g |
| Cool Stage 1 (Y1) | Thermostat | K2 NO2 | KC868-A8S | IN2 | tstat_y1 |
| Cool Stage 2 (Y2) | Thermostat | K3 NO2 | KC868-A8S | IN3 | tstat_y2 |
| Heat (W) | Thermostat | K4 NO2 | KC868-A8S | IN4 | tstat_w |

### Optional Flow Switch
| From Device | From Terminal | To Device | To Terminal | Purpose |
|-------------|---------------|-----------|-------------|---------|
| Flow Switch | Contact 1 | KC868-A8S | IN-COM | Common reference |
| Flow Switch | Contact 2 | KC868-A8S | IN5 | Flow switch signal |

## AC Load Connections

### Condenser Contactor (24 VAC)
| From Device | From Terminal | To Device | To Terminal | Purpose |
|-------------|---------------|-----------|-------------|---------|
| Transformer | R | Thermostat | K2 COM1 | Hot feed to Y1 relay |
| Thermostat | K2 NO1 | Contactor | Coil Terminal 1 | Switched 24 VAC |
| Contactor | Coil Terminal 2 | Transformer | C | Return path |

## KC868-A8S Relay Outputs

### 24 VAC Loads Pattern
All 24 VAC loads follow this pattern:
**Transformer R → KC868 Relay COM → KC868 Relay NO → Load Coil → Transformer C**

### Hydronic Pump (Relay 5)
| From Device | From Terminal | To Device | To Terminal |
|-------------|---------------|-----------|-------------|
| Transformer | R | KC868-A8S | Relay 5 COM |
| KC868-A8S | Relay 5 NO | Pump Control | Enable Terminal 1 |
| Pump Control | Enable Terminal 2 | Transformer | C |

### Electronic Air Cleaner (Relay 6)
| From Device | From Terminal | To Device | To Terminal |
|-------------|---------------|-----------|-------------|
| Transformer | R | KC868-A8S | Relay 6 COM |
| KC868-A8S | Relay 6 NO | EAC Unit | 24V Hot |
| EAC Unit | 24V Common | Transformer | C |

### Humidifier (Relay 7)
| From Device | From Terminal | To Device | To Terminal |
|-------------|---------------|-----------|-------------|
| Transformer | R | KC868-A8S | Relay 7 COM |
| KC868-A8S | Relay 7 NO | Humidifier Valve | Coil Terminal 1 |
| Humidifier Valve | Coil Terminal 2 | Transformer | C |

### Blower Motor Taps (Relays 1-4)
**⚠️ Line Voltage (120V/240V) - Use appropriate safety precautions**

| KC868 Relay | Function | From Device | From Terminal | To Device | To Terminal |
|-------------|----------|-------------|---------------|-----------|-------------|
| Relay 1 | Blower Low | Line Hot (L) | - | KC868-A8S | Relay 1 COM |
| | | KC868-A8S | Relay 1 NO | Blower Motor | Low Speed Tap |
| Relay 2 | Blower Med-Low | Line Hot (L) | - | KC868-A8S | Relay 2 COM |
| | | KC868-A8S | Relay 2 NO | Blower Motor | Med-Low Tap |
| Relay 3 | Blower Med-High | Line Hot (L) | - | KC868-A8S | Relay 3 COM |
| | | KC868-A8S | Relay 3 NO | Blower Motor | Med-High Tap |
| Relay 4 | Blower High | Line Hot (L) | - | KC868-A8S | Relay 4 COM |
| | | KC868-A8S | Relay 4 NO | Blower Motor | High Speed Tap |

**Note**: Blower motor neutral connects to line neutral, same as original wiring.

## Temperature Sensors

### DS18B20 Connections
| From Device | From Terminal | To Device | To Terminal | Purpose |
|-------------|---------------|-----------|-------------|---------|
| KC868-A8S | GPIO14 | Both DS18B20s | DQ | One-wire data |
| KC868-A8S | 3.3V | Both DS18B20s | VCC | Sensor power |
| KC868-A8S | GND | Both DS18B20s | GND | Sensor ground |
| 4.7kΩ Resistor | - | Between DQ and VCC | - | Pull-up resistor |

## Wiring Notes

### Safety Considerations
1. **Disconnect all power** before making connections
2. **Verify voltage levels** with multimeter before connecting
3. **Use appropriate wire gauge** for current loads
4. **Follow local electrical codes**
5. **Test with low-voltage circuits first**

### Installation Sequence
1. Install and test 24V→12V converter output voltage
2. Power KC868-A8S and verify boot/WiFi connection
3. Wire thermostat input signals (dry contacts)
4. Wire 24 VAC loads (pump, EAC, humidifier)
5. Wire line voltage blower connections last
6. Install DS18B20 sensors and update addresses in YAML
7. Commission system with comprehensive testing

### Troubleshooting Connections
- Use multimeter to verify continuity on all dry contact circuits
- Verify proper 24 VAC voltage at all load terminals
- Check DS18B20 addresses in ESPHome logs during initial setup
- Confirm only one blower relay activates at a time during testing