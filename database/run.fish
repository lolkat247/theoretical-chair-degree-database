#!/usr/bin/env fish

# Stand up a fresh MariaDB container, apply the schema from create/main.sql,
# and verify all tables landed. Idempotent — safe to re-run.

set script_dir (path dirname (status filename))
set sql_dir    $script_dir/create
set container  tcd-mariadb
set image      mariadb:11.4
set root_pw    root

# 1. Tear down any existing container so re-runs are clean.
docker rm -f $container >/dev/null 2>&1

# 2. Start the container with the SQL directory mounted read-only at /sql.
echo "Starting MariaDB container..."
docker run -d \
    --name $container \
    -e MARIADB_ROOT_PASSWORD=$root_pw \
    -p 3306:3306 \
    -v $sql_dir:/sql:ro \
    $image >/dev/null
or begin
    echo "Failed to start container"
    exit 1
end

# 3. Wait until MariaDB is accepting connections over TCP.
# Note: connecting via `-h 127.0.0.1` to bypass MariaDB 11.x unix_socket auth
# plugin, which rejects password-based root logins over the local socket.
echo -n "Waiting for MariaDB"
set ready 0
for i in (seq 1 60)
    if docker exec $container mariadb -uroot -p$root_pw -h 127.0.0.1 -e "SELECT 1" >/dev/null 2>&1
        set ready 1
        echo " ready."
        break
    end
    echo -n "."
    sleep 1
end
if test $ready -eq 0
    echo ""
    echo "MariaDB never became ready. Last container logs:"
    docker logs --tail 40 $container
    exit 1
end

# 4. Apply main.sql, which SOURCEs every other file from /sql inside the container.
echo "Applying schema..."
docker exec -i $container mariadb -uroot -p$root_pw -h 127.0.0.1 < $sql_dir/main.sql
and echo "Schema applied successfully."
or begin
    echo "Schema apply failed."
    exit 1
end

# 5. Sanity check — list created tables.
echo ""
echo "Tables in tcd_stocking:"
docker exec $container mariadb -uroot -p$root_pw -h 127.0.0.1 -e "USE tcd_stocking; SHOW TABLES;"
