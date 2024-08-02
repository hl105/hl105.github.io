---

title: "How to make your terminal pretty"
excerpt: "when you are sick and tired of your boring terminal"
date: 2024-08-02
lastmod: 2024-08-02 02:16:08 -0400
last_modified_at: 2024-08-02 02:16:08 -0400
categories: projects
tags: project terminal personalization
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

<!--postNo: 2024-08-02-->


Tired of staring at your boring terminal that doesn’t even have shortcuts? 


Time to learn iterm ฅ^._.^ฅ


Here’s a screenshot of my cute terminal for your reference:


<figure>
                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722579373/no8arq87aquvcmumf2bq.png" alt="">
                      <figcaption></figcaption>
                  </figure>

### Instructions
1. make sure your default shell is zsh
	- `echo $SHELL`  should give you `/usr/bin/zsh`
	- if not, do: `brew install zsh`  and `chsh -s /bin/zsh`
	- restart your terminal
2. install `Oh My Zsh`

	```text
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	```

3. Download ITerm2: [iterm2.com](http://www.iterm2.com/)
4. Install an iTerm Theme
	- Here, I’ll add mine but you can add whatever theme you want
	- all instructions below are from the theme owner’s repository: [https://github.com/dogrocker/oh-my-zsh-powerline-cute-theme?tab=readme-ov-file](https://github.com/dogrocker/oh-my-zsh-powerline-cute-theme?tab=readme-ov-file)
	- Part 1:
		- download powerline compatible fonts like [Input Mono](http://input.fontbureau.com/)
		- Make sure terminal is using 256-colors mode with `export TERM="xterm-256color"`
		- Download the theme: [here](http://raw.github.com/dogrocker/oh-my-zsh-powerline-cute-theme/master/cute-theme.zsh-theme)
		- Put the file **cute-theme.zsh-theme** in **~/.oh-my-zsh/themes/**
		- Configure the theme in your **~/.zshrc** file:`ZSH_THEME="cute-theme"` ( you can open the file with `open ~/.zshrc`
	- Part 2:
		- Launch iTerm 2
		- Type CMD+i (⌘+i)
		- Navigate to **Colors** tab
		- Click on **Color Presets**
		- Click on **Import**
		- Click on the **schemes** folder
		- Select the **.itermcolors** profiles you would like to import
		- Click on **Color Presets** and choose a color scheme
		- For [iTerm 2](http://iterm2.com/) users, make sure you go into your settings and set both the regular font and the non-ascii font to powerline compatible [fonts](https://github.com/powerline/fonts) or the prompt separators and special characters will not display correctly.
		- you can change the emoji (default is `~` ) by adding this line to .zshrc: `BULLETTRAIN_PROMPT_CHAR="🐹 "`
	- Part 3: Add Extra features
		- add background image: profile > window > background image
		- command-click opens filename/url: pointer > general
	- Part 4: Adding keyboard shortcut for opening iTerm 2
		- create automaton service
			- search (`⌘+space` ) for Automator.app on your computer
			- select `workflow`
			- on the top search bar, search `Launch Application` and double click
			- select iTerm2 and save (`⌘+s`) the workflow
		- set up keyboard shortcut
			- open  the `shortcuts`  application and add a new shortcut

### Shortcuts 
iTerm + Shell shortcuts in general

| **Function**              | **Shortcut**                      |
| ------------------------- | --------------------------------- |
| New Tab                   | `⌘` + `T`                         |
| Close Tab or Window       | `⌘` + `W` (same as many mac apps) |
| Split Window Vertically   | `⌘` + `D`                         |
| Split Window Horizontally | `⌘` + `Shift` + `D`               |


| delete everything on line | `Ctrl` + `U`                  |
| ------------------------- | ----------------------------- |
| search function           | `Ctrl` + `R`                  |
| go back and forth by word | `⌥` + `Left/Right Arrow Keys` |


and that’s how you get a pretty terminal!


