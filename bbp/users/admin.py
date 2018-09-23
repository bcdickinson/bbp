from django.contrib import admin
from django.contrib.auth.admin import UserAdmin

from .models import BBPUser

admin.site.register(BBPUser, UserAdmin)
