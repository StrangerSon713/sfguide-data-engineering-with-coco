# coco-de-guide

Project plugin for the CoCo data engineering guide dbt project (`DEMO_DB.TPCH_TRANSFORMED`).

It includes:

- **Skills** (`skills/`): `new-dbt-model`, which creates a dbt model using `source()` references, adds primary key tests to `_schema.yml`, and validates it with `dbt build`.
- **Agents** (`agents/`): subagents for project-specific delegated tasks.
- **Hooks** (`hooks/hooks.json`): automated commands that run on agent events.
