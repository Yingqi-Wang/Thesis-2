# Jenner compatibility bundles

This directory was added by a pull request from the
[Jenner](https://jenneranalytics.com) project. Each `tNNN_*` subdirectory
is a small, self-contained SAS bundle derived from code in this
repository, set up to run against the Jenner SAS-compatible engine.

## What's in here

```
jenner-check/
├── README.md            # this file
├── run_jenner.sh        # runner (macOS / Linux)
├── run_jenner.bat       # runner (Windows)
├── run_jenner.sas       # runner (run from within SAS / Jenner)
└── tNNN_<slug>/
    ├── script.sas       # the SAS under test, adapted from a repo script
    ├── autoexec.sas     # small synthetic input data + options
    ├── expected.json    # stable fields pinned from a passing run
    ├── expected/        # human-readable snapshot (log, output, file URLs)
    └── meta.json        # which repo file this came from + what was adapted
```

Each bundle's `autoexec.sas` stands up a tiny synthetic version of the
DUA-protected CMS tables the original scripts read, so the analytic logic
runs in isolation. The SAS in `script.sas` is the author's own code; only
the library/path references were redirected to the bundled sample data.

## Running

From this directory:

```sh
./run_jenner.sh --all          # run every bundle
./run_jenner.sh t001_table2_drug_summary_sql   # run one
```

Each bundle posts its `autoexec.sas` + `script.sas` to the Jenner API and
prints the status, exit code, and log. You can also paste any `script.sas`
straight into the hosted workspace at <https://jenneranalytics.com>.
