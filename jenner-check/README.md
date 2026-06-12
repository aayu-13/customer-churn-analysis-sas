# Jenner compatibility bundles

This directory was added by a pull request from the
[Jenner](https://jenneranalytics.com) project. Each `tNNN_*` subdirectory
is a SAS bundle derived from code in this repository. Running a bundle
sends its `script.sas` to the Jenner API and confirms the result matches
the snapshot we captured (`expected.json`).

## What's in here

```
jenner-check/
├── README.md            # this file
├── run_jenner.sh        # mac / Linux runner (needs bash + curl)
├── run_jenner.bat       # Windows runner (single-script mode)
├── run_jenner.sas       # run from inside Base SAS 9.4M5+ via PROC HTTP
└── t001_churn_pipeline/
    ├── script.sas       # the SAS under test (from your repo)
    ├── autoexec.sas     # options applied before the script
    ├── expected.json    # the fields we pin on each run
    └── expected/        # human-readable snapshot of the captured run
        ├── log.txt
        ├── output.txt
        └── files.md     # links to the generated listing + plot
```

The bundle is self-contained — `script.sas` writes a sample of your own
`data/churn.csv` to a work file, then runs your `PROC IMPORT` against it,
so there's nothing to download or wire up before running.

## How to run it

From inside `jenner-check/`:

```bash
./run_jenner.sh --all            # run every bundle
./run_jenner.sh t001_churn_pipeline   # run just one
```

From Base SAS (9.4M5 or later):

```sas
%include 'run_jenner.sas';
%jenner_check_all();
```

Or, in one line with curl against the hosted API:

```bash
curl -F script=@t001_churn_pipeline/script.sas \
     https://api.jenneranalytics.com/v1/run
```

You can also paste any bundle's `script.sas` into a hosted workspace at
[jenneranalytics.com](https://jenneranalytics.com) and run it there.

## Optional: Jenner Compatible badge

If you'd like to show Jenner compatibility on your README:

```markdown
[![Jenner Compatible](https://jenneranalytics.com/badges/jenner-compatible.svg)](https://jenneranalytics.com)
```

It's entirely optional — merging this PR commits you to nothing.

## Don't want future PRs from us?

Reply with `no-more-prs` (case-insensitive) anywhere in a comment, or open
an issue titled `jenner-check: opt out`, and we'll stop.
