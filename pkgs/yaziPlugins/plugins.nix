{
  buildYaziPlugin,
  inputs,
}: _: _: {
  full-border = buildYaziPlugin {
    pname = "full-border";
    version = "git";
    src = inputs.yazi-plugins + "/full-border.yazi";
    meta.homepage = "https://github.com/yazi-rs/plugins/tree/main/full-border.yazi";
  };

  ouch = buildYaziPlugin {
    pname = "ouch";
    version = "git";
    src = inputs.yazi-ouch-src;
    meta.homepage = "https://github.com/ndtoan96/ouch.yazi";
  };

  git = buildYaziPlugin {
    pname = "git";
    version = "git";
    src = inputs.yazi-plugins + "/git.yazi";
    meta.homepage = "https://github.com/yazi-rs/plugins/tree/main/git.yazi";
  };

  toggle-pane = buildYaziPlugin {
    pname = "toggle-pane";
    version = "git";
    src = inputs.yazi-plugins + "/toggle-pane.yazi";
    meta.homepage = "https://github.com/yazi-rs/plugins/tree/main/toggle-pane.yazi";
  };

  smart-enter = buildYaziPlugin {
    pname = "smart-enter";
    version = "git";
    src = inputs.yazi-plugins + "/smart-enter.yazi";
    meta.homepage = "https://github.com/yazi-rs/plugins/tree/main/smart-enter.yazi";
  };

  glow = buildYaziPlugin {
    pname = "glow";
    version = "git";
    src = inputs.yazi-glow-src;
    meta.homepage = "https://github.com/Reledia/glow.yazi";
  };

  hexyl = buildYaziPlugin {
    pname = "hexyl";
    version = "git";
    src = inputs.yazi-hexyl-src;
    meta.homepage = "https://github.com/Reledia/hexyl.yazi";
  };

  restore = buildYaziPlugin {
    pname = "restore";
    version = "git";
    src = inputs.yazi-restore-src;
    meta.homepage = "https://github.com/boydaihungst/restore.yazi";
  };
}
