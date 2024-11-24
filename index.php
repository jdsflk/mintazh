<?php
// Connecting to the database
try {
    $db = new PDO("mysql:host=localhost;dbname=mintazh", "root", "");
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    printf('Sikertelen kapcsolódás: ' . $e->getMessage());
    exit;
}

// If a variable exist, retrieve it, otherwise set is to default
$searchTerm = isset($_GET['kereses']) ? $_GET['kereses'] : '';
$sortColumn = isset($_GET['oszlop']) ? $_GET['oszlop'] : 'nev';

// The query includes sorting by name, the search function and counting the members
$query = $db->query("SELECT e.nev AS nev, e.alapitasev As alapitasev, alapito.nev AS alapito, count(em.nev) AS tagszam, e.tagdij AS tagdij
    FROM egyesulet e
        INNER JOIN tagsag t ON e.egyesuletid = t.egyesulet_egyesuletid
        INNER JOIN ember em ON t.ember_emberid = em.emberid
        INNER JOIN ember alapito ON e.alapitoid = alapito.emberid
        WHERE e.nev LIKE '%$searchTerm%'
        GROUP BY e.nev
        ORDER BY $sortColumn;");

// Retrieving the data
$result = $query->fetchAll(PDO::FETCH_OBJ);
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" type="text/css" href="style.css" />
</head>

<body>
    <h1>Egyesületek</h1>
    <!-- Swap with name and neptun code -->
    <p>jdsflk</p>
    <div id="searchBar">
        Név:
        <form method="GET" action="">
            <input type="text" name="kereses" value="<?= htmlspecialchars($searchTerm) ?>" />
            <button type="submit">Keresés</button>
        </form>
    </div>
    <table id="myTable">
        <tr id="table-head">
            <th><a href="?oszlop=nev&kereses=<?= urlencode($searchTerm) ?>"
                    style="<?= $sortColumn === 'nev' ? 'text-decoration: underline;' : '' ?>">Név</a></th>
            <th><a href="?oszlop=alapitasev&kereses=<?= urlencode($searchTerm) ?>"
                    style="<?= $sortColumn === 'alapitasev' ? 'text-decoration: underline;' : '' ?>">Alapítás éve</a>
            </th>
            <th><a href="?oszlop=alapito&kereses=<?= urlencode($searchTerm) ?>"
                    style="<?= $sortColumn === 'alapito' ? 'text-decoration: underline;' : '' ?>">Alapító</a></th>
            <th><a href="?oszlop=tagszam&kereses=<?= urlencode($searchTerm) ?>"
                    style="<?= $sortColumn === 'tagszam' ? 'text-decoration: underline;' : '' ?>">Tagok száma</a></th>
            <th><a href="?oszlop=tagdij&kereses=<?= urlencode($searchTerm) ?>"
                    style="<?= $sortColumn === 'tagdij' ? 'text-decoration: underline;' : '' ?>">Tagsági díj</a></th>
        </tr>
        <?php foreach ($result as $row): ?>
            <tr>
                <td><?= $row->nev ?></td>
                <td><?= $row->alapitasev ?></td>
                <td><?= $row->alapito ?></td>
                <td><?= $row->tagszam ?> tag</td>
                <td><?= $row->tagdij ?> Ft</td>
            </tr>
        <?php endforeach; ?>
    </table>

    <script>
        console.log("Hello");
        /*window.onload = function () {
            var table = document.getElementById("myTable");
            var rows = table.rows;
            var names = new Array();
            for (var i = 1; i < rows.length; i++) {
                names.push(rows[i]
                    .getElementsByTagName("td")[0]
                    .innerHTML.toLowerCase())
            }
            alert(names)
        };*/
        // Kristóf megoldása
        <?php
            $query = $db->prepare("SELECT nev FROM egyesulet");
            $query->execute();
            $names = $query->fetchAll(PDO::FETCH_COLUMN);
        ?>
        window.onload = function () {
            alert(<?php echo json_encode($names); ?>.join("\n"));
        }
    </script>
</body>

</html>