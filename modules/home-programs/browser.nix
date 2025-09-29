{ config, pkgs, ... }:

{
  config.programs.firefox = {
    enable = true;
    # package = pkgs.librewolf;

    profiles.default = {
      userChrome = builtins.concatStringsSep "\n" [
        (builtins.readFile "${pkgs.minifox}/chrome/userChrome.css")
        (builtins.readFile "${pkgs.minifox}/chrome/browser/icons.css")
        (builtins.readFile "${pkgs.minifox}/chrome/browser/main.css")
        (builtins.readFile "${pkgs.minifox}/chrome/browser/url-bar.css")
        (builtins.readFile "${pkgs.minifox}/chrome/browser/vertical.css")
        (builtins.readFile "${pkgs.minifox}/chrome/browser/window-controls.css")
      ];

      extraConfig = builtins.concatStringsSep "\n" [
        # (builtins.readFile "${betterfox}/Securefox.js")
        (builtins.readFile "${pkgs.betterfox}/Fastfox.js")
        (builtins.readFile "${pkgs.betterfox}/Peskyfox.js")
        (builtins.readFile "${pkgs.pkgs.minifox}/user.js")
      ];

      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        re-enable-right-click
        don-t-fuck-with-paste
        proton-pass

        sponsorblock
        return-youtube-dislikes

        enhanced-github
        refined-github
        github-file-icons
        reddit-enhancement-suite
      ];
      settings = {
        # General
        "intl.accept_languages" = "en-US,en";
        "browser.startup.page" = 3; # Resume previous session on startup
        "browser.aboutConfig.showWarning" = false; # I sometimes know what I'm doing
        "browser.ctrlTab.sortByRecentlyUsed" = false; # (default) Who wants that?
        "browser.download.useDownloadDir" = false; # Ask where to save stuff
        "browser.translations.neverTranslateLanguages" = "ru"; # No need :)
        "privacy.clearOnShutdown.history" = false; # We want to save history on exit
        # Allow executing JS in the dev console
        "devtools.chrome.enabled" = true;
        # Disable browser crash reporting
        "browser.tabs.crashReporting.sendReport" = false;
        # Allow userCrome.css
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        "layout.css.backdrop-filter.enabled" = true;
        "layers.acceleration.force-enabled" = true;

        "uc.tweak.round-browser" = true;
        "uc.tweak.browser-margins" = true;
        "uc.tweak.translucency" = true;
        "uc.tweak.bottom-nav" = false;
        "uc.tweak.no-window-controls" = true;
        
        # Why the fuck can my search window make bell sounds
        "accessibility.typeaheadfind.enablesound" = false;
        # Why the fuck can my search window make bell sounds
        "general.autoScroll" = true;

        # Hardware acceleration
        # See https://github.com/elFarto/nvidia-vaapi-driver?tab=readme-ov-file#firefox
        "gfx.webrender.enebled" = true;
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.rdd-ffmpeg.enabled" = true;
        "widget.dmabuf.force-enabled" = true;
        "media.av1.enabled" = false;
        "media.ffvpx.enabled" = false;
        "media.rdd-vpx.enabled" = false;

        # Privacy
        "privacy.donottrackheader.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.userContext.enabled" = true;
        "privacy.userContext.ui.enabled" = true;

        "browser.send_pings" = false; # (default) Don't respect <a ping=...>

        # This allows firefox devs changing options for a small amount of users to test out stuff.
        # Not with me please ...
        "app.normandy.enabled" = false;
        "app.shield.optoutstudies.enabled" = false;

        "beacon.enabled" = false; # No bluetooth location BS in my webbrowser please
        "device.sensors.enabled" = false; # This isn't a phone
        "geo.enabled" = false; # Disable geolocation alltogether

        # ESNI is deprecated ECH is recommended
        "network.dns.echconfig.enabled" = true;

        # Disable telemetry for privacy reasons
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.enabled" = false; # enforced by nixos
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.unified" = false;
        "extensions.webcompat-reporter.enabled" = false; # don't report compability problems to mozilla
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "browser.ping-centre.telemetry" = false;
        "browser.urlbar.eventTelemetry.enabled" = false; # (default)

        # Disable some useless stuff
        "extensions.pocket.enabled" = false; # disable pocket, save links, send tabs
        "extensions.abuseReport.enabled" = false; # don't show 'report abuse' in extensions
        "extensions.formautofill.creditCards.enabled" = false; # don't auto-fill credit card information
        "identity.fxaccounts.enabled" = true; # enable firefox login
        "identity.fxaccounts.toolbar.enabled" = true;
        "identity.fxaccounts.pairing.enabled" = true;
        "identity.fxaccounts.commands.enabled" = true;
        "browser.contentblocking.report.lockwise.enabled" = false; # don't use firefox password manger
        "browser.uitour.enabled" = false; # no tutorial please
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

        # disable EME encrypted media extension (Providers can get DRM
        # through this if they include a decryption black-box program)
        "browser.eme.ui.enabled" = false;
        "media.eme.enabled" = false;

        # don't predict network requests
        "network.predictor.enabled" = false;
        "browser.urlbar.speculativeConnect.enabled" = false;

        # disable annoying web features
        "dom.push.enabled" = false; # no notifications, really...
        "dom.push.connection.enabled" = false;
        "dom.battery.enabled" = false; # you don't need to see my battery...
      };
      search = {
        force = true;
        default = "google";
        order = ["google" "ddg" "NixOS Options" "Nix Packages" "GitHub"];

        engines = {

          "Nix Packages" = {
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          "NixOS Options" = {
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@no"];
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          "GitHub" = {
            icon = "https://github.com/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@gh"];

            urls = [
              {
                template = "https://github.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
        };
      };
    };
  };

  config.programs.librewolf = {
    enable = true;
    # Enable WebGL, cookies and history
    settings = {
      "webgl.disabled" = false;
      "privacy.resistFingerprinting" = false;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cookies" = false;
      "network.cookie.lifetimePolicy" = 0;
    };
  };
}
