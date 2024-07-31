#!/bin/bash

# Activate Conda environment
source /Users/ihoonsun/anaconda3/etc/profile.d/conda.sh
conda activate blog

# Prompt the user to choose a category
echo "Select a category for the blog post:"
select category in "project" "life" "R"
do
    case $category in
        project ) output_dir="./_posts/projects"; break;;
        life ) output_dir="./_posts/life"; break;;
        stats )  output_dir="./_posts/stats"; break;;
        * ) echo "Invalid option. Please select a number from the list.";;
    esac
done

# Ask the user for the title of the blog post in a regular sentence
read -p "Enter the title of the blog post: " title

# Generate date and format the title into a filename
date_now=$(date +"%Y-%m-%d")
title_formatted=$(echo "$title" | tr '[:upper:]' '[:lower:]' | tr -s '[:space:]' '-' | sed 's/[^a-zA-Z0-9\-]//g')
# Avoid trailing hyphen if title is empty after formatting
filename="${date_now}-$(echo $title_formatted | sed 's/-$//').md"
output_path="$output_dir/$filename"

# Check if the file already exists
if [ ! -f "$output_path" ]; then
    echo "*Awesome* You are making a new post! ღ'ᴗ'ღ"

    # Ask for new Notion page ID to update content
    read -p "Enter the Notion page ID for the new content: " page_id

    # Ask the user for header details
    read -p "Enter the excerpt for the blog post: " excerpt
    read -p "Enter tags for the blog post (space-separated): " tags
    read -p "Enter overlay image file name (should be in assets/images/banners). Enter 'default.png' to use a template: " overlay_image
    last_modified_at=$(date +"%Y-%m-%d %H:%M:%S %z")

    # Run the Node.js script, get the markdown content, and add the header
    node notion-to-md.js $page_id | cat <(echo -e "---\n
title: \"$title\"
excerpt: \"$excerpt\"
date: $date_now
lastmod: $last_modified_at
last_modified_at: $last_modified_at
categories: $category
tags: $tags
classes:
toc: true
toc_label:
toc_sticky: true
header:
    image:
    teaser:
    overlay_image: ./assets/images/banners/$overlay_image
sitemap:
    changefreq: daily
    priority: 1.0
author:
---\n
<!--postNo: $date_now-->\n") - > "$output_path"

    echo "Markdown file created at $output_path"
else
    echo "Updating the blog post..."
    # Extract the header from existing file
    header=$(awk 'BEGIN {printOn=0;} /^---$/ {if (printOn) {print; exit;} else {printOn=1;}} printOn {print;}' "$output_path")
    
    # Ask for new Notion page ID to update content
    read -p "Enter the Notion page ID for the new content: " page_id

    # Get new content and replace the old content
    updated_content=$(node notion-to-md.js $page_id)
    echo "$header
$updated_content" > "$output_path"

    echo "$output_path was successfully updated!"
    
    git status
    git add "$output_path" || echo "Failed to add files to Git"
    git commit -m "Updated blog post: $title" || echo "Failed to commit to Git"
    git push || echo "Failed to push to Git"
fi #end of if block
