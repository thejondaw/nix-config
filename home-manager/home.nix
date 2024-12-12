{ config, pkgs, ... }:

{
 
home.file = {
  ".config/hypr/hyprland.conf".source = ./hyprland.conf;
};
 
  home = {
    username = "jondaw";
    homeDirectory = "/home/jondaw";
    stateVersion = "24.11";
    
    # Пакеты для Hyprland
    packages = with pkgs; [

    # Основной интерфейс
    hyprpaper          # Современные обои
    eww                # Продвинутый бар и виджеты
    anyrun             # Современный лаунчер
    mako               # Нативные уведомления для Wayland

    # Системные утилиты
    libnotify          # Поддержка уведомлений
    wl-clipboard       # Базовый буфер обмена  
    cliphist           # История буфера обмена
    brightnessctl      # Управление яркостью
    pamixer            # Управление звуком
    
    # Файловые менеджеры и утилиты
    kdePackages.dolphin            # Основной файл-менеджер
    kdePackages.dolphin-plugins    # Плагины для dolphin
    ffmpegthumbs       # Превью видео в dolphin
    kde-cli-tools      # Диалоги открытия файлов
    
    # Системные GUI
    pavucontrol        # Микшер звука
    blueman            # Управление Bluetooth
    networkmanagerapplet # Сетевой апплет
    gnome-system-monitor
    
    # Мультимедиа
    easyeffects        # Эквалайзер
    mpv                # Видеоплеер
    imv                # Просмотр изображений
    
    # Скриншоты и запись
    grimblast          # Улучшенные скриншоты
    swappy             # Редактор скриншотов
    
    # Внешний вид и темы
    papirus-icon-theme
    nwg-look           # GTK темы
   # kvantum-manager    # Qt темы
    libsForQt5.qt5ct
    catppuccin-gtk     # Современная тема
    
    # Системные утилиты с GUI
    wlogout            # Меню выхода
    swaylock-effects   # Блокировка экрана
    
    # Дополнительно
    hyprpicker         # Пипетка цвета
    wl-gammactl        # Управление гаммой/яркостью
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    ];
  };



  # Git
  programs.git = {
    enable = true;
    userName = "thejondaw";
    userEmail = "mrjondaw@gmail.com";
  };

  # Waybar config
  programs.waybar = {
    enable = true;
  };
}
