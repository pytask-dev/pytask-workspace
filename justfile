# Check out main branch and pull latest changes for all packages
main:
    ./scripts/update_packages_main.sh

# Set up git author and install pre-commit hooks for all packages
setup-repos:
    ./scripts/setup_repos.sh

# Run typing in all package repos that have a justfile
typing:
    for dir in packages/*; do \
        if [ -f "$$dir/justfile" ]; then \
            (cd "$$dir" && just typing); \
        fi; \
    done
