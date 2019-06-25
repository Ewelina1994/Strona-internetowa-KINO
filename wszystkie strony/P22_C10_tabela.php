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

        <div class='container' style="position: sticky">
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
      <h2>Repertuar na najbliższe dni</h2>
        
    <!--
        <p class="msg success">Komunikat o powodzeniu</p>
         <p class="msg error">Komunikat o błędzie</p>
         <p class="msg info">Komunikat inforamcyjny</p>
         <p class="msg warn">Komunikat ostrzegawczy</p>
        <p class="msg def">Komunikat neutralny</p>
      
     -->

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
        $dane_polaczenia = array("Database" => "KinoEwelina", "CharacterSet" => "UTF-8");
        
        //Próba połączenia
        $polaczenie = sqlsrv_connect($serwer, $dane_polaczenia);
        
        //jezeli połączenie jest nieudane
        if($polaczenie == false)
        {
            /*print("<p class='msg error'>Połączenie z serwerem baz danych $serwer nie powiodło się.</p>");
            die(print_r(sqlsrv_errors(), true));*/
        }
        else
        {
            
            $komenda_sql = "SELECT dbo.Film.IdFilm, Tytul, DataGodzina
                FROM dbo.Film
                INNER JOIN dbo.Seans
                ON dbo.Seans.IdFilm=dbo.Film.IdFilm;";
            
            
            //Uruchomienie polecenia SQL na serwerze
            
            $zbior_wierszy = sqlsrv_query($polaczenie, $komenda_sql);
            
            print("<h2>Seanse filmowe</h2>");
            print("<table>
                    <thead>
                        <tr>
                            <td>Identyfikator</td>
                            <td>Tytul</td>
                            <td>Data</td>
                            <td>Zdjecie</td>
                            <td></td>
                          
                        </tr>
                    </thead>
                    <tbody>");
            
            //Jezeli zwrócony zbior wierszy jest pusty
            if(sqlsrv_has_rows($zbior_wierszy) == false)
            {
                print("<p><tr>
                        <td colspan ='5'>Brak danych filmów w bazie.
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
                   
                    $IdFilm=$wiersz["IdFilm"];
                    $Tytul=$wiersz["Tytul"];
                    $DataGodzina=$wiersz["DataGodzina"]->format("Y-m-d");
                    $Zdjecie=$images[$IdFilm];
                    
                    print("<tr>
                                <td>$IdFilm</td>
                                <td>$Tytul</td>
                                <td>$DataGodzina</td>
                                <td><img src=$Zdjecie alt=''></td>
                                <td><a href='P22_C10_film_szczegoly.php?IdFilm=$IdFilm'>Szczegóły</a></td>
                              
                        </tr>
                                ");
                } // //Pętla pobierania wierszy ze zwróćonego zbioru
                
               sqlsrv_free_stmt($zbior_wierszy); //zwolnienie pamięci
                
            }
            
            
            print("</tbody>
                 </table>");
           
            
            //Zamkniecie polaczenia z serwerem
            if($polaczenie != false)
            {
                sqlsrv_close($polaczenie);
            }
              //IdFilm, Tytul, Rok, Dlugosc, Opis
            
        }
          
        
       
            ?>
        </div>
 
	</body>
</html>