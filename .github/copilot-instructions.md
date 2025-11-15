<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

# KC868-A8S ESPHome Air Handler Configuration Workspace

This workspace is specifically designed for managing KC868-A8S ESPHome YAML configuration files and connection documentation.

## Project Context
- Device: KC868-A8S (Kincony 8-channel relay controller)
- Platform: ESPHome
- Purpose: Air handler control and automation
- Configuration format: ESPHome YAML
- Documentation: Connection diagrams and technical specifications

## File Organization
- `/config/` - ESPHome YAML configuration files
- `/docs/` - Documentation and connection diagrams  
- `/templates/` - Template files for common ESPHome configurations
- `/schemas/` - YAML schema validation files

## Development Guidelines
- Follow ESPHome YAML configuration best practices
- Use proper indentation (2 spaces) as required by ESPHome
- Validate ESPHome configuration syntax before deployment
- Document all connection changes in the docs folder
- Follow semantic versioning for configuration changes
- Include comments in YAML files for complex configurations
- Test configurations with ESPHome compile before flashing

## KC868-A8S ESPHome Specific Instructions
- When creating ESPHome configurations, consider the 8-channel relay limitations
- Use correct ESP32 GPIO pin mappings for KC868-A8S
- Include proper component definitions for relays, sensors, and switches
- Document power requirements and wiring diagrams
- Use ESPHome's built-in safety features and failsafes
- Test configurations in safe environment before deployment
- Consider Home Assistant integration when designing entities