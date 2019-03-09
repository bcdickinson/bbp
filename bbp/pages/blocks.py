from wagtail.core.blocks import CharBlock, StructBlock
from wagtail.images.blocks import ImageChooserBlock


class HeroImageBlock(StructBlock):
    image = ImageChooserBlock()
    tagline = CharBlock()
