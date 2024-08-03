---

title: "All about the Internet"
excerpt: "a crash course on how the internet works"
date: 2024-08-03
lastmod: 2024-08-03 03:31:57 -0400
last_modified_at: 2024-08-03 03:31:57 -0400
categories: project
tags: internet web protocols summary
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

<!--postNo: 2024-08-03-->


### Why did I write this post?


I was reading a blog post yesterday (yes I read tech blogs in my free time) and this one software engineer really emphasized the importance of having domain knowledge instead of just knowing how to run lines of code from new libraries. I realized I was in a web audit lab without having an in-depth knowledge about how the web works, although I have used many of the famous web-related libraries. Also, UDP came up on a hackerrank question yesterday so I thought it would be a good review.


Most of the content is directly copied from the sources listed below. I just organized information across multiple websites in bullet points. All credit to them!


# Definitions


## Protocol


**def:**  set of rules for formatting and processing data. Standardized protocols = a common language computers can use.


 e.g. I speak Korean and English. My friend speaks Japanese and English. We communicate using English, the common language.  


e.g. Two computers communicate using the Internet protocol (IP)


## Network


network-to-network connections make the Internet possible. 


### Network

- group of two or more connected computing devices
- a central hub usually connects all devices in a network. e.g. router
- can have subnetworks:
	- smaller subdivisions of network
	- how very large networks such as those provided by internet service providers (ISPs) manage thousands of IP addresses and connected devices
- internet = network of networks
- computers-computers ← network ← networks ← internet

## Open Systems Interconnection (OSI) Model


abstract conceptualization of how the internet works. Roughly breaks down how data is sent over the Internet into seven layers

- **7. Application layer**:
	- Data generated by and usable by software applications.
	- Main protocol used at this layer is HTTP
- **6. Presentation layer**:
	- Data is translated into a form the application can accept.
	- HTTPS encryption and decryption take place at this layer
- **5. Session layer**:
	- Controls connections between computers.
	- Can also be handled at layer 4 by TCP
- **4. Transport layer**:
	- provides the means for transmitting data between two connected parties, as well as controlling the quality of service.
	- Protocols used here are TCP and UDP
- **3. Network layer:**
	- Handles routing and sending of data.
	- most important protocols are IP and ICMP
	- other protocols: Internet Protocl Security (IPsec) and IGMP
- **2. Data link layer:**
	- Handles communications between devices on the same network
	- If layer 3 is the address on a mail, layer 2 is like the apartment number at that address.
	- Most used protocol is Ethernet
- **1. Physical layer:**
	- packets are converted into electrical, radio, or optical pulses and transmitted as bits over wires, radio waves, or cables

## TCP/IP model 


alternative model of how the Internet works, dividing the processes into four layers instead of seven. 

- 4. Application layer (~layer 7 of OSI)
- 3. Transport layer (~layer 4)
- 2. Internet layer (~layer 3).
	- Note how network layer in OSI ~ Internet layer in TCP/IP
- 1. Network access layer (~layer 1,2)

What about OSI layer 5,6?? Some say they are no longer necessary in the modern internet / they belong to OSI layer 7 / layer 3,4 in TCP/IP


## **packet**: 

- has many `headers`and a `payload` , and trailers and footers
- `header`:
	- has packet info such as:
		- IP addresses of origin, destination,
		- how large the packet is
		- how long network routers should continue to forward the packet before dropping it
		- if the packet is fragmented and if it includes information about reassembling it
	- each header is used by different parts of the networking process.
	- attached by certain types of networking protocols
	- at minimum, has TCP header and IP header
- `payload` is actual data
- most network protocols only attach headers
- we sometimes define packets by the protocol they use, such as `ip packet`

## Uniform Resource Locator (URL)

