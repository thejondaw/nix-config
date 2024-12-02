{
 programs.btop = {
   enable = true;
   settings = {
     # Основные опции
     vim_keys = true;                    # Поддержка vim-like навигации
     truecolor = true;                   # Поддержка true color
     force_tty = false;                  # Принудительный режим TTY
     presets = "cpu:1:default,proc:0:default,net:2:default,mem:3:default";  # Порядок и пресеты окон
     
     # Отображение по умолчанию
     color_theme = "Default";            # Тема по умолчанию
     theme_background = false;           # Не использовать цвет фона из темы
     tree_view = true;                   # Древовидное отображение процессов (как в htop)
     
     # Обновление
     update_ms = 1000;                   # Интервал обновления в мс
     proc_sorting = "cpu";               # Сортировка процессов по CPU
     
     # Сети
     net_download = 100;                 # Предел загрузки сети в Mebibits
     net_upload = 100;                   # Предел отдачи сети в Mebibits
     
     # Графики
     graph_symbol = "braille";           # Тип символов для графиков
     proc_gradient = true;               # Градиент в списке процессов
     graph_gradient = true;              # Градиент в графиках
     
     # CPU
     cpu_graph_lower = "system";         # Нижняя часть графика CPU
     cpu_graph_upper = "user";           # Верхняя часть графика CPU
     
     # Память
     mem_graphs = true;                  # Показывать графики памяти
     
     # IO диски
     io_graph_speeds = "5";              # Максимальная скорость IO в MB/s
     io_mode = false;                    # Режим отображения IO
   };
 };
}