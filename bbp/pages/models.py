from django.db import models

from wagtail.admin.edit_handlers import StreamFieldPanel, MultiFieldPanel, FieldPanel
from wagtail.core import blocks
from wagtail.core.fields import StreamField
from wagtail.core.models import Page
from wagtail.embeds.blocks import EmbedBlock
from wagtail.images.blocks import ImageChooserBlock
from wagtail.images.edit_handlers import ImageChooserPanel
from wagtail.images.models import Image


class BasicPage(Page):
    show_in_menus_default = True

    hero_image = models.ForeignKey(Image, on_delete=models.SET_NULL, blank=True, null=True)
    strapline = models.CharField(blank=True, max_length=64)

    body = StreamField([
        ('heading', blocks.CharBlock(classname="full title")),
        ('paragraph', blocks.RichTextBlock(
            features=['h2', 'h3', 'h4', 'bold', 'italic', 'ol', 'ul', 'hr', 'link', 'document-link'],
        )),
        ('image', ImageChooserBlock()),
        ('embed', EmbedBlock()),
    ])

    content_panels = Page.content_panels + [
        MultiFieldPanel([
            ImageChooserPanel('hero_image'),
            FieldPanel('strapline'),
        ], heading="Hero image"),
        StreamFieldPanel('body'),
    ]
