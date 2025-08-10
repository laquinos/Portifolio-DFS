from django.db import models

# Create your models here.

class Imagens(models.Model):
    nome = models.CharField(max_length=255, verbose_name="Nome")
    slug = models.SlugField(max_length=255, unique=True)
    imagem = models.ImageField(upload_to='imagens/')

    class Meta:
        verbose_name = "Imagem"
        verbose_name_plural = "Imagens"

    def __str__(self):
        return self.nome

    