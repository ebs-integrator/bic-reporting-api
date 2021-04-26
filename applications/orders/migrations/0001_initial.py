# Generated by Django 3.1.6 on 2021-03-03 12:18

from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('companies', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Order',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('timestamp', models.DateTimeField(default=django.utils.timezone.now)),
                ('edited_timestamp', models.DateTimeField(default=django.utils.timezone.now)),
                ('xml', models.TextField(default='')),
                ('data', models.JSONField(null=True)),
                ('timestamp_ordered', models.DateTimeField(auto_now_add=True)),
                ('company', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='companies.company')),
            ],
            options={
                'ordering': ['id'],
                'abstract': False,
            },
        ),
    ]