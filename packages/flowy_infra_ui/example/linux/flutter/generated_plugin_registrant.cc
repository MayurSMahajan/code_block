//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <flowy_infra_ui/flowy_infra_u_i_plugin.h>
#include <url_launcher_linux/url_launcher_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) flowy_infra_ui_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FlowyInfraUIPlugin");
  flowy_infra_u_i_plugin_register_with_registrar(flowy_infra_ui_registrar);
  g_autoptr(FlPluginRegistrar) url_launcher_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "UrlLauncherPlugin");
  url_launcher_plugin_register_with_registrar(url_launcher_linux_registrar);
}