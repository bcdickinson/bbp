from wagtail.admin.edit_handlers import StreamFieldPanel
from wagtail.core import blocks
from wagtail.core.fields import StreamField
from wagtail.core.models import Page
from wagtail.embeds.blocks import EmbedBlock
from wagtail.images.blocks import ImageChooserBlock


class BasicPage(Page):
    show_in_menus_default = True

    body = StreamField([
        ('heading', blocks.CharBlock(classname="full title")),
        ('paragraph', blocks.RichTextBlock(
            features=['h2', 'h3', 'h4', 'bold', 'italic', 'ol', 'ul', 'hr', 'link', 'document-link'],
        )),
        ('image', ImageChooserBlock()),
        ('embed', EmbedBlock()),
    ])

    content_panels = Page.content_panels + [
        StreamFieldPanel('body'),
    ]
