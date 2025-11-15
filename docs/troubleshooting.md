# KC868-A8S Air Handler Troubleshooting Guide

This guide covers common issues, diagnostic procedures, and solutions for the KC868-A8S ESPHome air handler system.

## Pre-Installation Checklist

### Power System Verification
- [ ] 24 VAC transformer output voltage confirmed (23-26 VAC)
- [ ] 24V→12V converter adjusted to 12.0-12.5V DC
- [ ] KC868-A8S boots properly on 12V DC
- [ ] WiFi connection established
- [ ] Home Assistant discovery working

### Wiring Verification
- [ ] All thermostat dry contacts tested with multimeter
- [ ] 24 VAC present at all load terminals
- [ ] Line voltage blower connections secure
- [ ] DS18B20 sensors detected in ESPHome logs
- [ ] Ground connections verified

## Common Issues and Solutions

### Power and Boot Issues

#### KC868-A8S Won't Boot
**Symptoms**: No LED activity, no WiFi connection
**Causes**:
- Insufficient power supply current
- Incorrect voltage (not 12V DC)
- Poor connections

**Solutions**:
1. Verify 12V DC at KC868-A8S terminals with multimeter
2. Check 24V→12V converter current capability (minimum 2A)
3. Ensure solid connections at power terminals
4. Try powering with external 12V supply for testing

#### Intermittent Resets
**Symptoms**: Device reboots randomly, WiFi disconnections
**Causes**:
- Voltage drops during relay switching
- Electrical noise from motors
- Inadequate power supply

**Solutions**:
1. Add 470µF capacitor across 12V supply
2. Install ferrite cores on power cables
3. Upgrade to higher-current power supply
4. Separate power feeds for KC868-A8S and high-current loads

### Thermostat Input Issues

#### Inputs Not Responding
**Symptoms**: ESPHome shows no state changes on thermostat calls
**Diagnosis**:
```yaml
# Enable debug logging
logger:
  level: DEBUG
  logs:
    binary_sensor: DEBUG
```

**Solutions**:
1. Verify dry contact closure with multimeter
2. Check common (IN-COM) connection to all relay COM2 terminals
3. Confirm `inverted: true` setting matches wiring polarity
4. Test with manual jumper wire between IN-COM and specific input

#### Wrong Input States
**Symptoms**: Inputs show opposite of expected state
**Cause**: Incorrect `inverted:` setting

**Solution**: Toggle `inverted:` setting in YAML:
```yaml
binary_sensor:
  - platform: gpio
    pin:
      pcf8574: pcf_in
      number: 0
      inverted: false  # Try opposite setting
```

### Relay Output Issues

#### Relays Not Switching
**Symptoms**: No clicking sound, loads don't activate
**Diagnosis**: Check individual relay states in Home Assistant

**Solutions**:
1. Verify 24 VAC at relay COM terminals
2. Test relay operation manually in Home Assistant
3. Check `inverted: true` setting for PCF8574 outputs
4. Measure voltage across relay contacts when energized

#### Multiple Blower Speeds Active
**Symptoms**: Multiple speed relays energized simultaneously
**Cause**: Logic error in update_hvac script

**Debug**: Add logging to script:
```yaml
script:
  - id: update_hvac
    then:
      - lambda: |-
          ESP_LOGD("hvac", "Speed selected: %d", speed);
          // ... rest of script
```

#### Blower Not Starting
**Symptoms**: Relay clicks but blower doesn't run
**Causes**:
- Line voltage not reaching motor
- Motor protection tripped
- Wrong speed tap connection

**Solutions**:
1. Verify line voltage at motor terminals
2. Check motor overload protection
3. Confirm speed tap wiring matches original
4. Test with manual motor switch if available

### Temperature Sensor Issues

#### DS18B20 Not Detected
**Symptoms**: No temperature readings, sensor errors in logs
**Diagnosis**: Check one-wire bus in logs:
```
[D][dallas_temp:070]: Found sensors:
```

**Solutions**:
1. Verify VCC (3.3V), GND, and DQ connections
2. Confirm 4.7kΩ pull-up resistor installation
3. Test with single sensor first
4. Check wire length (keep under 10 feet for reliability)
5. Verify GPIO14 pin assignment

