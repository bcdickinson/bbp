from django.urls import path

from . import views

app_name = 'players'
urlpatterns = [
    path('create/', views.CreatePlayerProfile.as_view(), name='create_player'),
]
