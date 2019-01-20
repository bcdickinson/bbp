from .base import *  # noqa

DEBUG = False

SECURE_SSL_REDIRECT = True
SECURE_PROXY_SSL_HEADER = 'X-Forwarded-Proto'

SESSION_COOKIE_SECURE = True
SESSION_COOKIE_HTTPONLY = True