- contains domain name, protocol, path
- e.g. in `https://`[`www.notion.so`](http://www.notion.so/)`/johannaa/` www.notion.so is the domain name, `https` is the protocol and `/johannaa/` is the path to a specific page

### domain 

- used to access a website from client software
- def: string of text that maps to an alphanumeric IP address
- actual address of a website is a complex numerical IP address like `192.0.2.2`
- DNS lookup:  using DNS we use human-friendly domain names like `google.com` instead.
- managed by domain registries
- broken up into 2-3 parts separated by a dot
	- top-level domain (TLD): last part, e.g. `.com` `.net`
	- second-level domain (2LD): left of TLD
	- thrid-level domain (3LD): left of 2LD
- registry:
	- organizations that manage TLDs
	- registries are managed by the Internet Corporation for Assigned Names and Numbers (ICANN)
	- e.g. If a registar leases a `.com` domain registration to an end user, it must notify VeriSign, the registry for `.com`  domains. It also pays Versign a fee

### Domain Name System (DS)


phonebook of the internet. Humans access information through domain names. Web browsers interact through IP addresses. DNS translates domain names → IP addresses so browsers can load internet resources 

- Each device connected to the internet has a unique IP address which other machines use to find the device.
- DNS servers eliminate the need for humans to memorize IP addresses such as 192.168.1.1 (in IPv4), or more complex newer alphanumeric IP addresses such as 2400:cb00:2048:1::c629:d7a2 (in IPv6).

4 DNS servers are involved in loading a webpage

- DNS recursive resolver:
	- a librarians who is asked to go find a particular book in a library.
	- is a server that receives queries from client machines through applications like web browsers
- Root nameserver:
	- index in a library that points to different racks of books
	- reference to other more specific locations
- Top Level Domain (TLD) nameserver
	- TLD: specific rack of books in library
- Authoritative nameserver:
	- dictionary on a rack of books
	- if the authoritative nameserve has access to the requested record, it will return the IO address for the requested hostname back to the DNS recursor that made the initial reqeust

### Hypertext Transfer Protocol (HTTP)

- Foundation of the World Wide Web.
- Used to load pages on the Internet using hyperlinks.
- Applicaton layer protocol designed to transfer information between networked devices
- typical flow: client machine making a request to a server, which sends a response message
- HTTP method:
	- the action that the HTTP request expects from the queried server
	- common HTTP methods: `GET` and `POST`
		- `GET` request expects information back in return - e.g. webiste
		- `POST` request indicates client is submitting information to the web server - e.g. login information
- HTTP request headers contain core information - e.g. what browser the client is using, what data is being requested
- HTTP request body: body of information the request is transferrin
- HTTP request response: what web clients (browsers) receive from an internet server in answer to an HTTP reqeuest
	- HTTP status code: 1xx = informational 2xx = success 3xx redirection 4xx client error 5xx server error
	- HTTP response headers
	- optional HTTP body: e.g. HTML data that a web browser translates into a webpage
- HTTPS:
	- HTTP is not encrypted (any attacker who intercepts an HTTP message can read it), and HTTPS corrects this by encrypting i
	- uses Transport Layer Security (TLS/SSL) protocol for encryption

# Internet Protocol


Network layer protocol for routing and addressing packets of data so that they can travel across networks and arrive at the correct destination. All IP data packets must present certain information in a certain order, and all IP addresses follow a standardized format. 


e.g. Alice write a letter to Bob. She divides the content into 3 packets and has headers: Letter from Alice, 1 of 3, … and so on. 


IP does not handle packet ordering or error checking. Such functionality requires  transfer protocols.


e.g. The TCP/IP relationship is similar to sending someone a message written on a puzzle through the mail. The message is written down and the puzzle is broken into pieces. Each piece then can travel through a different postal route, some of which take longer than others. When the puzzle pieces arrive after traversing their different paths, the pieces may be out of order. IP makes sure the pieces arrive at their destination address. TCP can be thought of as the puzzle assembler on the other side who puts the pieces together in the right order, asks for missing pieces to be resent, and lets the sender know the puzzle has been received. TCP maintains the connection with the sender from before the first puzzle piece is sent to after the final piece is sent.


Internet Protocol Version 4 (IPv4): 

- primary version of IP used on the Internet today
- due to size constraint with the total number of possible addresses, a newer protocol was developed: IPv6

### IP Routing/ BGP routing


Autonomous systems (AS): 

- Interconnected large networks that make up the internet, which are each responsible for certain blocks of IP addresses
- like a post office! Data packets cross the Internet by hopping from AS to AS until they reach the AS that contains their destination IP address. Routers within that AS send the packet to the IP address
- use Border Gateway Protocol (BGP) to announce which IP addresses they are responsible for and which other ASes they connect to.
	- BGP routing table: database that determines the **fastest** path from AS to AS
	- without BGP, IP packets would bounce around the internet randomly from AS to AS
- peering:
	- process of ASes connect with each other and exchange packets
	- by connecting at physical locations called Internet Exchange Points (IXPs)
		- large local area network (LAN) with a lot of routers, witches, and cable connections

## Transport Protocols


used with Internet Protocol (IP). Most common transport protocols are Transmission Control Protocol (TCP) and User Datagram Protocol (UDP)


### Transmission Control Protocol (TCP)


how devices communicate and transfer packets over the internet

- Three-way handshake: TCP connection goes through 3 processes
	- SYN: client sends initial connection request (SYN) packet to the server to initiate the connection
	- SYN/ACK: server response to that initial packet with SYN/ACK packet to acknowledge the communication
	- ACK: client returns ACK packet to acknowledge the receipt of the packet from the server.
- After this sequence, the TCP connection is open and able to send and receive data
- TCP communications indicates the order in which data packets should be received nad confirm that packets arrive as intended. If a packet doesn’t arrive, TCP requires that it be resent.

### User Datagram Protocol


UDP is is a communication protocol used across the internet for **time-sensitive transmissions.** 


Examples of time-sensitive transmissions

	- video playback (streaming): instead of downloading the whole video like the old days, it loads a bit at a time. Audio/Video data is broken down into data packets
	- DNS lookup

Speeds up communications by not formally establishing a connection before data is transferred (so no handshake process). However, it can cause packets to become lost in transit (no resending like TCP) and create opportunities for explotiations in the form of DDoS attacks (less reliable). 

- UDP packets = datagrams
- this sort of relates to how the Internet is built, because most network routers don’t perform packet ordering / arrival confirmation by design because of additional memory. TCP is a way of filing the gap when an application requires it.

## Distributed denial-of-service (DDoS) attack


causing traffic jams

- malicious attempt to disrupt the normal traffic of a targeted server, service or network by overwhelming the target or its surrounding infrastructure with a flood of internet traffic
- utilize multiple compromised computer systems “botnet” as sources of attack traffic

### Types of attacks

- application layer (OSI layer 7) attacks
	- goal: exhaust the target’s resources to create a denial-of-service
	- HTTP flood: a single HTTP request is computationally cheap to execute on client side, but it can be expensive for the target server to respond to as it loads multiple files and runs database queries in order to create a web page
	- difficult to defend because it’s hard to differentiate malicious traffic from legitimate traffic
- Protocol attacks
	- aka state-exhausation attacks
	- goal: cause a service disruption by over-consuming server resources /  network equipment (firewalls, load balancers) resources by repeatedly sending SYN packets
	- utilizes layer 3 and 4 TCP vulnerability
		- specifically, the handshake process of a TCP connection
	- SYN Flood:
		- sends a series of SYN requests to the target system
		- server would respond to each one of the connection requests and leaves an open port ready to receive the response
		- while the server waits for the final ACK packet, which never arrives, the attacker keeps sending more SYN packets, opening more ports. Once all the available ports have been utilized, the server is unable to function normally
	- type of “half-open attack” because a server is leaving a connection open but the machine on the other side of the connection is not: connection considered “half-open”
- you handle it by:
	- increasing backlog queue: just increase the max number of possible half-open connections
	- recycling oldest half-open TCP connection: overwrite oldest half-open connection
	- SYN cookies: responds to each connection request with a SYN-ACK packet and drops the SYN request from the backlog, leaving the port open for a new connection. If the connection is legit and a final ACK packet is sent from the client machine back to the server, just reconstruct the SYN backlog queue entry. This mitigation effort does lose some information about the TCP connection, but it’s still better than denial-of-service
- Volumetric attack
	- goal: consume all available bandwidth between target and larger internet
	- large amounts of data are sent to a target by using a form of amplification / other means of creating massive traffic
	- DNS amplification: is like if someone were to call a restaurant and say “I’ll have one of everything, please call me back and repeat my whole order,” where the callback number actually belongs to the victim. With very little effort, a long response is generated and sent to the victim.

### Solutions

- blackhole routing
- rate limiting
- web application firewal (WAF): acts as a reverse proxy, protecting the targeted server from certain types of malicious traffic
- anycast network diffusion:  uses an Anycast network to scatter the attack traffic across a network of distributed servers to the point where the traffic is absorbed by the network.

# Sources


[https://www.cloudflare.com/learning/ddos/glossary/user-datagram-protocol-udp/](https://www.cloudflare.com/learning/ddos/glossary/user-datagram-protocol-udp/)


[https://www.cloudflare.com/learning/video/what-is-streaming/](https://www.cloudflare.com/learning/video/what-is-streaming/)


[https://www.cloudflare.com/learning/network-layer/what-is-a-protocol/](https://www.cloudflare.com/learning/network-layer/what-is-a-protocol/)


[https://www.cloudflare.com/learning/network-layer/internet-protocol/](https://www.cloudflare.com/learning/network-layer/internet-protocol/)


[https://www.cloudflare.com/learning/network-layer/what-is-a-packet/](https://www.cloudflare.com/learning/network-layer/what-is-a-packet/)


[https://www.cloudflare.com/learning/ddos/what-is-a-ddos-attack/](https://www.cloudflare.com/learning/ddos/what-is-a-ddos-attack/)


[https://www.cloudflare.com/learning/network-layer/what-is-the-network-layer/](https://www.cloudflare.com/learning/network-layer/what-is-the-network-layer/)


[https://www.cloudflare.com/learning/dns/glossary/what-is-a-domain-name-registrar/](https://www.cloudflare.com/learning/dns/glossary/what-is-a-domain-name-registrar/)


[https://www.cloudflare.com/learning/dns/dns-server-types/](https://www.cloudflare.com/learning/dns/dns-server-types/)


[https://www.cloudflare.com/learning/ddos/what-is-a-ddos-attack/](https://www.cloudflare.com/learning/ddos/what-is-a-ddos-attack/)