#### Incorrect Temperature Readings
**Symptoms**: Readings obviously wrong (negative values, extreme temperatures)
**Causes**:
- Wrong sensor address in configuration
- Sensor addressing conflict
- Poor connections

**Solutions**:
1. Re-scan for sensor addresses and update YAML
2. Use only one sensor temporarily to verify addresses
3. Check physical sensor mounting and thermal contact

### Flow Switch Issues

#### Flow Switch Not Working
**Symptoms**: System stuck in "HEAT_WAIT_FS" mode
**Diagnosis**: Check flow switch binary sensor state

**Solutions**:
1. Verify flow switch wiring and operation
2. Check `inverted:` setting for flow switch input
3. Disable flow switch temporarily: `Use Flow Switch FS: OFF`
4. Test flow switch with multimeter (should close when flow present)

### HVAC Logic Issues

#### Wrong Mode Priority
**Symptoms**: System doesn't follow expected heat/cool priority
**Debug**: Monitor mode transitions in Home Assistant
**Solution**: Review priority logic in update_hvac script

#### Delays Not Working
**Symptoms**: Blower starts immediately, no off-delay
**Diagnosis**: Check delay settings in Home Assistant
**Solution**: Verify delay values are non-zero and scripts are executing

#### Pump Exercise Not Running
**Symptoms**: No 3 AM pump operation
**Causes**:
- Pump exercise disabled
- Recent heat call preventing exercise
- Time synchronization issues

**Solutions**:
1. Verify `Enable Pump Exercise: ON`
2. Check `last_heat_timestamp` in developer tools
3. Confirm SNTP time synchronization
4. Manually trigger pump exercise for testing

## Diagnostic Procedures

### ESPHome Logging
Enable detailed logging for troubleshooting:
```yaml
logger:
  level: DEBUG
  logs:
    script: DEBUG
    switch: DEBUG
    binary_sensor: DEBUG
    sensor: DEBUG
```

### Manual Testing Procedures

#### Input Testing
1. Use Home Assistant to monitor binary sensor states
2. Manually activate thermostat calls while watching states
3. Verify each input responds correctly

#### Output Testing
1. Manually toggle each relay from Home Assistant
2. Verify proper load activation (listen for relay clicks)
3. Measure voltage at load terminals when relay is active

#### Script Testing
1. Trigger update_hvac script manually
2. Monitor mode changes and relay states
3. Test delay scripts with short durations for quick verification

### Performance Monitoring

#### Key Metrics to Track
- Mode transition timing
- Temperature sensor readings during operation
- Relay activation patterns
- System response to thermostat calls

#### Data Collection
- Export Home Assistant history for pattern analysis
- Monitor ESPHome logs during normal operation
- Track pump exercise timing and effectiveness

## Advanced Troubleshooting

### Network Issues
- Verify WiFi signal strength at installation location
- Check for IP address conflicts
- Monitor Home Assistant integration status

### Electromagnetic Interference (EMI)
- Install ferrite cores on sensor cables
- Route low-voltage wires away from high-current circuits
- Use shielded cable for long sensor runs

### Timing Issues
- Verify SNTP server accessibility
- Check timezone configuration
- Monitor script execution timing

## Emergency Procedures

### System Failure Backup
1. Keep original control board for emergency restoration
2. Document original wiring before modification
3. Maintain bypass procedures for critical heating/cooling

### Quick Disable Procedures
1. Switch to manual thermostat operation
2. Disable specific features via Home Assistant
3. Emergency power disconnect locations

## Support Resources

### Log Analysis
Always include the following when seeking support:
- Complete ESPHome logs during problem occurrence
- Home Assistant state history for relevant entities
- Description of expected vs. actual behavior
- Environmental conditions during issue

### Configuration Backup
- Regular backup of ESPHome YAML files
- Export Home Assistant configuration
- Document any custom modifications

### Hardware Testing Tools
- Digital multimeter for voltage/continuity testing
- Oscilloscope for signal analysis (advanced)
- Temperature measurement tools for sensor verification