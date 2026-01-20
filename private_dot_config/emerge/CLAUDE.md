# emerge

Local-first workflow tool for requirements traceability (RTM) and architecture decision records (ADRs).

## Quick Reference

```bash
just bootstrap      # Initialize venv and install dependencies
just rtm            # Generate RTM markdown from TSV
just test           # Run pytest
just check          # Full pipeline: RTM + tests + docs build
just docs-serve     # Serve docs locally
```

## Project Structure

- `src/emerge/` - Python package (RTM schema)
- `tools/rtm_to_md.py` - TSV-to-Markdown converter
- `rtm/rtm.tsv` - Source requirements data
- `docs/` - MkDocs documentation site
- `docs/adrs/` - Architecture decision records
- Terminology reference: `/Users/jochen/src/cosmicpython`

## Development

- Python 3.11+ with `uv` for package management
- Run `just bootstrap` to set up the environment
- Pre-commit hooks handle formatting and validation
- ADRs: follow `docs/adrs/README.md` and use `docs/adrs/0001-record-architecture-decisions.md` as the template

## RTM Schema

Columns: `req_id | source | prio | title | acceptance | tests | impl | status | notes`

The converter (`tools/rtm_to_md.py`) generates markdown tables from `rtm/rtm.tsv` to both `rtm/rtm.md` and `docs/rtm.md`.

## Testing

```bash
just test           # Run all tests
uv run pytest -v    # Verbose output
```

Tests are in `tests/` and cover the RTM converter functionality.
