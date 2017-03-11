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
    N'Spätná väzba ku MK017', 
    N'<b>Milá/ý ' + [Meno] + ' ' + [Priezvisko] + N',</b>' +
    N'<br/><br/>' +
    N'ďakujeme Ti za účasť na Mládežníckej konferencii 2017!!' +
    N'<br/><br/>' +
    N'Ak máš čas a chuť, prosím pomôž nám tým, že vyplníš <b><a href="https://docs.google.com/forms/d/e/1FAIpQLSe6bUNdI46vcSyFNqv8Pd382vCLLPabSYMTc5tO2TgC0enWLw/viewform">túto anketu</a></b>.' +
    N'<br/><br/>' +
    N'Díky!' +
    N'<br/>' +
    N'Organizačný tím MK'
    ,
    5,0,'',getutcdate()
from [dbo].[registracia] 
where [dtPrisli] is not null and [Email] <> '' -- and email = 'jaroban@yahoo.com';
-- and [Email] = 'jaroban@yahoo.com';
