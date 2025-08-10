from django.contrib import admin
from core.models import *

# Register your models here.
@admin.register(Imagens)
class imagensAdmin(admin.ModelAdmin):
    list_display = ('nome', 'slug')