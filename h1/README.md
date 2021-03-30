# H1

First weeks assignments.

* [a) Get invited to HackTheBox](#a--get-invited-to-hackthebox)
* [b) Install WebGoat and log in](#b--install-webgoat-and-log-in)
* [c) Solve WebGoat assignments](#c--solve-webgoat-assignments)
* [d) Summarize Darknet Diaries episode](#d--summarize-darknet-diaries-episode)

---

## a) Get invited to HackTheBox

- opened developer console and found the first clue, that pointed me to search interesting Javascript file
- found inviteapi.min.js named file pretty quickly, that had obfuscated Javascript function. I didn't try to solve the obfuscation and just tried makeInviteCode function, that guided me to make POST HTTP request to /api/invite/how/to/generate.
- I did a POST HTTP request with curl to /api/invite/how/to/generate and received BASE64 encoded string

    curl -L -v -X POST www.hackthebox.eu/api/invite/how/to/generate

- I opened the encoded string like this and received the next clue

    echo "SW4gb3JkZXIgdG8gZ2VuZXJhdGUgdGhlIGludml0ZSBjb2RlLCBtYWtlIGEgUE9TVCByZXF1ZXN0IHRvIC9hcGkvaW52aXRlL2dlbmVyYXRl" | base64 -d

- The message said: "In order to generate the invite code, make a POST request to /api/invite/generate"

    curl -L -v -X POST www.hackthebox.eu/api/invite/generate

- call gave me another BASE64 encoded string, which I opened and it gave me the code to log in to HackTheBox

---

## b) Install WebGoat and log in

I downloaded [WebGoat Docker image](https://hub.docker.com/r/webgoat/webgoat-8.0/), ran it and managed to log in.

---

## c) Solve WebGoat assignments

- HTTP Basics
- Developer tools
- CIA Triad
- A1 Injection (intro)

TBA

---

## d) Summarize Darknet Diaries episode

TBA
