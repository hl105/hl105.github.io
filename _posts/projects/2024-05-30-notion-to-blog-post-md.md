---

title: "Notion to blog post md"
excerpt: "when you are too lazy to write markdwon from scratch but love notion"
date: 2024-05-30
lastmod: 2024-05-30 17:46:58 -0400
last_modified_at: 2024-05-30 17:46:58 -0400
categories: project
tags: notion blog markdown
classes:
toc: true
toc_label:
toc_sticky: true
header:
    image:
    teaser:
    overlay_image: ./assets/images/banners/default.png
sitemap:
    changefreq: daily
    priority: 1.0
author:
---
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
	    header=$(sed -n '/---/,/---/p' "$output_path")
	    
	    # Ask for new Notion page ID to update content
	    read -p "Enter the Notion page ID for the new content: " page_id
	
	    # Get new content and replace the old content
	    updated_content=$(node notion-to-md.js $page_id)
	    echo "$header
	$updated_content" > "$output_path"
	
	    echo "$output_path was successfully updated!"
	    
	    git add "$output_path"
	    git commit -m "Updated blog post: $title"
	    git push
	fi
	
	```

2. make the script executable

	```shell
	chmod +x notion-to-blog.sh 
	```

3. run the script

	```shell
	./notion-to-blog.sh
	```


Now we have a simple program where the script asks the user the info it needs:


The resulting file is automatically saved in the path like this: ./hl105.github.io/_posts/projects/2024-05-30-7c5e1cf7e4c34a5585f829533b17d3d9.md


…and this is how this post was made!


![via GIPHY 프로블로거가 되어보잣](https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExYjhzYWdiMWE1cm1td3lnYjg2ODFzajM0NTdmbTZra3dyejNkaHB2ZyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/c60cIe0Buhi48/giphy.gif)

A few days ago, I asked myself why I’ve been writing my random thoughts on my Notion page instead of this blog. The conclusion: it’s just too much work writing in markdown, creating a file with a specific format, and uploading it. So I created a quick notion to blog direct conversion pipeline!


### Creating the notion-to-md.js file


adoption of  [https://github.com/souvikinator/notion-to-md](https://github.com/souvikinator/notion-to-md)


```javascript
const { Client } = require("@notionhq/client");
const { NotionToMarkdown } = require("notion-to-md");
const fs = require('fs');
// or
// import {NotionToMarkdown} from "notion-to-md";

const notion = new Client({
    auth: "YOUR_SECRET_KEY",
});

// passing notion client to the option
const n2m = new NotionToMarkdown({ notionClient: notion });

(async () => {
    try{
        const mdblocks = await n2m.pageToMarkdown(process.argv[2]);
        const mdString = n2m.toMarkdownString(mdblocks);
        console.log(mdString.parent); //how we pass stdout to shell
    }catch (error) {
        console.error(error);
      }
})();
```


### running this file

1. install nvm

```shell
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
```

1. load nvm

	```shell
	export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
	```

2. Install Node.js version 12.18.1

	(current ver throws error :  `Failed to convert page to Markdown: TypeError [ERR_INVALID_ARG_TYPE]: The "data" argument must be of type string or an instance of Buffer, TypedArray, or DataView. Received an instance of Object`)


	```shell
	nvm install 12.18.1
	nvm use 12.18.1
	```


	`node -v` should show v12.18.1

3. Connect your notion page
	1. [Create an internal integration ](https://www.notion.so/help/create-integrations-with-the-notion-api#create-an-internal-integration)and get your API key
	2. Go to the page you want to go and choose `+Add Connections`
	3. Get the link of the page on the search bar and get the last part (i.e. the page id): it should be something like `7c5e1cf7e4c34a5585f829533b17d3d9`

### Creating a Notion → blog post pipeline using a Shell Script


it’s still a lot of work (for a lazy person like me) to activate the environment with nvm, run that line, and move the output file into the blog post folder, so I’m going to make a shell script with all the commands.


Note that I am using a conda environment “blog”

1. create notion-to-blog.sh file

	```shell
	#!/bin/bash
	
	# Activate Conda environment
	source /Users/ihoonsun/anaconda3/etc/profile.d/conda.sh
	conda activate blog
	
	# Prompt the user to choose a category
	echo "Select a category for the blog post:"
	select category in "project" "life"
	do
	    case $category in
	        project ) output_dir="./_posts/projects"; break;;
	        life ) output_dir="./_posts/life"; break;;
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
	    header=$(sed -n '/---/,/---/p' "$output_path")
	    
	    # Ask for new Notion page ID to update content
	    read -p "Enter the Notion page ID for the new content: " page_id
	
	    # Get new content and replace the old content
	    updated_content=$(node notion-to-md.js $page_id)
	    echo "$header
	$updated_content" > "$output_path"
	
	    echo "$output_path was successfully updated!"
	    
	    git add "$output_path"
	    git commit -m "Updated blog post: $title"
	    git push
	fi
	
	```

2. make the script executable

	```shell
	chmod +x notion-to-blog.sh 
	```

3. run the script

	```shell
	./notion-to-blog.sh
	```


Now we have a simple program where the script asks the user the info it needs:


The resulting file is automatically saved in the path like this: ./hl105.github.io/_posts/projects/2024-05-30-7c5e1cf7e4c34a5585f829533b17d3d9.md


…and this is how this post was made!


![via GIPHY 프로블로거가 되어보잣](https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExYjhzYWdiMWE1cm1td3lnYjg2ODFzajM0NTdmbTZra3dyejNkaHB2ZyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/c60cIe0Buhi48/giphy.gif)
