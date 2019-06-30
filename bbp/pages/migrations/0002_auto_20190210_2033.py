# Generated by Django 2.1.5 on 2019-02-10 20:33

from django.db import migrations
import wagtail.core.blocks
import wagtail.core.fields
import wagtail.embeds.blocks
import wagtail.images.blocks


class Migration(migrations.Migration):

    dependencies = [("pages", "0001_initial")]

    operations = [
        migrations.RemoveField(model_name="basicpage", name="introduction"),
        migrations.AlterField(
            model_name="basicpage",
            name="body",
            field=wagtail.core.fields.StreamField(
                [
                    ("heading", wagtail.core.blocks.CharBlock(classname="full title")),
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
        ),
    ]
