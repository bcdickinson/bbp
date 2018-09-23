from django.db import models


class PlayerProfile(models.Model):
    user = models.OneToOneField('users.BBPUser', on_delete=models.CASCADE)
    city = models.CharField(max_length=64)
