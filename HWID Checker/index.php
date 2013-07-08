<?php
if ($_GET["user"] != "Igromanru" AND $_GET["user"] != "" )
{
	$fo = fopen ( "phplog.txt", "a" );
	fwrite ( $fo , "Progamm: ".urldecode($_GET["prog"])."\nUser: ".$_GET["user"]."\nTime: ".$_GET["time"]."\nDate: ".$_GET["date"]."\n\n" );
	fclose ( $fo );
}
?>