<!DOCTYPE HTML>
<!---
  This file was built off a CSS template under the creative commons. See additional information below:

  Massively by HTML5 UP
  html5up.net | @ajlkn
  Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
--->
<html>
  <head>
    <title>MCM - Search by Bacteria</title>
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
            <a href="bacteriaSearch.php" class="logo">MCM</a>
          </header>

        <!--- Nav --->
          <nav id="nav">
            <ul class="links">
              <li><a href="home.html">Project Description</a></li>
              <li><a href="pathwaySearch.php">Search by Pathway</a></li>
              <li class="active"><a href="bacteriaSearch.php">Search by Bacteria</a></li>
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
                  <span class="date">Search by Bacteria</span>
                  <p>Find metabolite contributions for species of bacteria.</p>
                </header>

                <!--- Form --->
                  <form method="post" action="<?php echo $_SERVER['PHP_SELF'];?>">
                     <div class="row gtr-uniform">
                       <div class="col-12 col-12-xsmall">
                         <input type="text" name="name-text" id="search-text" value="" placeholder="Search by bacteria name" />
                       </div>
                       <div class="col-12 col-12-xsmall">
                         <input type="text" name="description-text" id="search-text" value="" placeholder="Search by description" />
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
                       $searchtext = $_POST['name-text'];
                       $descriptiontext = $_POST['description-text'];
  
                       if (empty($searchtext) and empty($descriptiontext)){
                         echo "No search was provided, please try again.\n";
                       }
                       else {
                       if (!empty($searchtext) and !empty($descriptiontext)){
                         // Query formatting is performed here.
                         $query = "SELECT * FROM bacteria WHERE
                           name LIKE '%$searchtext%' AND comment LIKE '%$descriptiontext%'";
                         $result = mysqli_query($connect, $query)
                           or trigger_error("Query Failed! SQL: $query - Error: "
                           . mysqli_error($connect), E_USER_ERROR);
                       }
                       else if (!empty($searchtext)){
                       // Query formatting is performed here.
                         $query = "SELECT * FROM bacteria WHERE
                           name LIKE '%$searchtext%'";
                         $result = mysqli_query($connect, $query)
                           or trigger_error("Query Failed! SQL: $query - Error: "
                           . mysqli_error($connect), E_USER_ERROR);
                       }
                       else {
                       // Query formatting is performed here.
                         $query = "SELECT * FROM bacteria WHERE
                           comment LIKE '%$descriptiontext%'";
                         $result = mysqli_query($connect, $query)
                           or trigger_error("Query Failed! SQL: $query - Error: "
                           . mysqli_error($connect), E_USER_ERROR);
                       }
                       // If there are results from the query, print them.
                       if ($result = mysqli_query($connect, $query)) {
                         while ($row = mysqli_fetch_row($result)) {
                           printf("<h2>%s</h2>", $row[9]);
                           printf("<b>Organism code:</b> %s", $row[0]);
                           printf("<br><b>Description:</b> %s", $row[8]);

                           $queryEmbedded = "SELECT * FROM metabolic_pathways WHERE map_id IN
                             (SELECT map_id FROM fuzzy_ranking WHERE name LIKE '%$row[6]%')";
                           $resultPath = mysqli_query($connect, $queryEmbedded)
                           or trigger_error("Query Failed! SQL: $queryEmbedded - Error: "
                           . mysqli_error($connect), E_USER_ERROR);
                           if ($resultPath = mysqli_query($connect, $queryEmbedded)){
                             printf("<br><br><h3>Predicted Pathway Contributions</h3>");
                             while ($rowEmbedded = mysqli_fetch_row($resultPath)){
                               if (file_exists("htmlWidgets/genusLevel/$rowEmbedded[1].html")){
                               printf("<section><b>%s:  </b>", $rowEmbedded[0]);
                               printf("<a href=\"htmlWidgets/genusLevel/$rowEmbedded[1].html\">%s</a>", $rowEmbedded[1]);        }
                               printf("</section>");
                             }
                             printf("<hr>");
                           }
                         }
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