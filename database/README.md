# Database

To build a fresh database: `./database/run.fish`.

The script starts `tcd-mariadb`, applies the schema, loads baseline seed data, loads synthetic expansion data for the project row-count requirement, and prints table row counts.

Connect interactively with:

```fish
docker exec -it tcd-mariadb mariadb -uroot -proot -h 127.0.0.1 tcd_stocking
```

Report query scripts for pages 6-16 are in `database/report_queries/`.
