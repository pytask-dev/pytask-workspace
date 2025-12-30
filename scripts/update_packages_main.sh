#!/usr/bin/env bash

# Script to check out main branch and pull latest changes for all packages
# Author: Tobias Raabe <raabe@posteo.de>

set -euo pipefail

PACKAGES_DIR="packages"

echo "Checking out main branch and pulling latest changes for all packages..."
echo "======================================================================="

for dir in "$PACKAGES_DIR"/*; do
    if [ -d "$dir" ]; then
        repo_name=$(basename "$dir")
        echo ""
        echo "Processing repository: $repo_name"
        echo "----------------------------------------"
        
        cd "$dir"
        
        # Check if it's a git repository
        if git rev-parse --git-dir > /dev/null 2>&1; then
            echo "✓ Git repository detected"
            
            # Get current branch
            current_branch=$(git branch --show-current)
            echo "Current branch: $current_branch"
            
            # Check out main branch
            if git checkout main 2>/dev/null; then
                echo "✓ Checked out main branch"
            elif git checkout master 2>/dev/null; then
                echo "✓ Checked out master branch"
            else
                echo "⚠ Could not find main or master branch, staying on current branch"
            fi
            
            # Pull latest changes
            if git pull; then
                echo "✓ Successfully pulled latest changes"
            else
                echo "⚠ Failed to pull changes"
            fi
        else
            echo "✗ Not a git repository, skipping..."
        fi
        
        # Return to workspace root
        cd - > /dev/null
    fi
done

echo ""
echo "======================================================================="
echo "Completed updating all packages to main branch!"