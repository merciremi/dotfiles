#!/bin/bash

current_name=$(git config --global user.name)
current_email=$(git config --global user.email)

if [ -n "$current_name" ] && [ -n "$current_email" ]; then
    echo "Git global user.name is set to '$current_name' and user.email is set to '$current_email'."
else
  echo "Type in your first and last name (no accent or special characters - e.g. 'ç'): "
  read full_name

  echo "Type in your email address (the one used for your GitHub account): "
  read email

  git config --global user.name "$full_name"
  git config --global user.email "$email"

  git add .
  git commit --message "My personal identity for the main gitconfig"
  git push origin main
fi

# Professional email configuration

# Ask if I want to configure a work email?
# read -p "Do you want to configure a work email? (y/n): " configure_email
# echo -n "Do you want to configure a work email? (y/n): "
# read configure_email

# if [[ "$configure_email" == "y" || "$configure_email" == "Y" ]]; then
#     echo -n "Enter your professional name: "
#     read professional_name

#     echo -n "Enter your professional email: "
#     read professional_email

#     work_gitconfig="/work/.gitconfig_include"

#     if [ -f "$work_gitconfig" ]; then
#         git config --file "$work_gitconfig" user.name "$professional_name"
#         git config --file "$work_gitconfig" user.email "$professional_email"
#     else
#         # mkdir -p "$(dirname "$work_gitconfig")"
#         # touch "$work_gitconfig"
#         # If the file does not exist, create it and set the email
#         echo "[user]" > "$work_gitconfig"
#         echo "    name = $full_name" >> "$work_gitconfig"
#         echo "    email = $professional_email" >> "$work_gitconfig"
#     fi

#     echo "Professional email has been set in $work_gitconfig"
# else
#     echo "Skipping work email configuration."
# fi

git remote add upstream git@github.com:merciremi/dotfiles.git

echo "👌 All set!"

