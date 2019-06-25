<!DOCTYPE html>
<html lang=pl>
    <head>
        <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
        <title>Programowanie serwisów internetowych. Lista C5.</title>
        <meta name='keywords' content='serwisy, internetowe, programowanie' />
        <meta name='author' content='Ewelina Kłobut' />
        <link rel="Stylesheet" href="../vendor/css/PSIN_C5_styl.css" type="text/css"/>
    </head>

<body>
<header>
<div class='naglowek'>
    <section class='logo'>
        <a href='/21,Rzeszow/StronaGlowna/'>
            <img src='../assets/sloneczko.png' alt='Słoneczko'>
        </a>
    </section>
    <div id='naglowek_text'>
        <h1>Kino słoneczko</h1>
    </div>
</div>
</header>
<nav>
    <ul>
        <li><a href='strona_glowna.php' class='nav-link'>Oferta</a></li>
        <li><a href='P22_C10_tabela.php' class='nav-link'>Repertuar</a></li>
        <li><a href='cennik.html' class='nav-link'>Cennik</a></li>
        <li><a href='P22_C10_regulamin.php' class='nav-link'>Regulamin</a></li>
        <li><a href='P22_C10_dojazd.php' class='nav-link'>Jak do nas trafić</a></li>
        <li><a href='P22_C10_kontakt.php' class='nav-link'>Kontakt</a></li>
    </ul>
</nav>
<div id='srodek'>
    <div class='artykul'>
        <div class='baner'>
            <img src='http://www.kinoteatrslonko.pl/www/wp-content/uploads/2019/05/Wymarzony-cover.jpg' name='slide' width='500' height='350'>

            <script type ='text/javascript'>
                var i=0;
                var images=[];
                images[0]='http://www.kinoteatrslonko.pl/www/wp-content/uploads/2019/05/Wymarzony-cover.jpg';
                images[1]='http://www.kinoteatrslonko.pl/www/wp-content/uploads/2019/05/Topielisko-klątwa-la-llorony-cover.jpg';
                images[2]='http://www.kinoteatrslonko.pl/www/wp-content/uploads/2019/05/Korek-i-Julia-Bartkowiak-cover.jpg';
                images[3]='http://www.kinoteatrslonko.pl/www/wp-content/uploads/2019/05/John-Wick-3-cover.jpg';
                images[4]='http://www.kinoteatrslonko.pl/www/wp-content/uploads/2019/05/Paskudy.-UglyDolls-cover.jpg';
                images[5]='http://www.kinoteatrslonko.pl/www/wp-content/uploads/2019/05/Trzy-kroki-od-siebie-cover.jpg';
                images[6]='http://www.kinoteatrslonko.pl/www/wp-content/uploads/2019/02/Reklama-w-kinie-cover.jpg';
                images[7]='http://www.kinoteatrslonko.pl/www/wp-content/uploads/2018/03/Terminal-płatniczy-2-cover.jpg';
                images[8]='http://www.kinoteatrslonko.pl/www/wp-content/uploads/2018/09/2018-kino-szkola1-cover.jpg';
                function slideit()
                {
                    document.images.slide.src=images[i];
                    if(i<images.length-1)
                        i++
                    else
                        i=0
                    setTimeout('slideit()',2500)
                }
                slideit()
            </script>
        </div>
    <!--CONTENT-->
    <div id='discrabe_move'>
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

            //seanse szczegóły tabela
            $komenda_sql = "SELECT IdFilm, Tytul, Opis
            FROM dbo.Film";

            //print("<p>Polecenie SQL: $komenda_sql</p>");


            //Uruchomienie polecenia SQL na serwerze
            $zbior_wierszy = sqlsrv_query($polaczenie, $komenda_sql);

            //Jezeli zwrócony zbior wierszy jest pusty
            if(sqlsrv_has_rows($zbior_wierszy) == false)
            {
            print("<p>Brak danych seansów w bazie.
            </p>");

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
            $Opis=$wiersz["Opis"];
            $Zdjecie=$images[$IdFilm];
            print(" <div class='postcontent'>
            <div class='img'>
            <img class='ep_thumb' src='$Zdjecie' alt='Wymarzony cover'  />
            </div>
            <div class='description'>
            <h2>$Tytul</h2>
            <p>$Opis</p>
            </div>
            
            </div>");
            } // //Pętla pobierania wierszy ze zwróćonego zbioru
            }
            }

    ?>
       
    


</div>           

</div>   
       
<aside id='prawy'>
    <?php
    
        $komenda_sql ="SELECT Tytul,DataGodzina, Godzina, Film.IdFilm
        FROM dbo.Seans
        INNER JOIN dbo.Film 
        ON dbo.Seans.IdFilm=dbo.Film.IdFilm
        WHERE DataGodzina BETWEEN GETDATE() AND GETDATE()+1
        ORDER BY DataGodzina ASC;";
        $zbior_wierszy = sqlsrv_query($polaczenie, $komenda_sql);
        $dzisiaj=date("Y-m-d");
        $jutro=$dzisaj+1;
        print("<h2>Seanse na $dzisjaj i $jutro: <h2>");
        while($wiersz = sqlsrv_fetch_array($zbior_wierszy, SQLSRV_FETCH_ASSOC))
        {
        //gdyby byla data
        //$Data=$wiersz["DataZlozenia"]->format("Y-m-d");
        $IdFilm=$wiersz["IdFilm"];
        $Tytul=$wiersz["Tytul"];
        $Data=$wiersz["DataGodzina"]->format("Y-m-d");
        $Godzina=$wiersz["Godzina"]->format("H:i:s");

        print("
        <ul>
        <ul>
            <li><a href='P22_C10_film_szczegoly.php?IdFilm=$IdFilm'>$Tytul</a></li>
            <li>$Data</li>
            <li>$Godzina</li>
        </ul>
        </ul>");
            ?>
           
        

</aside>
</div>

<footer>
    <h3>ⓒ by Ewelina Kłobut</h3>
</footer>
</body>
</html>