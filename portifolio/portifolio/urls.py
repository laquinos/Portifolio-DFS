from django.conf import settings
from django.contrib import admin
from django.urls import include, path
from django.conf.urls.static import static # Importe static

urlpatterns = [
    path("admin/", admin.site.urls),
    path("", include("core.urls")),  # ou a view que você tiver
]

if settings.DEBUG:
    urlpatterns += [path("__reload__/", include("django_browser_reload.urls"))]
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

