# Version Information

## Current Version: 1.0.0

### Version History
- **v1.0.0** (2025-11-17) - Initial production release

### Versioning Scheme
This project follows [Semantic Versioning](https://semver.org/):
- **MAJOR.MINOR.PATCH** (e.g., 1.0.0)
- **MAJOR**: Incompatible changes (hardware, wiring, or major config changes)
- **MINOR**: New features, backward compatible
- **PATCH**: Bug fixes, minor improvements

### Files Containing Version Info
- `VERSION` - Simple version number file
- `kc868-a8s-airhandler.yaml` - ESPHome project version and firmware version sensor
- `CHANGELOG.md` - Detailed change history
- `README.md` - Project status and current version

### Release Process
1. Update `CHANGELOG.md` with new changes
2. Run `./release.sh <version>` to bump version and create tag
3. Push changes: `git push origin master --tags`

### Version Sensors in ESPHome
- **ESPHome Version**: Shows the ESPHome framework version
- **Firmware Version**: Shows the project version (1.0.0)

### GitHub Releases
All versions are tagged in GitHub and available as releases with detailed changelogs.