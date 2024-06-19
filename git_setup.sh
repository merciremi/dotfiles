#!/bin/bash

echo "Type in your first and last name (no accent or special characters - e.g. 'ç'): "
read full_name

echo "Type in your email address (the one used for your GitHub account): "
read email

git config --global user.name "$full_name"
git config --global user.email "$email"

git add .
git commit --message "My personal identity for the main gitconfig"
git push origin master

# Professional email configuration

# Ask if I want to configure a work email?
read -p "Do you want to configure a work email? (y/n): " configure_email

if [[ "$configure_email" == "y" || "$configure_email" == "Y" ]]; then
    read -p "Enter your professional name: " professional_name
    read -p "Enter your professional email: " professional_email

    work_gitconfig="/work/.gitconfig_include"

    if [ -f "$work_gitconfig" ]; then
        git config --file "$work_gitconfig" user.name "$professional_name"
        git config --file "$work_gitconfig" user.email "$professional_email"
    else
        # If the file does not exist, create it and set the email
        echo "[user]" > "$work_gitconfig"
        echo "    name = $full_name" >> "$work_gitconfig"
        echo "    email = $professional_email" >> "$work_gitconfig"
    fi

    echo "Professional email has been set in $work_gitconfig"
else
    echo "Skipping work email configuration."
fi

git remote add upstream git@github.com:merciremi/dotfiles.git

echo "👌 All set!"

