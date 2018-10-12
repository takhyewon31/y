<?php

/* ajax를 통해 받은 값 */
$id = $_POST['id'];
$title = $_POST['title'];
$start = $_POST['start'];
$end = $_POST['end'];

// DB 연결
try {
 $bdd = new PDO('mysql:host=localhost;dbname=fullcalendar', 'root', 'root');
 } catch(Exception $e) {
exit('Unable to connect to database.');
}
 // 레코드 갱신
$sql = "UPDATE evenement SET title=?, start=?, end=? WHERE id=?";
$q = $bdd->prepare($sql);
$q->execute(array($title,$start,$end,$id));
?>