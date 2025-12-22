#!/bin/bash

echo "Setting up Git repository for ArgoCD..."

# Initialize git repo if not already initialized
if [ ! -d ".git" ]; then
    git init
    echo "Initialized new Git repository"
else
    echo "Git repository already exists"
fi

# Add all files
git add .

# Commit changes
git commit -m "Add m5-timelapse application manifests for ArgoCD" || echo "No changes to commit or repo already has commits"

echo ""
echo "Next steps:"
echo "1. Create a remote repository on GitHub/GitLab/etc."
echo "2. Run: git remote add origin <your-repo-url>"
echo "3. Run: git push -u origin main"
echo "4. Update m5-timelapse/application.yaml with your actual repo URL"
echo ""
echo "Alternatively, if you have already set up a remote repository, just run the last three commands above."