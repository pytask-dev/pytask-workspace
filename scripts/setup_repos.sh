#!/bin/bash

# Script to set git author name and email for all repositories in packages directory
# Author: Tobias Raabe <raabe@posteo.de>

set -e  # Exit on any error

AUTHOR_NAME="Tobias Raabe"
AUTHOR_EMAIL="raabe@posteo.de"
PACKAGES_DIR="/Users/tobiasr/git/pytask-workspace/packages"

echo "Setting git author name to '$AUTHOR_NAME' and email to '$AUTHOR_EMAIL' for all repos in packages/"
echo "Also installing pre-commit hooks for each repository"
echo "=========================================================================================================="

# Loop through each directory in packages
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
            
            # Set user name and email for this repository
            git config user.name "$AUTHOR_NAME"
            git config user.email "$AUTHOR_EMAIL"
            
            echo "✓ Set user.name to: $(git config user.name)"
            echo "✓ Set user.email to: $(git config user.email)"
            
            # Install pre-commit hooks
            if command -v pre-commit >/dev/null 2>&1; then
                echo "Installing pre-commit hooks..."
                if pre-commit install; then
                    echo "✓ Pre-commit hooks installed successfully"
                else
                    echo "⚠ Failed to install pre-commit hooks"
                fi
            else
                echo "⚠ pre-commit not found, skipping hook installation"
            fi
        else
            echo "✗ Not a git repository, skipping..."
        fi
    fi
done

echo ""
echo "=========================================================================================================="
echo "Completed setting git author information and installing pre-commit hooks for all repositories!"