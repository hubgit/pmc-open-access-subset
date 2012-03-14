<?php

$dir = '/data/xml';
if (!file_exists($dir)) mkdir($dir);

$dom = new DOMDocument;
$dom->preserveWhitespace = false;

$files = glob('/data/files/*.xml');
$total = count($files);
print "$total total files\n";

$complete = 0;

foreach ($files as $file) {
    $dom->load($file);
    $dom->formatOutput = true;

    $xpath = new DOMXPath($dom);
    $node = $xpath->query("front/article-meta/article-id[@pub-id-type='pmcid']");
    if (!$node->length) continue;

    $id = $node->item(0)->textContent;
    $output = sprintf('compress.zlib://%s/%d.xml.gz', $dir, $id);
    file_put_contents($output, $dom->saveXML()); 

    if ((++$complete % 100) === 0) print $complete . "\n";
}
