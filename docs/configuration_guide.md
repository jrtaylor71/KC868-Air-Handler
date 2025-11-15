# KC868-A8S Air Handler Configuration Guide

This guide covers the setup, configuration, and tuning of the KC868-A8S ESPHome air handler system.

## Initial Setup

### 1. ESPHome Configuration

#### Required Secrets File
Create `secrets.yaml` in your ESPHome directory:
```yaml
wifi_ssid: "YourWiFiNetwork"
wifi_password: "YourWiFiPassword"
```

#### First Flash
1. Connect KC868-A8S to computer via USB
2. Flash the `kc868-a8s-airhandler.yaml` configuration
3. Monitor initial boot logs for any errors
4. Verify WiFi connection and Home Assistant discovery

### 2. DS18B20 Temperature Sensor Setup

#### Get Sensor Addresses
1. Temporarily modify the sensor section to discover addresses:
```yaml
sensor:
  - platform: dallas_temp
    one_wire_id: onewire_bus
    name: "DS18B20 Raw"
    update_interval: 30s
```

2. Flash and check logs for output like:
```
[D][dallas_temp:070]: Found sensors:
[D][dallas_temp:075]: 0x3c00000abcdef128
[D][dallas_temp:075]: 0x4b00000fedcba928
```

3. Update configuration with real addresses:
```yaml
sensor:
  - platform: dallas_temp
    one_wire_id: onewire_bus
    address: 0x3c00000abcdef128  # Heat coil sensor
    name: "Heat Coil Temp"
    id: heat_coil_temp

  - platform: dallas_temp
    one_wire_id: onewire_bus
    address: 0x4b00000fedcba928  # Cool coil sensor
    name: "Cool Coil Temp"
    id: cool_coil_temp
```

## Configuration Settings

### AC Configuration Options

#### Single-Stage vs Two-Stage A/C
- **Single-Stage A/C**: Y2 input ignored, only Y1 controls cooling
- **Two-Stage A/C**: Both Y1 and Y2 active, Y2 takes priority

Set via Home Assistant select entity: `select.ac_configuration`

### Timing Configuration

#### Heating On Delay (0-120 seconds, 5-second steps)
- **Purpose**: Allows hydronic coil to warm before blower starts
- **Default**: 0 seconds (no delay)
- **Recommended**: 30-60 seconds for hydronic systems
- **Behavior**: Pump starts immediately, blower waits for delay period

#### Heating Off Delay (0-120 seconds, 30-second steps)
- **Purpose**: Blower and pump run-on after heat call ends
- **Default**: 30 seconds
- **Recommended**: 30-90 seconds to extract remaining heat
- **Behavior**: Both pump and blower continue running after W call drops

#### Cooling Off Delay (0-120 seconds, 30-second steps)
- **Purpose**: Blower run-on after cooling ends
- **Default**: 30 seconds
- **Recommended**: 30-60 seconds to remove humidity
- **Behavior**: Blower runs at Cool Stage 1 speed after Y1/Y2 drops

### Blower Speed Configuration

#### Speed Mapping (1-4 scale)
- **1**: Low speed
- **2**: Med-Low speed  
- **3**: Med-High speed
- **4**: High speed

#### Per-Mode Speed Settings
- **Cool Stage 1 Blower Speed**: Default 2 (Med-Low)
- **Cool Stage 2 Blower Speed**: Default 4 (High)
- **Heat Blower Speed**: Default 2 (Med-Low)

### Accessory Control

#### Electronic Air Cleaner (EAC)
- **Enable EAC on Heat**: Default 1 (enabled)
- **Enable EAC on Cool**: Default 1 (enabled)
- **Enable EAC on Fan Only**: Default 0 (disabled)

#### Humidifier
- **Enable Humidifier on Heat**: Default 1 (enabled)
- **Behavior**: Only operates during heating with blower running

### Flow Switch Configuration

#### Use Flow Switch FS
- **Purpose**: Safety feature for open-loop hydronic systems
- **Default**: ON (enabled)
- **When Enabled**: 
  - Pump runs immediately on heat call
  - Blower waits until flow switch closes
  - System shows "HEAT_WAIT_FS" status while waiting
- **When Disabled**: Flow switch ignored, normal operation

### Pump Exercise Settings

#### Enable Pump Exercise
- **Purpose**: Prevents stagnation in hydronic systems
- **Default**: ON (enabled)
- **Schedule**: Daily at 3:00 AM
- **Duration**: 6 minutes
- **Conditions**: Only runs if no heat call in previous 24 hours

## Tuning and Optimization

### Initial Commissioning

1. **Test Basic Operation**
   - Verify each thermostat call activates correct modes
   - Check that only one blower speed operates at a time
   - Confirm pump operates on heat calls

2. **Adjust Timing**
   - Start with default delays
   - Monitor coil temperatures during heat cycles
   - Adjust Heating On Delay based on coil warm-up time
   - Tune off-delays for comfort and efficiency

3. **Optimize Blower Speeds**
   - Test airflow at each speed setting
   - Adjust speeds for proper temperature control
   - Balance comfort vs. energy efficiency

### Fine-Tuning Guidelines

#### Heating On Delay Optimization
- Monitor "Heat Coil Temp" sensor
- Set delay to allow coil to reach ~110°F before blower starts
- Typical range: 30-90 seconds for hydronic coils

#### Speed Selection Guidelines
- **Cooling**: Higher speeds for humidity removal and temperature control
- **Heating**: Lower speeds to prevent cold air sensation during warm-up
- **Fan Only**: Match cooling stage 1 speed for circulation

#### Accessory Timing
- **EAC**: Generally enable for all modes with blower operation
- **Humidifier**: Heat-only operation prevents over-humidification

## System Monitoring

### Key Status Indicators

#### Air Handler Mode (text_sensor.air_handler_mode)
- **IDLE**: No calls active
- **FAN_ONLY**: G call only
- **COOL_STAGE_1**: Y1 active
- **COOL_STAGE_2**: Y2 active  
- **HEAT**: W call or heating off-delay active
- **HEAT_WAIT_FS**: Heat call waiting for flow switch (if enabled)
- **COOL_OFF_DELAY**: Cooling off-delay active

#### Blower Speed Selected (text_sensor.blower_speed_selected)
- **OFF**: No blower operation
- **LOW**: Speed 1 active
- **MED_LOW**: Speed 2 active
- **MED_HIGH**: Speed 3 active
- **HIGH**: Speed 4 active

#### Temperature Monitoring
- **Heat Coil Temp**: Monitor for proper heating operation
- **Cool Coil Temp**: Monitor for cooling efficiency and freeze protection

### Performance Metrics
- Monitor pump exercise logs at 3:00 AM
- Track heating/cooling cycle efficiency via coil temperatures
- Verify proper delay timing through mode transitions

## Advanced Configuration

### Custom Automation Ideas

#### Temperature-Based Heating On Delay
Replace fixed delay with temperature-based logic:
- Monitor heat coil temperature
- Start blower when coil reaches target temperature
- Requires custom lambda modifications

#### Adaptive Speed Control
Implement outdoor temperature-based speed adjustments:
- Higher speeds in extreme weather
- Lower speeds during moderate conditions
- Requires additional temperature sensors

#### Enhanced Pump Exercise
- Multiple exercise periods for extreme climates
- Variable duration based on ambient temperature
- Integration with domestic hot water usage patterns

### Integration Examples

#### Home Assistant Automations
- Notify on pump exercise activation
- Alert on abnormal coil temperatures
- Track system runtime statistics

#### Advanced Monitoring
- Log mode transition timing
- Track energy usage patterns
- Implement predictive maintenance alerts