# Generated by Django 2.1.7 on 2019-04-06 18:58

from django.db import migrations
import wagtail.core.blocks
import wagtail.core.fields
import wagtail.embeds.blocks
import wagtail.images.blocks


class Migration(migrations.Migration):

    dependencies = [("pages", "0004_auto_20190402_2115")]

    operations = [
        migrations.AlterField(
            model_name="basicpage",
            name="body",
            field=wagtail.core.fields.StreamField(
                [
                    (
                        "paragraph",
                        wagtail.core.blocks.RichTextBlock(
                            features=[
                                "h2",
                                "h3",
                                "h4",
                                "bold",
                                "italic",
                                "ol",
                                "ul",
                                "hr",
                                "link",
                                "document-link",
                            ]
                        ),
                    ),
                    ("image", wagtail.images.blocks.ImageChooserBlock()),
                    ("embed", wagtail.embeds.blocks.EmbedBlock()),
                ]
            ),
        )
    ]
