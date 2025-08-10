from django.shortcuts import render
from django.views.generic import TemplateView
from django.http import HttpRequest
from core.models import *

def home_view(request: HttpRequest):
    contexto = {}
    try:
        # Usamos seu modelo 'Imagens' para buscar o objeto com o nome "Perfil"
        imagem_de_perfil = Imagens.objects.get(nome="Perfil") # <<-- MUDANÇA AQUI
        contexto['imagem_perfil'] = imagem_de_perfil
    except Imagens.DoesNotExist: # <<-- MUDANÇA AQUI
        pass

    return render(request, "home.html", contexto)

def sobre_view(request: HttpRequest):
    return render(request, "sections/sobre.html")

def projetos_view(request: HttpRequest):
    return render(request, "sections/projetos.html")

def contato_view(request: HttpRequest):
    return render(request, "sections/contato.html")
