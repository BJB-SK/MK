insert into [dbo].[email]
    ([address],[subject],[body],[retries],[success],[result],[dtLastAttempt])
select
    [Email], 
    'Spätná väzba ku MK016', 
    '<b>Milá/ý ' + [Meno] + ' ' + [Priezvisko] + ',</b>' +
    '<br/><br/>' +
    'ďakujeme Ti za účasť na Mládežníckej konferencii 2016!!' +
    '<br/><br/>' +
    'Ak máš čas a chuť, prosím pomôž nám tým, že vyplníš <b><a href="https://docs.google.com/forms/d/1nvwzU-Gu9WmyS3W5NaExGGGceEWXN8te2jp2QfXdI60/viewform">túto anketu</a></b>.' +
    '<br/><br/>' +
    'Díky!' +
    '<br/>' +
    'Organizačný tím MK'
    ,
    5,0,'',getutcdate()
from [dbo].[registracia] 
where [dtPrisli] is not null and [Email] <> '' and email = 'jaroban@yahoo.com';
-- and [Email] = 'jaroban@yahoo.com';
