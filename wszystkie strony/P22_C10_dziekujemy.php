<!DOCTYPE html>
<html lang=pl>
    <head>
        <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
        <titleKino</title>
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
        //http://localhost/K%C5%82obut/P22_C9/P22_C9_film_edytuj_potw.php?IdFilm=4&Tytul=Na+ko%C5%84cu+%C5%9Bwaita+i+dalej&Rok=2017&Dlugosc=120+min&Opis=film+o+kangurach&IdKategoria=IdKategoria_wyb&sbtWyslij=Wy%C5%9Blij
        if (!isset($_GET["Imie"]) 
            || ($_GET["Imie"] == '') 

            || !isset($_GET["Mail"]) 
            || ($_GET["Mail"] == '') 

            || !isset($_GET["Temat"]) 
            || ($_GET["Temat"] == '')

            || !isset($_GET["Tekst"]) 
            ||  ($_GET["Tekst"] == ''))
            
                {
                    print("<p class='msg error'>Dane wiadomości są nie poprawne</p>");
                    die(print("<a href='P22_C10_kontakt.php'>Powrót do kontaktu</a>"));
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
           // print('<p class='msg success'>Połączenie z serwere baz danych $serwer powiodło się.</p>');

            
            $Imie= $_GET["Imie"];
            $Mail= $_GET["Mail"];
            $Temat= $_GET["Temat"];
            $Tekst= $_GET["Tekst"];
           
            $komenda_sql = "SELECT *	
                FROM dbo.Wiadomosc";
            $zbior_wierszy = sqlsrv_query($polaczenie, $komenda_sql);
            $JakieIdWiadomosci=1;
            while($wiersz = sqlsrv_fetch_array($zbior_wierszy, SQLSRV_FETCH_ASSOC))
            {
                $JakieIdWiadomosci++;
            }
         
            //Polecenie SQL, pobierjaące wiersze z tabeli
            $komenda_sql = "INSERT dbo.Wiadomosc
            (IdWiadomosc, Imie, Temat, Tresc, Data, Mail)
            VALUES
            ($JakieIdWiadomosci, '$Imie', '$Temat', '$Tekst', GETDATE(), '$Mail');";
            
            
            //Uruchomienie polecenia SQL na serwerze
            
            $rezultat = sqlsrv_query($polaczenie, $komenda_sql);
            if($rezultat == false)
            {
                print("<p class='msg error'>Zapisanie wiadomosci nie powiodło się</p>");
            }
            else
            {
                 print("<p class='msg succes'>Dodanie wiadomosci powiodło się</p>");
            }
      
           print("<a href='P22_C10_kontakt.php'>Powrót do kontaktu</a>");
         
            
            //Zamkniecie polaczenia z serwerem
            if($polaczenie != false)
            {
                sqlsrv_close($polaczenie);
            }
              
        }
      }
       
?>
 
	</body>
</html>