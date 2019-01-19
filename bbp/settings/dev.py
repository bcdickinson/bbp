from .base import *  # noqa

DEBUG = True

ALLOWED_HOSTS = locals().get('ALLOWED_HOSTS', []) + ['localhost', '127.0.0.1']
