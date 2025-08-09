from django.conf import settings
from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path("admin/", admin.site.urls),
    path("", include("core.urls")),  # ou a view que você tiver
]

if settings.DEBUG:
    urlpatterns += [path("__reload__/", include("django_browser_reload.urls"))]
