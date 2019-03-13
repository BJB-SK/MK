update registracia set
    meno = N'Meno ' + cast(id as nvarchar(max)),
    priezvisko = N'Priezvisko ' + cast(id as nvarchar(max)),
    email = N'email' + cast(id as nvarchar(max)) + N'@gmail.com',
    telefon = N'',
    poznamka = N'';
    
delete from email;

delete from team;

update payment set
    note = N'',
    payer = N'';

delete from hist_registracia;
delete from import;

update account set
    email = N'email' + cast(id as nvarchar(max)) + N'@gmail.com';
