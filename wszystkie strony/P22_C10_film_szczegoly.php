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
        //tablica zdj do filmów
        $images[5]='http://www.kinoteatrslonko.pl/www/wp-content/uploads/2019/05/Wymarzony-cover.jpg';
        $images[6]='images.jpg';
        $images[1]='https://ecsmedia.pl/c/trzy-billboardy-za-ebbing-missouri-wydanie-ksiazkowe-w-iext52883593.jpg';
        $images[7]='johnwick2_0.jpg';
        $images[8]='104114_w19.jpg';
        $images[9]='7882313.3.jpg';
        $images[2]='https://static.tezeusz.pl/product_show/images/f0/e4/36//saga-zmierzch-zmierzch-ksiezyc-w-nowiu-zacmienie-przed-switem-cz-i-i-ii-plyty-dvd.jpeg';
        $images[3]='11070.jpg';
        $images[4]='http://coolturalni24.pl/wp-content/uploads/2012/03/Nietykalni-plakat-300x207.jpg';

        //Dane serwera baz danych
          $serwer  = "DESKTOP-5RQSUM5\SQLEXPRESS";
        
        //Dane bazy danych, konta LOGOWANIA I HASŁA
        $dane_polaczenia = array("Database" => "KinoEwelina",  "CharacterSet" => "UTF-8");
        
        //Próba połączenia
        $polaczenie = sqlsrv_connect($serwer, $dane_polaczenia);
        
        //jezeli połączenie jest nieudane
   // print("<p class='msg success'>Połączenie z serwere baz danych $serwer powiodło się.</p>");

    $IdFilm=$_GET["IdFilm"];

    //seanse szczegóły tabela
    $komenda_sql = "SELECT Film.IdFilm,DataGodzina, Cena, Sala.Nazwa, Tytul, Godzina, IdSeans
            FROM dbo.Film
				INNER JOIN dbo.Seans
				ON dbo.Film.IdFilm=Seans.IdFilm
				INNER JOIN dbo.Sala
				ON dbo.Sala.IdSala=Seans.IdSala
            WHERE dbo.Film.IdFilm=$IdFilm;";

    //print("<p>Polecenie SQL: $komenda_sql</p>");


    //Uruchomienie polecenia SQL na serwerze
    $zbior_wierszy = sqlsrv_query($polaczenie, $komenda_sql);
    print("<h2>Seanse filmowe</h2>");
    print("<table>
            <thead>
                <tr>
                    <td>Data</td>
                    <td>Godzina</td>
                    <td>Cena</td>
                    <td>Nazwa sali</td>
                    <td></td>

                </tr>
            </thead>
            <tbody>");

    //Jezeli zwrócony zbior wierszy jest pusty
    if(sqlsrv_has_rows($zbior_wierszy) == false)
    {
        print("<tr>
                <td colspan ='5'>Brak danych seansów w bazie.
                </td>
                </tr>");

    }
    else //Jezeli zostały zwrocone wiersze
    {
        //Pętla pobierania wierszy ze zwróćonego zbioru
        while($wiersz = sqlsrv_fetch_array($zbior_wierszy, SQLSRV_FETCH_ASSOC))
        {
            //gdyby byla data
            //$Data=$wiersz["DataZlozenia"]->format("Y-m-d");

            $IdSeans=$wiersz["IdSeans"];
            //$IdFilm=$wiersz["IdFilm"];
            $Data=$wiersz["DataGodzina"]->format("Y-m-d");
            $Godzina=$wiersz["Godzina"]->format("H:i:s");
            $Cena=$wiersz["Cena"];
            $Nazwa=$wiersz["Nazwa"];

            print("<tr>
                                <td>$Data</td>
                                <td>$Godzina</td>
                                <td>$Cena</td>
                                <td>$Nazwa</td>
                                <td><a href='P22_C10_film_rezerwuj.php?IdSeans=$IdSeans'>Zarezerwuj</a></td>

                        </tr>
                       
                                ");
        } // //Pętla pobierania wierszy ze zwróćonego zbioru
    }
$komenda_sql = "SELECT Tytul, KategoriaNazwa, Rok, Opis, Dlugosc, Zwiastun
FROM.dbo.Film
INNER JOIN dbo.Kategoria
    ON dbo.Film.IdKategoria=dbo.Kategoria.IdKategoria
WHERE dbo.Film.IdFilm=$IdFilm;";

//Uruchomienie polecenia SQL na serwerze
$zbior_wierszy = sqlsrv_query($polaczenie, $komenda_sql);

    print(" </tbody>
            </table><h2>szczegóły filmu </h2><br/><br/>");

//Jezeli zwrócony zbior wierszy jest pusty
if(sqlsrv_has_rows($zbior_wierszy) == false)
{
    print("<p>Brak danych o seansie w bazie.</p>");

}
else //Jezeli zostały zwrocone wiersze
{
        //Pętla pobierania wierszy ze zwróćonego zbioru

        while($wiersz = sqlsrv_fetch_array($zbior_wierszy, SQLSRV_FETCH_ASSOC))
        {
            //gdyby byla data
            //$Data=$wiersz["DataZlozenia"]->format("Y-m-d");


            $Tytul=$wiersz["Tytul"];
            $Kategoria=$wiersz["KategoriaNazwa"];
            $Rok=$wiersz["Rok"];
            $Dlugosc=$wiersz["Dlugosc"];
            $Opis=$wiersz["Opis"];
            $Zwiastun=$wiersz["Zwiastun"];
          
            $Zdjecie=$images[$IdFilm];

            print("
                    <div id='single_content'>
                    <div id='posts'>               

                    <div class='postcontent'>                 
                    <div class='post_content'>
                   
                    <div>
                    <p style='text-align: justify;'><img class='aligncenter size-full wp-image-16787' title='Rocketman cover' src='$Zdjecie' alt='' width='590' height='465' /></p>
                    <div>
                    <div>
                    <div>
                    <div>
                    <article>
                     <h2 class='postitle'><br/><br/>$Tytul</h2>
                    <div style='text-align: justify;'>
                    <div><div><div><div><div><div><div><div><div><div>
                    <p>$Opis</p>
                    </div></div></div></div></div></div></div></div></div></div>
                  
                    </div>
                    </article>
                    </div></div></div></div></div>
                   
                    <p><strong>kategoria</strong>: $Kategoria</p>

                    <h4><span style='color: #ff0000;'><strong>czas trwania:$Dlugosc</strong></span></h4>
                    <p>&nbsp;</p>
                    <p style='text-align: center;'>Obejrzyj zwiastun:</p> 
                  <p style='text-align: center;'><span class='vvqbox vvqyoutube' style='width:425px;height:344px;'><span id='vvq-16785-youtube-1'><a href='$Zwiastun'><img src='http://img.youtube.com/vi/fXmDRYCpcTw/0.jpg' alt='YouTube Preview Image' /></a></span></span></p>

                    </div></div></div>");

            } // //Pętla pobierania wierszy ze zwróćonego zbioru KONIEc
    }
    

        $komenda_sql = "SELECT Imie, Nazwisko, FilmWeb, Rola
        From dbo.Film
        INNER JOIN dbo.ArtystaFilmowy
                    ON dbo.ArtystaFilmowy.IdFilm=dbo.Film.IdFilm
                    INNER JOIN dbo.Artysta
                    ON dbo.Artysta.IdArtysta=dbo.ArtystaFilmowy.IdArtysta
        WHERE dbo.Film.IdFilm=$IdFilm";

        //print("<p>Polecenie SQL: $komenda_sql</p>");


        //Uruchomienie polecenia SQL na serwerze
        $zbior_wierszy = sqlsrv_query($polaczenie, $komenda_sql);

        print(" <p>&nbsp;</p>
        <p><strong>występują</strong>: ");

        //Jezeli zwrócony zbior wierszy jest pusty
        if(sqlsrv_has_rows($zbior_wierszy) == false)
        {
            print("<p>Brak danych aktorów w bazie.</p>");

        }
        else //Jezeli zostały zwrocone wiersze
        {
            //Pętla pobierania wierszy szczegóły seansów
        
            while($wiersz = sqlsrv_fetch_array($zbior_wierszy, SQLSRV_FETCH_ASSOC))
            {
                //gdyby byla data
                //$Data=$wiersz["DataZlozenia"]->format("Y-m-d");


                $Imie=$wiersz["Imie"];
                $Nazwisko=$wiersz["Nazwisko"];
                $FilmWeb=$wiersz["FilmWeb"];
                $Rola=$wiersz["Rola"];

                print("<p>
                <a href='$FilmWeb' rel='v:starring'>$Imie $Nazwisko</a>    Rola:  $Rola</p>");

            }

        }

        sqlsrv_free_stmt($zbior_wierszy); //zwolnienie pamięci
  print("<a href='P22_C10_tabela.php'><br/><br/>Powrót do tabeli filmów</a>");


    
        print("</div>");

?>

</div>
   
    </body>
</html>
