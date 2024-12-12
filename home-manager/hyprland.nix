{ config, pkgs, ... }:

{
    wayland.windowManager.hyprland = {
      enable = true;
        settings = {

          # Настройки монитора
          monitor = ",1920x1200@60,auto,1";

          # Переменные окружения
          env = [
            "XDG_CURRENT_DESKTOP,Hyprland"
            "XDG_SESSION_TYPE,wayland"
            "XDG_SESSION_DESKTOP,Hyprland"
            "XCURSOR_SIZE,36"
            "QT_QPA_PLATFORM,wayland"
            "XDG_SCREENSHOTS_DIR,~/Pictures/Screenshots"
        ];

    # Настройки ввода (клавиатура, тачпад)
    input = {
    kb_layout = "us,ru";
    kb_options = "grp:alt_shift_toggle";
    follow_mouse = 1;

    touchpad = {
        natural_scroll = true;
        tap-to-click = true;
        drag_lock = true;
    };

        sensitivity = 0;
    };

    exec-once = [
    # Воркспейсы
    ] ++ [
      "hyprctl dispatcher workspace 1"
      "hyprctl dispatcher workspace 2"
      "hyprctl dispatcher workspace 3"
      "hyprctl dispatcher workspace 4"
      "hyprctl dispatcher workspace 5"
    ] ++ [
      # Основные компоненты
      "hyprpaper"
      "eww daemon && eww open bar"
      "mako"
    ] ++ [
      # Системные службы
      "polkit-kde-authentication-agent-1"
      "/usr/lib/xdg-desktop-portal-hyprland"
      "nm-applet --indicator"
      "blueman-applet"
    ] ++ [
      # Буфер обмена
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
    ] ++ [
      # Автоблокировка
      "swayidle -w timeout 300 'swaylock-effects' timeout 600 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'"
    ];

     # Настройка воркспейсов
     workspace = [
       "3, default:true"
       "1, monitor:eDP-1, persistent:true"
       "2, monitor:eDP-1, persistent:true"
       "3, monitor:eDP-1, persistent:true"
       "4, monitor:eDP-1, persistent:true"
       "5, monitor:eDP-1, persistent:true"
     ];

    # Основные настройки интерфейса
    general = {
      gaps_in = 5;
      gaps_out = 20;
      border_size = 3;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
      layout = "dwindle";
    };

    # Настройки декораций окон
    decoration = {
      rounding = 10;
      blur = {
        enabled = true;
        size = 16;
        passes = 2;
        new_optimizations = true;
        ignore_opacity = true;
    };
    };

    # Настройки анимаций
    animations = {
      enabled = true;
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
    ];
    };

    # Настройки тайлинга
    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

     # Настройки жестов тачпада
     gestures = {
       workspace_swipe = true;
       workspace_swipe_fingers = 3;
       workspace_swipe_invert = false;
       workspace_swipe_distance = 200;
       workspace_swipe_forever = true;
     };

     # Дополнительные настройки
     misc = {
       animate_manual_resizes = true;
       animate_mouse_windowdragging = true;
       enable_swallow = true;
       disable_hyprland_logo = true;
       disable_splash_rendering = true;
     };

     # Правила для окон
     windowrulev2 = [
       "opacity 0.90 0.90,^(.*)$"
       "float,class:^(pavucontrol)$"
       "float,class:^(nm-connection-editor)$"
       "float,class:^(imv)$"
       "float,class:^(mpv)$"
       "float,class:^(dolphin)$"
     ];

     bind = [
       # Основные клавиши
       "SUPER, Return, exec, alacritty"         # Win+Enter: Терминал
       "SUPER, Q, killactive"                   # Win+Q: Закрыть окно
       "SUPER SHIFT, E, exit"                   # Win+Shift+E: Выход
       "SUPER, Space, exec, anyrun"             # Win+Space: Запуск программ
       "SUPER, E, exec, dolphin"                # Win+E: Файлы
       "SUPER, L, exec, swaylock-effects"       # Win+L: Блокировка

       # Управление окнами
       "SUPER, F, togglefloating"               # Win+F: Плавающее окно
       "ALT, Tab, cyclenext"                    # Alt+Tab: Следующее окно
       "ALT SHIFT, Tab, cyclenext, prev"        # Alt+Shift+Tab: Предыдущее окно
       "SUPER, F11, fullscreen, 0"              # Win+F11: Полный экран

       # Медиа клавиши
       ", XF86AudioMicMute, exec, pamixer --default-source -t"    # F4: Микрофон
       ", XF86AudioRaiseVolume, exec, pamixer -i 5"              # F3: Громкость +
       ", XF86AudioLowerVolume, exec, pamixer -d 5"              # F2: Громкость -
       ", XF86AudioMute, exec, pamixer -t"                       # F1: Звук вкл/выкл
       ", XF86MonBrightnessUp, exec, brightnessctl set +5%"      # F6: Яркость +
       ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"    # F5: Яркость -

       # Скриншоты
       ", Print, exec, grimblast --notify copy area"             # PrtSc: Область
       "SHIFT, Print, exec, grimblast --notify copy screen"      # Shift+PrtSc: Весь экран
       "SUPER, Print, exec, grimblast --notify copy active"      # Win+PrtSc: Активное окно

       # Навигация
       "SUPER, left, movefocus, l"                              # Win+←: Фокус влево
       "SUPER, right, movefocus, r"                             # Win+→: Фокус вправо
       "SUPER, up, movefocus, u"                                # Win+↑: Фокус вверх
       "SUPER, down, movefocus, d"                              # Win+↓: Фокус вниз

       # Перемещение окон
       "SUPER SHIFT, left, movewindow, l"                       # Win+Shift+←: Двигать влево
       "SUPER SHIFT, right, movewindow, r"                      # Win+Shift+→: Двигать вправо
       "SUPER SHIFT, up, movewindow, u"                         # Win+Shift+↑: Двигать вверх
       "SUPER SHIFT, down, movewindow, d"                       # Win+Shift+↓: Двигать вниз

       # Размер окон
       "SUPER CTRL, left, resizeactive, -40 0"                  # Win+Ctrl+←: Уже
       "SUPER CTRL, right, resizeactive, 40 0"                  # Win+Ctrl+→: Шире
       "SUPER CTRL, up, resizeactive, 0 -40"                    # Win+Ctrl+↑: Ниже
       "SUPER CTRL, down, resizeactive, 0 40"                   # Win+Ctrl+↓: Выше

       # Рабочие столы (только 5)
       "SUPER, 1, workspace, 1"                                 # Win+1: Воркспейс 1
       "SUPER, 2, workspace, 2"                                 # Win+2: Воркспейс 2
       "SUPER, 3, workspace, 3"                                 # Win+3: Воркспейс 3
       "SUPER, 4, workspace, 4"                                 # Win+4: Воркспейс 4
       "SUPER, 5, workspace, 5"                                 # Win+5: Воркспейс 5

       # Перемещение на воркспейсы
       "SUPER SHIFT, 1, movetoworkspacesilent, 1"              # Win+Shift+1: На воркспейс 1
       "SUPER SHIFT, 2, movetoworkspacesilent, 2"              # Win+Shift+2: На воркспейс 2
       "SUPER SHIFT, 3, movetoworkspacesilent, 3"              # Win+Shift+3: На воркспейс 3
       "SUPER SHIFT, 4, movetoworkspacesilent, 4"              # Win+Shift+4: На воркспейс 4
       "SUPER SHIFT, 5, movetoworkspacesilent, 5"              # Win+Shift+5: На воркспейс 5

       # Навигация по воркспейсам мышью/тачпадом
       "SHIFT, mouse_down, workspace, e+1"                      # Shift+Колесо вниз: След. воркспейс
       "SHIFT, mouse_up, workspace, e-1"                        # Shift+Колесо вверх: Пред. воркспейс
       
       # Динамический ресайз
       "SUPER, mouse:272, movewindow"                          # Win+ЛКМ: Перемещение окна
       "SUPER, mouse:273, resizewindow"                        # Win+ПКМ: Ресайз окна
       "SUPER ALT, mouse:272, submap, resize"                  # Win+Alt+ЛКМ: Интерактивный ресайз
       
       # Тачпад - ресайз жестами
       "SUPER ALT, touchpad:3, resizewindow"                   # Win+Alt+3 пальца: Ресайз
       "SUPER, touchpad:4, togglefloating"                     # Win+4 пальца: Плавающий режим
     ];

     # Жесты тачпада
     bindgesture = [
       "swipe:3:left, workspace, e+1"                          # 3 пальца влево: След. стол
       "swipe:3:right, workspace, e-1"                         # 3 пальца вправо: Пред. стол
       "swipe:4:up, exec, wlogout"                             # 4 пальца вверх: Выход
       "swipe:4:down, exec, anyrun"                            # 4 пальца вниз: Запуск
     ];
   };
 };
}
