<?php
try {
    $db = new PDO("mysql:host=localhost;dbname=mintazh", "root", "");
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    printf('Sikertelen kapcsolódás: ' . $e->getMessage());
    exit;
}
$searchTerm = isset($_GET['kereses']) ? $_GET['kereses'] : '';
$sortColumn = isset($_GET['oszlop']) ? $_GET['oszlop'] : 'nev';
$query = $db->query("SELECT e.nev AS nev, e.alapitasev As alapitasev, alapito.nev AS alapito, count(em.nev) AS tagszam, e.tagdij AS tagdij
    FROM egyesulet e
        INNER JOIN tagsag t ON e.egyesuletid = t.egyesulet_egyesuletid
        INNER JOIN ember em ON t.ember_emberid = em.emberid
        INNER JOIN ember alapito ON e.alapitoid = alapito.emberid
        WHERE e.nev LIKE '%$searchTerm%'
        GROUP BY e.nev
        ORDER BY $sortColumn;");

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
            <th><a href="?oszlop=nev&kereses=<?= urlencode($searchTerm) ?>" style="<?= $sortColumn === 'nev' ? 'text-decoration: underline;' : '' ?>">Név</a></th>
            <th><a href="?oszlop=alapitasev&kereses=<?= urlencode($searchTerm) ?>" style="<?= $sortColumn === 'alapitasev' ? 'text-decoration: underline;' : '' ?>">Alapítás éve</a></th>
            <th><a href="?oszlop=alapito&kereses=<?= urlencode($searchTerm) ?>" style="<?= $sortColumn === 'alapito' ? 'text-decoration: underline;' : '' ?>">Alapító</a></th>
            <th><a href="?oszlop=tagszam&kereses=<?= urlencode($searchTerm) ?>" style="<?= $sortColumn === 'tagszam' ? 'text-decoration: underline;' : '' ?>">Tagok száma</a></th>
            <th><a href="?oszlop=tagdij&kereses=<?= urlencode($searchTerm) ?>" style="<?= $sortColumn === 'tagdij' ? 'text-decoration: underline;' : '' ?>">Tagsági díj</a></th>
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
        function search() {
            var name = document.getElementById("nameInput").value.toLowerCase();
            var table = document.getElementById("myTable");
            var rows = table.rows;
            for (var i = 1; i < rows.length; i++) {
                var cellText = rows[i]
                    .getElementsByTagName("td")[0]
                    .innerHTML.toLowerCase();
                if (cellText.includes(name)) {
                    rows[i].style.display = ""; // Show row
                } else {
                    rows[i].style.display = "none"; // Hide row
                }
            }
        }

        window.onload = function () {
            var table = document.getElementById("myTable");
            var rows = table.rows;
            var names = new Array();
            for (var i = 1; i < rows.length; i++) {
                names.push(rows[i]
                    .getElementsByTagName("td")[0]
                    .innerHTML.toLowerCase())
            }
            //alert(names);
        };
    </script>
</body>

</html>