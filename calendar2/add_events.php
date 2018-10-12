// ajax 통해 받은 값
$title = $_POST['title'];
$start = $_POST['start'];
$end = $_POST['end'];
$url = $_POST['url'];
// DB 연결
try {
$bdd = new PDO('mysql:host=localhost;dbname=fullcalendar', 'root', 'root');
} catch(Exception $e) {
exit('Unable to connect to database.');
}

// 레코드 삽입
$sql = "INSERT INTO evenement (title, start, end, url) VALUES (:title, :start, :end, :url)";
$q = $bdd->prepare($sql);
$q->execute(array(':title'=>$title, ':start'=>$start, ':end'=>$end,  ':url'=>$url));
?>