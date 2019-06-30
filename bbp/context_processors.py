import os


def sentry_dsn(request):
    return {"SENTRY_DSN": os.environ.get("SENTRY_DSN")}
