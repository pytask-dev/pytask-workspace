# Check out main branch and pull latest changes for all packages
main:
    ./scripts/update_packages_main.sh

# Set up git author and install prek hooks for all packages
setup-repos:
    ./scripts/setup_repos.sh

# Run typing in all package repos that have a justfile
typing:
    for dir in packages/*; do \
        [ -f "$dir/justfile" ] || continue; \
        echo "==> $dir"; \
        just --verbose "$dir/typing"; \
    done

# Run tests in all package repos that have a justfile
test:
    for dir in packages/*; do \
        [ -f "$dir/justfile" ] || continue; \
        echo "==> $dir"; \
        just --verbose "$dir/test"; \
    done

# Run docs in all package repos that have a docs recipe
docs:
    for dir in packages/*; do \
        [ -f "$dir/justfile" ] || continue; \
        rg -q "^docs:" "$dir/justfile" || continue; \
        echo "==> $dir"; \
        just --verbose "$dir/docs"; \
    done
