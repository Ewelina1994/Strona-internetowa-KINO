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
   print("         
    <div id='content' style='margin-left: 300px;'>
    <div id='posts'>    
    <div class='post-8 page type-page status-publish hentry' id='post-8'>            
    <div class='postbg_top'>
    <div class='comments'><span></span></div>
    <div class='edit'></div>
    </div>

    <div class='postcontent'>                

            <h2 class='postitle'>Kontakt</h2>
            <p>Kasa Kinoteatru otwarta jest na godzinę przed pierwszym seansem w danym dniu projekcji.</p>
            <p>Dane teleadresowe:</p>
                <p>Kinoteatr Słonko</p>
                <p>ul. Częstochowska 4</p>
                <p>63-100 Wieluń</p>
                <p>NIP 785-10-06-437</p>
                <p>tel. 61 28 30 710</p>
                <p>e-mail: info@kinoslonko.pl</p>
   
        <form id='frmNowyKlient' action='P22_C10_dziekujemy.php' method='get'>

            <fieldset>
                <legend>Twoja wiadomosc</legend>
                <p class='lbl'>
                    <label for='Imie'>Imie</label>
                    <input id='Imie' type='text' name='Imie'/>
                </p>
                <p class='lbl'>
                    <label for='Mail'>E-mail</label>
                    <input id='Mail' type='text'  maxlength='40'  name='Mail'/>
                </p>
                <p class='lbl'>
                    <label for='Temat'>Temat</label>
                    <input id='Temat' type='text'  maxlength='200' name='Temat'/>
                </p>
                <p class='lbl'>
                    <label for='Tekst'>Tekst</label>
                    <textarea name='Tekst' form='frmNowyKlient' rows='10' cols='50'></textarea>

                </p>
               
            </fieldset>
            
                        <input type='submit' name='sbtWyslij' value='Wyślij' />
                        <input type='reset' name='rstWyczysc' value='Wyczyść pola'/> 
                        </form>
                       

    </div>
    <div class='postbg_bottom'></div>
    </div>


    </div>
 </div>");
            ?>
       
                      
                </div>

	</body>
</html>