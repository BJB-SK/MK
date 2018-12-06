-- no payment
insert into [dbo].[email]
    ([address],[subject],[body],[retries],[success],[result],[dtLastAttempt])
select
    [Email], 
    'Problém s platbou za registráciu na MK17', 
    '<b>Milá/ý ' + [Meno] + ' ' + [Priezvisko] + ',</b>' +
    '<br/><br/>' +
    'Žiaľ, doteraz sme nezaevidovali Tvoju platbu.<br/> ' + 
	'Ak si už medzičasom zaplatil(a), pošli nám prosím do nedele 19.2. 19:00 potvrdenie o platbe.<br/> ' +
	'Ak nie, v žiadom prípade už neposielaj platbu na náš účet, kedže registrácia cez internet bola ukončená.<br/><br/>' +
	'Registrovať na mládežnícku konferenciu sa bude dať už len na mieste.<br/><br/>' +
	'S pozdravom,<br/>' +
    'Team MK17<br/>'
    ,
    5,0,'',getutcdate()
  FROM registracia r
  --where email = 'rajsky.tomas@protonmail.com';
  left join payment p on r.idAccount = p.idAccount 
  where p.idAccount is null and idSluziaci is null and (idZbor <> 62 or idZbor is null) 




-- feedback
insert into [dbo].[email]
    ([address],[subject],[body],[retries],[success],[result],[dtLastAttempt])
select
    [Email], 
    N'Sp[ě/ä]tná v[a/ä]zba ku MK018', 
    N'<b>Mil[á/ý/ej] ' + [Meno] + ' ' + [Priezvisko] + N',</b>' +
    N'<br/><br/>' +
    N'[dě/ďa]kujeme Ti za účas[t/ť] na Mládežníck[é/ej] konferenc[i/ii] 2018!!!' +
    N'<br/><br/>' +
    N'Padlo [hodně/veľa] konferových rekord[ů/ov].' +
    N'<br/><br/>' +
    N'[Jestli/Ak] máš čas a chuť, prosím pom[ů/ô]ž nám t[í/ý]m, že vyplníš <b><a href="https://docs.google.com/forms/d/e/1FAIpQLSe6bUNdI46vcSyFNqv8Pd382vCLLPabSYMTc5tO2TgC0enWLw/viewform">[tuhle/túto] anketu</a></b>.' +
    N'<br/><br/>' +
    N'Díky!' +
    N'<br/>' +
    N'Organizačn[í/ý] tím MK'
    ,
    5,0,'',getutcdate()
from [dbo].[registracia] 
where [dtPrisli] is not null and [Email] <> '' and email = 'jaroban@yahoo.com';
-- and [Email] = 'jaroban@yahoo.com';

