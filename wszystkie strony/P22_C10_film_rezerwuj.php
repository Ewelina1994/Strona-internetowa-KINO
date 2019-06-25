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



            // Dane połączenia z bazą danych.
            $serwer = "DESKTOP-5RQSUM5\SQLEXPRESS";
            $dane_polaczenia = array("Database" => "KinoEwelina", "CharacterSet" => "UTF-8");

            //Próba połączenia
            $polaczenie = sqlsrv_connect($serwer, $dane_polaczenia);

            $IdSeans=$_GET["IdSeans"];

            //seanse szczegóły tabela
            $komenda_sql = "SELECT DataGodzina, Cena, Nazwa, Tytul, Godzina, IdSeans
            FROM dbo.Seans
				INNER JOIN dbo.Film
				ON dbo.Film.IdFilm=Seans.IdFilm
				INNER JOIN dbo.Sala
				ON dbo.Sala.IdSala=Seans.IdSala
            WHERE dbo.Seans.IdSeans=$IdSeans;";

            //print("<p>Polecenie SQL: $komenda_sql</p>");

            $zbior_wierszy = sqlsrv_query($polaczenie, $komenda_sql);
           

            //Jezeli zwrócony zbior wierszy jest pusty
            if(sqlsrv_has_rows($zbior_wierszy) == false)
            {
                print("<p>Brak danych seansów w bazie.
                        </p>");

            }
            else //Jezeli zostały zwrocone wiersze
            {
                print("
                <table>
                    <thead>
                        <tr>
                            <td>Tytul</td>
                            <td>Data</td>
                            <td>Godzina</td>
                            <td>Cena</td>
                            <td>Nazwa sali</td>

                        </tr>
                    </thead>
                    <tbody>");
                //Pętla pobierania wierszy ze zwróćonego zbioru
                while($wiersz = sqlsrv_fetch_array($zbior_wierszy, SQLSRV_FETCH_ASSOC))
                {
                    //gdyby byla data
                    //$Data=$wiersz["DataZlozenia"]->format("Y-m-d");

                    $IdSeans=$wiersz["IdSeans"];
                    $Tytul=$wiersz["Tytul"];
                    $Data=$wiersz["DataGodzina"]->format("Y-m-d");
                    $Godzina=$wiersz["Godzina"]->format("h:m:s");
                    $Cena=$wiersz["Cena"];
                    $Nazwa=$wiersz["Nazwa"];

                    print("
                            <tr>
                                <td>$Tytul</td>
                                <td>$Data</td>
                                <td>$Godzina</td>
                                <td>$Cena</td>
                                <td>$Nazwa</td>
                            </tr>
                            
                                ");

                } // //Pętla pobierania wierszy ze zwróćonego zbioru

            }


            sqlsrv_free_stmt($zbior_wierszy); //zwolnienie pamięci


            print("</tbody>
                 </table>");
            //Formularz dodania nowego uzytkownika
            print("<h2>Wpisz swoje dane</h2>
               <form id='frmNowyKlient' action='P22_C10_nowy.php' method='get' onsubmit='return check()'>

		 <fieldset>
			<legend>Dane osobowe</legend>
                <p class='lbl'>
                <input type='hidden' name='IdSeans' value='$IdSeans'>
                </p>
				<p class='lbl'>
					<label for='Imie'>Imie</label>
					<input id='Imie' type='text' name='Imie'/>
				</p>
				<p class='lbl'>
					<label for='Nazwisko'>Nazwisko</label>
					<input id='Nazwisko' type='text'  maxlength='40'  name='Nazwisko'/>
				</p>
                 <p class='lbl'>
					<label for='NrTel'>NrTel</label>
					<input id='NrTel' type='text'  maxlength='15' name='NrTel'/>
				</p>
                 <p class='lbl'>
					<label for='Pesel'>Pesel</label>
					<input id='Pesel' type='text'  maxlength='11' name='Pesel'/>
				</p>
                <p class='lbl'>
					<label for='E_mail'>E_mail</label>
					<input id='E_mail' type='text'  maxlength='60' name='E_mail' />
				</p>
                <p class='lbl'>
					<label for='Ile'>Ile biletów chcesz kupić</label>
					<input id='Ile' type='text'  maxlength='2' name='Ile' />
				</p>
		</fieldset>

            <input type='submit' name='sbtWyslij' value='Wyślij' /> 
			<input type='reset' name='rstWyczysc' value='Wyczyść pola'/> 
        </form>");





            ?>
        </div>
    </body>
</html>