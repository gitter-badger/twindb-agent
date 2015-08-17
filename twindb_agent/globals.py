"""
Global variables
"""
# global variables
config_file = "/etc/twindb.cfg"

ssh_private_key_file = "/root/.ssh/twindb.key"
ssh_public_key_file = "/root/.ssh/twindb.key.pub"
ssh_port = 4194

pid_file = "/var/run/twindb-agent.pid"
check_period = 1
time_zone = "UTC"
mysql_user = None
mysql_password = None

gpg_homedir = "/root/.gnupg/"

api_email = "api@twindb.com"
api_host = "dispatcher.twindb.com"
api_proto = "http"
api_dir = ""
api_uri = "api.php"
api_pub_key = """
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1

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
Q7n4+TygXY9zVA==
=62IM
-----END PGP PUBLIC KEY BLOCK-----
"""
