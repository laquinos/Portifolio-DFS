from django.shortcuts import render
from django.views.generic import TemplateView
from django.http import HttpRequest

def home_view(request: HttpRequest):
    return render(request, "home.html")

def sobre_view(request: HttpRequest):
    return render(request, "sections/sobre.html")

def projetos_view(request: HttpRequest):
    return render(request, "sections/projetos.html")

def contato_view(request: HttpRequest):
    return render(request, "sections/contato.html")
