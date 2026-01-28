# AGENTS

## Project overview
- Local-first workflow for requirements traceability (RTM) and ADRs, with MkDocs output.
- RTM data lives in `rtm/rtm.tsv`; Markdown tables are generated from it.
- Terminology reference: `/Users/jochen/src/cosmicpython`.

## Workflow
- Bootstrap the dev env with `just bootstrap` (uses `uv`).
- Regenerate RTM Markdown with `just rtm`; do not edit `rtm/rtm.md` or `docs/rtm.md` by hand.
- Serve docs locally with `just docs-serve`; build with `just docs-build`.
- ADRs: follow `docs/adrs/README.md` and use `docs/adrs/0001-record-architecture-decisions.md` as the template.
- You may add or edit files under `specs/`, but do not commit any files in `specs/`.

## RTM schema
- The TSV header must match this exact order:
  `req_id	source	prio	title	acceptance	tests	impl	status	notes`

## Tests
- Run the test suite with `just test` or `uv run pytest`.
- The broader check pipeline is `just check` (RTM generation, tests, and docs build).
