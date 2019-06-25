<!DOCTYPE html>
<html lang=pl>
    <head>
        <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
        <title>Kino</title>
        <meta name='keywords' content='kino, seans, film' />
        <meta name='author' content='Kino- zarezerwuj film' />
        <script src='https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js'></script>
        <link href='../vendor/css/bootstrap.css' rel='stylesheet'>
        <link href='../vendor/css/style.css' rel='stylesheet'>

    </head>

    <body>

        <div class='container' style='position: sticky'>
            <div class='row'>
                <div class='col-md-6'>
                    <div class='logo'>
                        <a href='/21,Rzeszow/StronaGlowna/'>
                            <img src='../assets/sloneczko.png' alt='Słoneczko'>
                        </a>
                    </div>
                </div>
                <div class='nazwa'>
                    <h2>Kino Słoneczko</h2>
                </div>
            </div>


            <nav id='myNav' class='navbar navbar-dark bg-dark navbar-expand-sm navbar-fixed-top' style='position: sticky'>
                <div class='collapse navbar-collapse align-items-center' id='navBarMain'>
                    <ul class='navbar-nav '>
                        <li class='nav-item'><a href='strona_glowna.php' class='nav-link'>Oferta</a></li>
                        <li class='nav-item'><a href='P22_C10_tabela.php' class='nav-link'>Repertuar</a></li>
                        <li class='nav-item'><a href='cennik.html' class='nav-link'>Cennik</a></li>
                        <li class='nav-item'><a href='P22_C10_regulamin.php' class='nav-link'>Regulamin</a></li>
                        <li class='nav-item'><a href='P22_C10_dojazd.php' class='nav-link'>Jak do nas trafić</a></li>
                        <li class='nav-item'><a href='P22_C10_kontakt.php' class='nav-link'>Kontakt</a></li>
                    </ul>
                </div>

            </nav>

            <aside class='badge-info'>
                <p>Rezerwacja <strong>17 854 00 64</strong></p>
            </aside>    

            <?php 
            //http://localhost/studia/Kino%20strona/filmy/P22_C10_nowy.php?IdSeans=2&Imie=jdhjsd&Nazwisko=djfhsjdhfj&NrTel=kdsjfkdjfk&Pesel=kjdfskdjfk&E_mail=ksdjfksdjf&nazwa%5B%5D=1&nazwa%5B%5D=5&nazwa%5B%5D=9&sbtWyslij=Wy%C5%9Blij

            if (!isset($_GET["IdSeans"]) 
                || ($_GET["IdSeans"] == "") 
                || !is_numeric($_GET["IdSeans"])

                || !isset($_GET["Imie"]) 
                || ($_GET["Imie"] == "") 

                || !isset($_GET["Nazwisko"]) 
                || ($_GET["Nazwisko"] == "")

                || !isset($_GET["NrTel"]) 
                ||  ($_GET["NrTel"] == "")
                ||!is_numeric($_GET["NrTel"])

                || !isset($_GET["Pesel"]) 
                || ($_GET["Pesel"] == "")
                ||!is_numeric($_GET["Pesel"])

                || !isset($_GET["E_mail"]) 
                || ($_GET["E_mail"] == "")

                || !isset($_GET["Ile"]) 
                || ($_GET["Ile"] == "")
                ||!is_numeric($_GET["Ile"])
               )

            {
                print("<p class='msg error'>Dane użytkownika są niepoprawne lub niekompletne</p>");
                die(print("<a href='P22_C10_film_rezerwuj.php'>Powrót do rezerwacji</a>"));
            }

