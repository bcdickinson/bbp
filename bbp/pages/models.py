from django.db import models
from wagtail.admin.edit_handlers import FieldPanel, StreamFieldPanel
from wagtail.core import blocks
from wagtail.core.fields import StreamField
from wagtail.core.models import Page
from wagtail.embeds.blocks import EmbedBlock
from wagtail.images.blocks import ImageChooserBlock


class BBPPage(Page):
    introduction = models.TextField()
    body = StreamField([
        ('heading', blocks.CharBlock(classname="full title")),
        ('paragraph', blocks.RichTextBlock(
            features=['h3', 'bold', 'italic', 'ol', 'ul', 'hr', 'link', 'document-link'],
        )),
        ('image', ImageChooserBlock()),
        ('embed', EmbedBlock()),
    ])

    content_panels = Page.content_panels + [
        FieldPanel('introduction'),
        StreamFieldPanel('body'),
    ]
