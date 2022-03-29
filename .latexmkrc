#!/usr/bin/env perl
$latex            = 'uplatex -halt-on-error %O %S';
$latex_silent     = 'uplatex -halt-on-error -interaction=nonstopmode %O %S';
$bibtex           = 'ubibtex';
$dvipdf           = 'dvipdfmx %O -o %D %S';
$makeindex        = 'mendex %O -o %D %S';
$pdf_mode         = 3;
$pvc_view_file_via_temporary = 0;
$pdf_previewer    = "evince";
