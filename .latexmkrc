# Flush buffers to improve VimTeX output
STDOUT->autoflush;
STDERR->autoflush;

# File extensions to clean
push @generated_exts, "aux";
push @generated_exts, "auxlock";
push @generated_exts, "bbl";
push @generated_exts, "bcf";
push @generated_exts, "blg";
push @generated_exts, "brf";
push @generated_exts, "cb";
push @generated_exts, "cb2";
push @generated_exts, "cps*";
push @generated_exts, "fdb_latexmk";
push @generated_exts, "fls";
push @generated_exts, "log";
push @generated_exts, "mw";
push @generated_exts, "nav";
push @generated_exts, "nlg";
push @generated_exts, "nlo";
push @generated_exts, "nls";
push @generated_exts, "nmo";
push @generated_exts, "out";
push @generated_exts, "pgf-plot.*";
push @generated_exts, "run.xml";
push @generated_exts, "snm";
push @generated_exts, "spl";
push @generated_exts, "synctex(busy)";
push @generated_exts, "synctex.gz";
push @generated_exts, "tdo";
push @generated_exts, "toc";
