---

title: "[ssh key] for first time git users"
excerpt: "welcome to programming"
date: 2024-07-27
lastmod: 2024-07-30 23:16:27 -0400
last_modified_at: 2024-07-30 23:16:27 -0400
categories: project
tags: git ssh-key system
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

<!--postNo: 2024-07-30-->

### Connect!

```shell
cd ~/.ssh
ssh-keygen -t rsa -C "your-email-address" -f "github-username"
ssh-add -K ~/.ssh/github-username
pbcopy < ~/.ssh/github-username.pub
```


now paste it into your settings> new ssh key


```shell
cd .ssh
touch config # if config file does not exist
open config
```


add this to the config file:


```shell
#Johanna Github
Host github.com-hl105
	HostName github.com
	User git
	IdentityFile ~/.ssh/github-hl105
```

### Q&A

Q: I’m getting this scary message: `IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY`


A: go to .ssh/known_hosts and get the host name: something like `192.168.3.10`


Then do:


```text
ssh-keygen -R <host> 
```


