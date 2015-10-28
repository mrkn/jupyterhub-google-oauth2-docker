# Configuration file for JupyterHub

import os
import oauthenticator

c = get_config()

# spawn with Docker
c.JupyterHub.spawner_class = 'dockerspawner.DockerSpawner'

c.DockerSpawner.use_docker_client_env = True
c.DockerSpawner.tls_assert_hostname = False

# The docker instances need access to the Hub, so the default loopback port doesn't work:
from jupyter_client.localinterfaces import public_ips
c.JupyterHub.hub_ip = public_ips()[0]

# OAuth with Google
c.JupyterHub.authenticator_class = 'oauthenticator.GoogleOAuthenticator'

c.GoogleOAuthenticator.oauth_callback_url = os.environ['OAUTH_CALLBACK_URL']
c.GoogleOAuthenticator.oauth_client_id = os.environ['OAUTH_CLIENT_ID']
c.GoogleOAuthenticator.oauth_client_secret = os.environ['OAUTH_CLIENT_SECRET']

if os.environ['HOSTED_DOMAIN']:
    c.GoogleOAuthenticator.hosted_domain = os.environ['HOSTED_DOMAIN']

# ssl config
here = os.path.dirname(__file__)
ssl = os.path.join(here, 'ssl')
keyfile = os.path.join(ssl, 'ssl.key')
certfile = os.path.join(ssl, 'ssl.cert')
if os.path.exists(keyfile):
    c.JupyterHub.ssl_key = keyfile
if os.path.exists(certfile):
    c.JupyterHub.ssl_cert = certfile