else
{
    //Dane serwera baz danych
    $serwer  = "DESKTOP-5RQSUM5\SQLEXPRESS";

    //Dane bazy danych, konta LOGOWANIA I HASŁA
    $dane_polaczenia = array("Database" => "KinoEwelina", "CharacterSet" => "UTF-8");

    //Próba połączenia
    $polaczenie = sqlsrv_connect($serwer, $dane_polaczenia);

    //jezeli połączenie jest nieudane
    if($polaczenie == false)
    {
    }
    else
    {
                    //(IdKlient, Imie, Nazwisko, NrTel, Pesel, Ulica, NrDomu, Miejscowosc, NrLokalu, KodPocztowy, E_mail)
                    $IdSeans= $_GET["IdSeans"];
                    $Imie= $_GET["Imie"];
                    $Nazwisko= $_GET["Nazwisko"];
                    $NrTel= $_GET["NrTel"];
                    $Pesel= $_GET["Pesel"];
                    $EMail= $_GET["E_mail"];
                    $IleBiletow=$_GET["Ile"];


            $komenda_sql = "SELECT DataGodzina, Cena, Nazwa, Tytul, Godzina, IdSeans
            FROM dbo.Seans
				INNER JOIN dbo.Film
				ON dbo.Film.IdFilm=Seans.IdFilm
				INNER JOIN dbo.Sala
				ON dbo.Sala.IdSala=Seans.IdSala
            WHERE dbo.Seans.IdSeans=$IdSeans;";
                    $zbior_wierszy = sqlsrv_query($polaczenie, $komenda_sql);

                    while($wiersz = sqlsrv_fetch_array($zbior_wierszy, SQLSRV_FETCH_ASSOC))
                    {
                        $Tytul=$wiersz["Tytul"];
                        $Data=$wiersz["DataGodzina"]->format("Y-m-d");
                        $Godzina=$wiersz["Godzina"]->format("H:i:s");
                    }


                    $komenda_sql = "SELECT Imie	
                FROM dbo.Klient";
                    $zbior_wierszy = sqlsrv_query($polaczenie, $komenda_sql);
                    $JakieIdKlienta=1;
                    while($wiersz = sqlsrv_fetch_array($zbior_wierszy, SQLSRV_FETCH_ASSOC))
                    {
                        $JakieIdKlienta++;
                    }

                    print("id klienta: $JakieIdKlienta<br/>");
                    print("imie $Imie<br/>");
                    print("nazwisko $Nazwisko<br/>");
                    print("nr tel $NrTel<br/>");
                    print("pesel $Pesel<br/>");
                    print("meil $EMail<br/>");
                    //Polecenie SQL, wstawiające wiersze z tabeli
                    $komenda_sql = "INSERT dbo.Klient
                    (IdKlient, Imie, Nazwisko, NrTel, Pesel, E_mail)
                    VALUES
                    ($JakieIdKlienta, '$Imie', '$Nazwisko', '$NrTel', $Pesel, '$EMail');";


                    //Uruchomienie polecenia SQL na serwerze

                    $rezultat1 = sqlsrv_query($polaczenie, $komenda_sql);
                    if($rezultat1 == false)
                    {
                        print("<p class='msg error'>Podałeś nie poprawne dane spróbuj jeszcze raz</p>");
                    }
                    else
                    {
                        // print("<p class='msg succes'>Dodanie klienta powiodło się</p>");
                    }

                    
                    //REZERWACJA

                    $zapytanie = "SELECT Cena
                From dbo.Seans
                Where IdSeans=$IdSeans;";

                    $zbior_wierszy = sqlsrv_query($polaczenie, $zapytanie);
                    while($wiersz = sqlsrv_fetch_array($zbior_wierszy, SQLSRV_FETCH_ASSOC))
                    {
                        $cenaBiletu=$wiersz["Cena"];
                    }

                    //$ileBiletow=count($tablicaMiejsc);
                    $CeanaRazem=$IleBiletow * $cenaBiletu;


                    $komenda_sql = "SELECT *	
                FROM dbo.Rezerwacja";
                    $zbior_wierszy = sqlsrv_query($polaczenie, $komenda_sql);
                    $JakieIdRezerwacji=1;
                    while($wiersz = sqlsrv_fetch_array($zbior_wierszy, SQLSRV_FETCH_ASSOC))
                    {
                        $JakieIdRezerwacji++;
                    }

                    //Polecenie SQL, pobierjaące wiersze z tabeli
                    $komenda_sql = "INSERT dbo.Rezerwacja
                (IdRezerwacja, DataZlozenia, KwotaLaczna, IdKlient)
                VALUES
                ($JakieIdRezerwacji, GETDATE(), $CeanaRazem, $JakieIdKlienta);";


                    //Uruchomienie polecenia SQL na serwerze

                    $rezultat2 = sqlsrv_query($polaczenie, $komenda_sql);

                    if($rezultat2==true)
                    {
                        print("Dokonałes rezerwacji");
                    }
                    //BILETY

                    $komenda_sql = "SELECT *	
                FROM dbo.Bilet";
                    $zbior_wierszy = sqlsrv_query($polaczenie, $komenda_sql);
                    $JakieIdBilet=1;

                    for( $x = 0; $x < $IleBiletow; $x++ ) 
                    {
                        while($wiersz = sqlsrv_fetch_array($zbior_wierszy, SQLSRV_FETCH_ASSOC))
                        {
                            $JakieIdBilet++;
                        }
                        // print("tablica Miejsc= count($tablicaMiejsc)");
                        // print("tablica Miejsc= $tablicaMiejsc[1]");
                        //Polecenie SQL, pobierjaące wiersze z tabeli
                        $miejsce=$x+1;
                        $zapytanie = "INSERT dbo.Bilet
                        (IdBilet, IdRezerwacja, IdSeans,Miejsce)
                        VALUES
                        ($JakieIdBilet, $JakieIdRezerwacji, $IdSeans, $miejsce);";

                    }

                    $rezultat3 = sqlsrv_query($polaczenie, $zapytanie);
                    //Uruchomienie polecenia SQL na serwerze
                    if($rezultat3==true)
                    {
                        print("dokonałes zakupu $IleBiletow biletów");
                    }
                    if($rezultat1==true && $rezultat2==true && $rezultat3==true)
                    {
                        print("<table>
                        <h1>Dokonałeś rezerwcacji na seans: $Tytul</h1>
                            <tr>
                                <td>Tytul</td>
                                <td>Godzina</td>
                                <td>Ilosc biletów</td>
                                <td>Cena razem</td>
                            </tr>
                            <tr>
                                <td>$Tytul</td>
                                <td>$Godzina</td>
                                <td>$IleBiletow</td>
                                <td>$CeanaRazem</td>
                            </tr>
                            </table>
                            ");
                        
                    }
                    

        }
        print("<p><a href='P22_C10_film_rezerwuj.php?IdSeans=$IdSeans'>Powrót do rezerwacji</a></p>");
        //Zamkniecie polaczenia z serwerem
        if($polaczenie != false)
        {
            sqlsrv_close($polaczenie);
        }


            }

            ?>
        </div>
            </body>
        </html>