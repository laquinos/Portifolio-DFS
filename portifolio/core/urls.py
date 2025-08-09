from django.urls import path
from core.views import *

urlpatterns = [
    path('', home_view, name='home'),
    path('sobre/', sobre_view, name='sobre'),
    path('projetos/', projetos_view, name='projetos'),
    path('contato/', contato_view, name='contato'),
]
