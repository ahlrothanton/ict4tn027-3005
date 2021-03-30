# H1

## a) Hanki kutsu HackTheBoxiin.

Ajattelin, että mahdollisesti pitäisi kehittäjäkonsolia käyttää ja tutkin sivuston koodia jonkun aikaa. Tovin pähkäiltyäni vilkaisin konsolia, ja olisikin heti pitänyt tajuta katsoa konsolista, kun ensimmäinen vinkki tuijotti minua sieltä.

Vihje ohjasi etsimään mielenkiintoista javascript-tiedosta ja löysinkin heti inviteapi.min.js nimisen tiedoston, jossa oli obfuskoitu javascript funktio. En kokeillut avata funktiota vaan kokeilin suoraan makeInviteCode funktiota, joka ohjasi minut tekemään POST HTTP-kutsun /api/invite/how/to/generate. Alkuun curl:illa tehty POST kutsu ei palauttanut mitään, mutta kun tajusin nostaa curlin verbositeettiä, niin sain vastaukseksi "301 Moved Permanently". Sain seuraavan vihjeen, kun opastin curl:ia seuraamaan uudelleenohjauksia:

    curl -L -v -X POST www.hackthebox.eu/api/invite/how/to/generate

Kutsu antoi BASE64 enkoodatun merkkijonon, jonka sai auki näin:

    echo "SW4gb3JkZXIgdG8gZ2VuZXJhdGUgdGhlIGludml0ZSBjb2RlLCBtYWtlIGEgUE9TVCByZXF1ZXN0IHRvIC9hcGkvaW52aXRlL2dlbmVyYXRl" | base64 -d

"In order to generate the invite code, make a POST request to /api/invite/generate%"

    curl -L -v -X POST www.hackthebox.eu/api/invite/generate

Viimeisen base64 enkoodatun viestin avattuani pääsin sisälle hackthebox:iin.

## b) Asenna WebGoat ja kokeile, että pääset kirjautumaan sisään.

Latasin [WebGoat:in](https://hub.docker.com/r/webgoat/webgoat-8.0/) Docker:ille ja pääsin kirjautumaan sisään.

## c) Ratkaise WebGoatista tehtävät "HTTP Basics", "Developer tools", "CIA Triad" ja "A1 Injection (intro)". Katso vinkit alta.

TBA

## d) Kuuntele jokin maksuvälineisiin liittyvä jakso Darknet Diaries -podcastista. Kuvaile tiiviisti tämä murto ja peilaa sitä Mika Raution esitykseen "Stealing your payment card data". Voit hakea lisätietoa tapauksesta myös muista lähteistä. (Tässä d-kohdassa ei tarvitse tehdä mitään teknistä harjoitusta, vain kirjoitettu vastaus. Ei tarvitse tavoitella kirjallisuuden Finlandiaa, tiivis vastaus riittää). Vinkki: AntennaPod on hyvä kännykkäohjelma podcastien kuunteluun.

TBA

## e) Vapaaehtoinen: Ratkaise lisää WebGoat-tehtäviä. Kuinka pitkälle pääsit?

TBA

## f) Vapaaehtoinen, haastava: Ratkaise kaikki WebGoat -tehtävät.

## Vinkkejä

- "HTTP Basics": HTTP request ja response näkyvät F12 Console: Network.
- Voit jättää "HTTP Proxies" myöhemmäksi, tämän kotitehtävän voi ratkoa ilman proxya. OWASP Zap on hyvä, niin myös mitmproxy.
- "Developer Tools": F12 Console.
- "A1 Injection (intro)": millaiset lainausmerkit SQL:ssä olikaan? Jos nostat kaikkien palkkaa, oletko enää rikkain? Nämä nimet ("A1 Injection") ovat samat kuin OWASP 10 -dokumentissa.
- Jos SQL kaipaa virkistystä, SQLZoo harjoitukset ja Wikipedia: SQL syntax voivat auttaa
