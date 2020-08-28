# Simply Cheers iOS

Simply Cheers is een applicatie gemaakt om het barsysteem van lokale verenigingen zoals scoutsen of voetbalclubs te digitaliseren. Dit is de mobielie applicatie van dit systeem. Hier is het mogelijk om gebruikers te selecteren en winkelitems te kopen. Alles wordt onmiddellijk opgeslaan in een online databank om alle gegevens bij te houden. Deze mobiele applicatie is voorzien om te functioneren als liteversie van de webapplicatie.

Om het main dashboard van de applicatie te gebruiken en zaken te beheren zoals gebruikers en producten ga naar www.aspers.be. Hier is een login vereist om verder te gaan. Met gebruikersnaam: admin@cheers.be en paswoord: !Test123 is het mogelijk hierop in te loggen. 

Alle onderdelen van deze applicatie zijn geschreven in het kader van de opleiding Toegepaste Informatica aan HoGent. De zelf ontwikkelde online webapplicatie samen met bijhorende REST API (die ook in de mobiele versies wordt gebruikt) is geschreven voor het vak Webapps 3. Daarnaast bestaat er ook een mobiele versie voor Android geschreven voor het vak Native Apps 1.

## Project opzetten

De applicatie is het eenvoudigste op te zetten via XCode. Hier kan je kiezen om via een emulator of fysiek apparaat de applicatie te draaien. Er wordt gebruik gemaakt van Pods om bepaalde externe libraries te laden. Deze zijn geïncludeerd in deze repository en worden in principe automatisch geconfigureerd.

1. Clone het project in XCode
2. Build en run de applicatie op gewenst apparaat

## Gebruik

Bij de eerste opstart van de applicatie zal indien mogelijk automatisch alle beschikbare data geladen worden en weergegeven worden. Indien er geen gebruiker is geselecteerd of een andere gebruiker geselecteerd moet worden is dit mogelijk door op het gebruiker tabblad in de menubalk te klikken. Daar zal ook het huidige saldo van elke gebruiker worden weergegeven. Wanneer een van de producten wordt aangeklikt zal dit worden toegevoegd aan de winkelmand. Het aantal items in de winkelmand wordt ook onderaan in een badge weergegeven. In de winkelmand is een gedetailleerd overzicht van alle items die reeds zijn toegevoegd. Hier kunnen de laatste aanpassingen aan de bestelling gebeuren zoals het toevoegen of verwijderen van items. Door onderaan op de knop "Checkout" te klikken zal de bestelling worden behandeld en het totaalbedrag van het saldo van de geselecteerde gebruiker worden afgetrokken. Wanneer een saldo meer dan €0.00 en €5.00 of minder bedraagt zal dit in het geel worden weergegeven. Saldo's onder €0.00 zullen in het rood getoond worden.

## Auteur

Arjen Trinquet
