import * as Sentry from '@sentry/browser';

if (typeof SENTRY_DSN !== 'undefined') {
  Sentry.init({ dsn: SENTRY_DSN });
}
