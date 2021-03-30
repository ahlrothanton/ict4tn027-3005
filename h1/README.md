# H1

* [a) Hanki kutsu HackTheBoxiin.](#a--hanki-kutsu-hacktheboxiin)
* [b) Asenna WebGoat ja kokeile, että pääset kirjautumaan sisään.](#b--asenna-webgoat-ja-kokeile--ett--p--set-kirjautumaan-sis--n)
* [c) Ratkaise WebGoatista tehtävät "HTTP Basics", "Developer tools", "CIA Triad" ja "A1 Injection (intro)". Katso vinkit alta.](#c--ratkaise-webgoatista-teht-v-t--http-basics----developer-tools----cia-triad--ja--a1-injection--intro---katso-vinkit-alta)
* [d) Kuuntele jokin maksuvälineisiin liittyvä jakso Darknet Diaries -podcastista. Kuvaile tiiviisti tämä murto ja peilaa sitä Mika Raution esitykseen "Stealing your payment card data". Voit hakea lisätietoa tapauksesta myös muista lähteistä. (Tässä d-kohdassa ei tarvitse tehdä mitään teknistä harjoitusta, vain kirjoitettu vastaus. Ei tarvitse tavoitella kirjallisuuden Finlandiaa, tiivis vastaus riittää). Vinkki: AntennaPod on hyvä kännykkäohjelma podcastien kuunteluun.](#d--kuuntele-jokin-maksuv-lineisiin-liittyv--jakso-darknet-diaries--podcastista-kuvaile-tiiviisti-t-m--murto-ja-peilaa-sit--mika-raution-esitykseen--stealing-your-payment-card-data--voit-hakea-lis-tietoa-tapauksesta-my-s-muista-l-hteist---t-ss--d-kohdassa-ei-tarvitse-tehd--mit--n-teknist--harjoitusta--vain-kirjoitettu-vastaus-ei-tarvitse-tavoitella-kirjallisuuden-finlandiaa--tiivis-vastaus-riitt----vinkki--antennapod-on-hyv--k-nnykk-ohjelma-podcastien-kuunteluun)
* [e) Vapaaehtoinen: Ratkaise lisää WebGoat-tehtäviä. Kuinka pitkälle pääsit?](#e--vapaaehtoinen--ratkaise-lis---webgoat-teht-vi--kuinka-pitk-lle-p--sit-)
* [f) Vapaaehtoinen, haastava: Ratkaise kaikki WebGoat -tehtävät.](#f--vapaaehtoinen--haastava--ratkaise-kaikki-webgoat--teht-v-t)

---

## a) Hanki kutsu HackTheBoxiin.

Ajattelin, että mahdollisesti pitäisi kehittäjäkonsolia käyttää ja tutkin sivuston koodia jonkun aikaa. Tovin pähkäiltyäni vilkaisin konsolia, ja olisikin heti pitänyt tajuta katsoa konsolista, kun ensimmäinen vinkki tuijotti minua sieltä.

Vihje ohjasi etsimään mielenkiintoista javascript-tiedosta ja löysinkin heti inviteapi.min.js nimisen tiedoston, jossa oli obfuskoitu javascript funktio. En kokeillut avata funktiota vaan kokeilin suoraan makeInviteCode funktiota, joka ohjasi minut tekemään POST HTTP-kutsun /api/invite/how/to/generate. Alkuun curl:illa tehty POST kutsu ei palauttanut mitään, mutta kun tajusin nostaa curlin verbositeettiä, niin sain vastaukseksi "301 Moved Permanently". Sain seuraavan vihjeen, kun opastin curl:ia seuraamaan uudelleenohjauksia:

    curl -L -v -X POST www.hackthebox.eu/api/invite/how/to/generate

Kutsu antoi BASE64 enkoodatun merkkijonon, jonka sai auki näin:

    echo "SW4gb3JkZXIgdG8gZ2VuZXJhdGUgdGhlIGludml0ZSBjb2RlLCBtYWtlIGEgUE9TVCByZXF1ZXN0IHRvIC9hcGkvaW52aXRlL2dlbmVyYXRl" | base64 -d

"In order to generate the invite code, make a POST request to /api/invite/generate%"

    curl -L -v -X POST www.hackthebox.eu/api/invite/generate

Viimeisen base64 enkoodatun viestin avattuani pääsin sisälle hackthebox:iin.

---

## b) Asenna WebGoat ja kokeile, että pääset kirjautumaan sisään.

Latasin [WebGoat:in](https://hub.docker.com/r/webgoat/webgoat-8.0/) Docker:ille ja pääsin kirjautumaan sisään.

---

## c) Ratkaise WebGoatista tehtävät "HTTP Basics", "Developer tools", "CIA Triad" ja "A1 Injection (intro)". Katso vinkit alta.

TBA

---

## d) Kuuntele jokin maksuvälineisiin liittyvä jakso Darknet Diaries -podcastista. Kuvaile tiiviisti tämä murto ja peilaa sitä Mika Raution esitykseen "Stealing your payment card data". Voit hakea lisätietoa tapauksesta myös muista lähteistä. (Tässä d-kohdassa ei tarvitse tehdä mitään teknistä harjoitusta, vain kirjoitettu vastaus. Ei tarvitse tavoitella kirjallisuuden Finlandiaa, tiivis vastaus riittää). Vinkki: AntennaPod on hyvä kännykkäohjelma podcastien kuunteluun.

TBA

---

## e) Vapaaehtoinen: Ratkaise lisää WebGoat-tehtäviä. Kuinka pitkälle pääsit?

TBA

---

## f) Vapaaehtoinen, haastava: Ratkaise kaikki WebGoat -tehtävät.

TBA
