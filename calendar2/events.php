<?php
// 이벤트 목록
 $json = array();

 // 이벤트 가져오는 쿼리
 $requete = "SELECT * FROM evenement ORDER BY id";

 // DB 연결
 try {
 $bdd = new PDO('mysql:host=localhost;dbname=fullcalendar', 'root', 'root');
 } catch(Exception $e) {
  exit('Unable to connect to database.');
 }
 // 쿼리 실행
 $resultat = $bdd->query($requete) or die(print_r($bdd->errorInfo()));

 // 페이지 전송
 echo json_encode($resultat->fetchAll(PDO::FETCH_ASSOC));

?>