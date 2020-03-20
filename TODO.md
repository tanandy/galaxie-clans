# TODO

* Postfix secondary
* Log rotation + rsyslog ?


sydent trouve pas les templates
suppression de room
integration server not found
dimension configuration access token on matrix HomeServer

register_new_matrix_user -u dimension -p mesgenoux --no-admin -c /etc/matrix-synapse/homeserver.yaml

curl -XPOST -d '{"type":"m.login.password", "user":"dimension", "password":"mesgenoux"}' "https://localhost:8448/_matrix/client/r0/login"



# change password
curl -XPOST -H "Authorization: Bearer <access_token>"
-H "Content-Type: application/json" -d '{"new_password":"<new_password>"}'
"https://localhost:8448/_matrix/client/r0/admin/reset_password/<userId>"



https://github.com/matrix-org/synapse/tree/master/docs/admin_api
DELETE ROOM ===> LIST ROOMS + FIND + SHUTDOWN ROOM + PURGE ROOM
