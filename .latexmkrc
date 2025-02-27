# Flush buffers to improve VimTeX output
STDOUT->autoflush;
STDERR->autoflush;

# Asymptote support
sub run_asy {
    return system("asy -o \$(dirname '$_[0]') '$_[0]'");
}
add_cus_dep("asy", "eps", 0, "run_asy");
add_cus_dep("asy", "pdf", 0, "run_asy");
add_cus_dep("asy", "tex", 0, "run_asy");

# Bibtex compatibility
$bibtex_use = 2;

# File extensions to clean
@generated_exts = (
    "aux",
    "auxlock",
    "bbl*",
    "bcf*",
    "blg",
    "brf",
    "cb",
    "cb2",
    "cps*",
    "fdb_latexmk",
    "fls",
    "idx",
    "ind",
    "lof",
    "log",
    "lot",
    "mw",
    "nav",
    "nlg",
    "nlo",
    "nls",
    "nmo",
    "out",
    "pgf-plot.*",
    "pre",
    "pytxcode",
    "pytxmcr",
    "pytxpyg",
    "run.xml",
    "snm",
    "spl",
    "synctex(busy)",
    "synctex.gz",
    "tdo",
    "toc",
);
