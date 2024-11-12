#!/bin/bash

# Set the location of your dotfiles repository
dotfiles_repo="$HOME/dotfiles"
# Set the name of the dotfiles manifest file
manifest_file="$dotfiles_repo/dotfiles.txt"

# Function to link a single dotfile
link_dotfile() {
  local dotfile="$1"
  local repo_path="$dotfiles_repo/$dotfile"
  local home_path="$HOME/$dotfile"

  # Create the directory structure in the repository if it doesn't exist
  mkdir -p "$(dirname "$repo_path")"

  # Copy the dotfile to the repository
  cp -r "$home_path" "$repo_path"

  # Remove the original dotfile and create a symbolic link
  rm -rf "$home_path"
  ln -s "$repo_path" "$home_path"

  echo "Linked: $dotfile"
}

# Function to manage all dotfiles listed in the manifest
manage_dotfiles() {
  # Check if the manifest file exists
  if [[ ! -f "$manifest_file" ]]; then
    echo "Error: Manifest file '$manifest_file' not found."
    exit 1
  fi

  # Read the manifest file line by line
  while IFS= read -r dotfile; do
    link_dotfile "$dotfile"
  done < "$manifest_file"
}

# Function to stage changes in the repository
stage_changes() {
  cd "$dotfiles_repo"
  git add .
  echo "Staged changes in the dotfiles repository."
}

# Function to commit changes in the repository
commit_changes() {
  cd "$dotfiles_repo"
  read -r -p "Enter commit message: " commit_message
  git commit -m "$commit_message"
  echo "Committed changes in the dotfiles repository."
}

# Function to push changes to the remote repository
push_changes() {
  cd "$dotfiles_repo"
  git push
  echo "Pushed changes to the remote repository."
}

# Main script execution
case "$1" in
  link)
    manage_dotfiles
    ;;
  stage)
    stage_changes
    ;;
  commit)
    commit_changes
    ;;
  push)
    push_changes
    ;;
  *)
    echo "Usage: $0 {link|stage|commit|push}"
    exit 1
    ;;
esac
