---

title: "cron tutorial"
excerpt: "when you don't want to stay up all night collecting data"
date: 2024-06-17
lastmod: 2024-06-17 17:58:35 -0400
last_modified_at: 2024-06-17 17:58:35 -0400
categories: project
tags: tutorial scraping
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

<!--postNo: 2024-06-17-->


### Q&A section 


**problem**: need to do conda init before you need to conda activate


**solution**: `source ~/.bashrc`  → `conda init --all`


**problem**: conda (base) shows up on terminal prompt


**solution**: `conda config --set auto_activate_base False`


**problem**: permissioned denied to some file


**solution:** `chmod +x path/to/file` (chmod: command to change file permissions, +x: adds executable permission to file)


**problem:** editor isn’t nano


**solution**: `export EDITOR=nano` (sets nano to default), for crontab→ `export VISUAL=nano`


**problem**: command not found


**solution**: check shebang (character sequence at the beginning of a script that specifies the path to the interpreter that should execute the script) & **source the z shell** becaues cron jobs run in a much more limited environment compared to your interactive shell session, we need the .zshrc to be executed because it’s where we initialized conda 


### setting up cron

- create scripts folder `mkdir scripts`
- create your direction file `touch run_gtrends_politics.sh`  in it
- write what you want to repeat in that shell script:

	if you don’t have virtual environments, you don’t need the env activation lines


	**example 1: if z shell & conda**


	```powershell
	#!/usr/bin/env zsh
	
	source ~/.zshrc #we need this
	echo $SHELL
	conda activate ml
	cd  /Users/ihoonsun/Desktop/summer\ projects/sci/summer2024/gtrends_politics
	python example_script.py
	conda deactivate
	```


	**example 2: if bash shell & venv:**


	```powershell
	#!/bin/bash
	echo $SHELL
	export PATH="/Users/ihoonsun/environments/naver-venv/bin:$PATH"
	source /Users/ihoonsun/environments/naver-venv/bin/activate
	if [[ "$(which python)" == "/Users/ihoonsun/environments/naver-venv/bin/python" ]]; then
		echo "venv activated"
	else
		echo "failed to activate"
	fi
	cd /Users/ihoonsun/Desktop/naver 
	/Users/ihoonsun/environments/naver-venv/bin/python3.8  -m pytest scraper.py --headless #run pytest
	deactivate
	
	```

- open shell configuration file and add  environment variables if needed
	- ex) your openai API key

	```powershell
	#directions
	# setting API_KEY environment variable
	# open shell configuration file  (~/.bashrc, ~/.bash_profile, or ~/.zshrc)
	# write: export API_KEY=your_api_key_value and save
	# check if it saved correctly by: echo $API_KEY
	```

- `crontab -e`  to open crontab.
- `0 7-23 * * * /Users/ihoonsun/scripts/run_pytest.sh` add to crontab
- you can check crontab with `crontab -l`

### Extra information (thank you StackOverflow, Google, and chatGPT)

- **what is z shell / bash shell?**
	- zsh: Unix shell that can be used as an interactive login shell and as a powerful command interpreter for shell scripting. Incorporates features of other shells such as `bash`, `ksh`, and `tcsh`, making it highly versatile and customizable.
	- bash: another Unix shell and command language, which is the default shell on many Linux distributions and macOS. It is an improved version of the original Bourne shell (`sh`)
- **what is Shebang** **`#!`****?**
	- a character sequence at the beginning of a script that specifies the path to the interpreter that should execute the script. Is followed by the absolute path to the interpreter.
	- example usage: `#!/usr/bin/env zsh`  ← telling system to use the `zsh` interpreter found by the `env` command in the user's environment.
- **what’s that line of code we’re adding to crontab?**

	```powershell
	* * * * *  command to execute
	┬ ┬ ┬ ┬ ┬
	│ │ │ │ │
	│ │ │ │ │
	│ │ │ │ └─── day of week (0 - 7) (Sunday is 0 or 7)
	│ │ │ └───── month (1 - 12)
	│ │ └─────── day of month (1 - 31)
	│ └───────── hour (0 - 23)
	└─────────── minute (0 - 59)
	```


