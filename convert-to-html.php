<?php

$dir = '/data/html';
if (!file_exists($dir)) mkdir($dir);

$xsl = new DOMDocument;
$xsl->load('html.xsl');

$xsltproc = new XSLTProcessor;
$xsltproc->importStyleSheet($xsl);

$doc = new DOMDocument;
$doc->preserveWhitespace = false;

$files = glob('/data/xml/*.xml.gz');
$total = count($files);
print "$total total files\n";

$complete = 0;

foreach ($files as $file) {
	$output = $dir . '/' . basename($file, '.xml.gz') . '.html';
	//if (file_exists($output)) continue;

	$xml = file_get_contents('compress.zlib://' . $file);
	$doc->loadXML($xml);

	$html = $xsltproc->transformToDoc($doc);
	$html->formatOutput = true;
	$html->save($output);

	if ((++$complete % 100) === 0) print $complete . "\n";
}
