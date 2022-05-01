<!DOCTYPE HTML>
<!---
  This file was built off a CSS template under the creative commons. See additional information below:

  Massively by HTML5 UP
  html5up.net | @ajlkn
  Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
--->
<html>
  <head>
    <title>MCM - Search by Pathway</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <link rel="stylesheet" href="assets/css/main.css" />
    <noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
  </head>
  <body class="is-preload">

    <!--- Wrapper --->
      <div id="wrapper">

        <!--- Header --->
          <header id="header">
            <a href="pathwaySearch.php" class="logo">MCM</a>
          </header>

        <!--- Nav --->
          <nav id="nav">
            <ul class="links">
              <li><a href="home.html">Project Description</a></li>
              <li class="active"><a href="pathwaySearch.php">Search by Pathway</a></li>
              <li><a href="bacteriaSearch.php">Search by Bacteria</a></li>
            </ul>
            <ul class="icons">
               <li><a href="https://github.com/CalebPecka/BIOI4870" class="icon brands fa-github"><span class="label">GitHub</span></a></li>
            </ul>
          </nav>

        <!--- Main --->
          <div id="main">

            <!--- Featured Post --->
              <article class="post featured">
                <header class="major">
                  <span class="date">Search by Pathway</span>
                  <p>Find metabolite contributions for KEGG pathways.</p>
                </header>

                <!--- Form --->
                  <form method="post" action="<?php echo $_SERVER['PHP_SELF'];?>">
                     <div class="row gtr-uniform">
                       <div class="col-12 col-12-xsmall">
                         <input type="text" name="search-text" id="search-text" value="" placeholder="Begin typing here" />
                       </div>
                       <!--- Break --->
                       <div class="col-6 col-12-small">
                         <input type="radio" id="map_id" value = "map_id" name="radio-general" checked>
                         <label for="map_id">KEGG Map ID</label>
                       </div>
                       <div class="col-6 col-12-small">
                         <input type="radio" id="pathway_name" value = "pathway_name" name="radio-general">
                         <label for="pathway_name">Pathway Name</label>
                       </div>
                       <!--- Break --->
                       <div class="col-12">
                         <ul class="actions">
                           <li><input type="submit" value="Submit" class="primary" /></li>
                           <li><input type="reset" value="Reset" /></li>
                         </ul>
                       </div>
                     </div>
                   </form>

                   <hr />

                   <?php
                     $server="localhost";
                     $username="cpecka";
                     $password="";
                     $database="cpecka";
                     $connect = mysqli_connect($server,$username,"",$database);

                     if($connect->connect_error){
                       echo "We are unable to connect to the database at this time";
                       echo "Connection error:" .$connect->connect_error;
                     }

                     // After the user clicks "Submit" in the form, the following section
                     // of code is run, returning several outputs onto the screen.
                     if ($_SERVER["REQUEST_METHOD"] == "POST") {

                       // Collect input field values
                       $searchtext = $_POST['search-text'];
                       $radiogeneral = $_POST['radio-general'];
  
                       if (empty($searchtext)) {
                         echo "No search text was provided, please try again.\n";
                       } else {
                         if ($radiogeneral == "map_id"){
                           echo "Searching for a KEGG Map ID similar to '$searchtext'.";
                         }
                         else {
                           echo "Searching for a Pathway Name similar to '$searchtext'.";
                         }

                         $query = "SELECT * FROM metabolic_pathways WHERE
                           $radiogeneral LIKE '%$searchtext%'";
                         $result = mysqli_query($connect, $query)
                           or trigger_error("Query Failed! SQL: $query - Error: "
                         . mysqli_error($connect), E_USER_ERROR);
                         $result2 = $result;

                         // If there are results from the query, print them.
                         if ($result = mysqli_query($connect, $query)) {
                           printf("<section class = \"split contact\">");
                           printf("<br>");
                           printf("<h3>Significant Pathways in Claudin Dysbiosis</h3>");
                           while ($row = mysqli_fetch_row($result)) {
                             if (file_exists("htmlWidgets/genusLevel/$row[1].html")){
                               printf("<section><b>%s:  </b>", $row[0]);
                               printf("<a href=\"htmlWidgets/genusLevel/$row[1].html\">%s</a>", $row[1]);
                               printf("</section>");
                             }
                           }

                           printf("<br>");
                           printf("<h3>Non-significant Pathways</h3>");
                           while ($row = mysqli_fetch_row($result2)) {
                             if (file_exists("htmlWidgets/genusLevel/$row[1].html") == false){
                               printf("<section><b>%s:  </b>", $row[0]);
                               printf("%s", $row[1]);
                               printf("</section>");
                             }
                           }

                           printf("</section>");
                         }
                       }
                     }


                     // Close the connection.
                     mysqli_close($connect);
                                        ?>
              </article>
          </div>

        <!--- Footer --->
          <footer id="footer">
            <section class = "split contact">
              <section>
                <h3>Email</h3>
                  <p><a href="mailto:cpecka@unomaha.edu">cpecka@unomaha.edu</a></p>
              </section>
            </section>
            <section class = "split contact">              
              <section>
                <h3>GitHub</h3>
                <ul class="icons alt">
                  <li><a href="https://github.com/CalebPecka/BIOI4870" class="icon brands alt fa-github"><span class="label">GitHub</span></a></li>
                </ul>
              </section>
            </section>
          </footer>

        <!--- Copyright --->
          <div id="copyright">
            <ul><li>HTML template in Creative Commons</li><li>Design: <a href="https://html5up.net">HTML5 UP</a></li></ul>
          </div>

      </div>

    <!--- Scripts --->
      <script src="assets/js/jquery.min.js"></script>
      <script src="assets/js/jquery.scrollex.min.js"></script>
      <script src="assets/js/jquery.scrolly.min.js"></script>
      <script src="assets/js/browser.min.js"></script>
      <script src="assets/js/breakpoints.min.js"></script>
      <script src="assets/js/util.js"></script>
      <script src="assets/js/main.js"></script>

  </body>
</html>