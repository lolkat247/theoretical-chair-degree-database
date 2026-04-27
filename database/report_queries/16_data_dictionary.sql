SELECT
    table_name,
    column_name,
    column_type,
    is_nullable,
    column_key,
    column_default,
    extra,
    column_comment
FROM information_schema.COLUMNS
WHERE table_schema = 'tcd_stocking'
ORDER BY table_name, ordinal_position;
