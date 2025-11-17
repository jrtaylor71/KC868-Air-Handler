#!/bin/bash

# KC868-A8S Air Handler Release Script
# Usage: ./release.sh <version> [tag_message]

set -e

VERSION=$1
TAG_MESSAGE=${2:-"Release version $VERSION"}

if [ -z "$VERSION" ]; then
    echo "Usage: $0 <version> [tag_message]"
    echo "Example: $0 1.0.1 'Bug fixes and improvements'"
    exit 1
fi

# Validate version format (semantic versioning)
if ! [[ $VERSION =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Error: Version must be in format X.Y.Z (e.g., 1.0.1)"
    exit 1
fi

echo "Creating release $VERSION..."

# Update VERSION file
echo "$VERSION" > VERSION

# Update ESPHome configuration
sed -i "s/version: \".*\"/version: \"$VERSION\"/" kc868-a8s-airhandler.yaml
# Only update the firmware version sensor, not all return statements
sed -i "/name: \"Firmware Version\"/,/lambda:/{s/return {\".*\"};/return {\"$VERSION\"};/}" kc868-a8s-airhandler.yaml

echo "Updated version to $VERSION in:"
echo "  - VERSION"
echo "  - kc868-a8s-airhandler.yaml"

# Check if git repo exists
if [ ! -d ".git" ]; then
    echo "Error: Not a git repository. Initialize git first."
    exit 1
fi

# Stage changes
git add VERSION kc868-a8s-airhandler.yaml

# Check if there are any other uncommitted changes
if ! git diff --staged --quiet; then
    echo "Committing version bump..."
    git commit -m "Bump version to $VERSION"
fi

# Create and push tag
echo "Creating git tag v$VERSION..."
git tag -a "v$VERSION" -m "$TAG_MESSAGE"

echo "Release $VERSION created successfully!"
echo ""
echo "To push to GitHub:"
echo "  git push origin master"
echo "  git push origin v$VERSION"
echo ""
echo "Or push everything at once:"
echo "  git push origin master --tags"