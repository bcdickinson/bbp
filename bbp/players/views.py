from django.http import HttpResponseRedirect
from django.views.generic.edit import CreateView

from .models import PlayerProfile


class CreatePlayerProfile(CreateView):
    model = PlayerProfile
    fields = ['city']
    template_name = 'players/create_player.html'

    def form_valid(self, form):
        self.object = form.save(commit=False)
        self.object.user = self.request.user
        self.object.save()

        return HttpResponseRedirect(self.get_success_url())

    def get_success_url(self):
        return self.request.site.root_page.get_url(self.request)
