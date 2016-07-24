#!/usr/bin/perl
 
# obmenu-generator - schema file
 
=for comment
 
    item:      add an item inside the menu               {item => ["command", "label", "icon"]},
    cat:       add a category inside the menu             {cat => ["name", "label", "icon"]},
    sep:       horizontal line separator                  {sep => undef}, {sep => "label"},
    pipe:      a pipe menu entry                         {pipe => ["command", "label", "icon"]},
    raw:       any valid Openbox XML string               {raw => q(xml string)},
    begin_cat: begin of a category                  {begin_cat => ["name", "icon"]},
    end_cat:   end of a category                      {end_cat => undef},
    obgenmenu: generic menu settings                {obgenmenu => ["label", "icon"]},
    exit:      default "Exit" action                     {exit => ["label", "icon"]},
 
=cut
 
# NOTE:
#    * Keys and values are case sensitive. Keep all keys lowercase.
#    * ICON can be a either a direct path to an icon or a valid icon name
#    * Category names are case insensitive. (X-XFCE and x_xfce are equivalent)
 
require "$ENV{HOME}/.config/obmenu-generator/config.pl";
 
## Text editor
my $editor = $CONFIG->{editor};
 
our $SCHEMA = [
    #          COMMAND                 LABEL                ICON
    {item => ['termite -e mutt',        'Cliente de email',      'mutt']},
    {item => ['firefox',    'Navegador Web',       'web-browser']},
    {sep => undef},
    {sep => 'Aplicativos'},
 
    #          NAME            LABEL                ICON
    {cat => ['utility',     'Acessórios', 'applications-utilities']},
    {cat => ['settings',    'Configurações',    'applications-accessories']},
    {cat => ['development', 'Desenvolvimento', 'applications-development']},
    {cat => ['education',   'Educativos',   'applications-science']},
    {cat => ['office',      'Escritório',      'applications-office']},
    {cat => ['graphics',    'Gráficos',    'applications-graphics']},
    {cat => ['network',     'Internet',     'applications-internet']},
    {cat => ['game',        'Jogos',       'applications-games']},
    {cat => ['audiovideo',  'Multimídia',  'applications-multimedia']},
    #{cat => ['other',       'Outros',       'applications-other']},
    {cat => ['system',      'Sistema',      'applications-system']},
 
    #            COMMAND     LABEL        ICON
 
    ## Generic advanced settings
    #{sep       => undef},
    #{obgenmenu => ['Openbox Settings', 'applications-engineering']},
    #{sep       => undef},
 
    ## Custom advanced settings.
    {sep => undef},
    {begin_cat => ['Configurações Avançadas', 'gnome-settings']},
 
        # obmenu-generator category.
        {begin_cat => ['Obmenu-Generator', 'menu-editor']},
            {item      => ["$editor ~/.config/obmenu-generator/schema.pl", 'Menu Schema', $editor]},
            {item      => ["$editor ~/.config/obmenu-generator/config.pl", 'Menu Config', $editor]},
 
            {sep  => undef},
            {item => ['obmenu-generator -p',    'Generate a pipe menu',              'menu-editor']},
            {item => ['obmenu-generator -s',    'Generate a static menu',            'menu-editor']},
            {item => ['obmenu-generator -p -i', 'Generate a pipe menu with icons',   'menu-editor']},
            {item => ['obmenu-generator -s -i', 'Generate a static menu with icons', 'menu-editor']},
            {sep  => undef},
 
            {item    => ['obmenu-generator -d', 'Refresh Icon Set', 'gtk-refresh']},
        {end_cat => undef},
 
        # Openbox category.
        {begin_cat => ['Openbox', 'openbox']},
            {item      => ["$editor ~/.config/openbox/autostart", 'Editar autostart',    $editor]},
            {item      => ["$editor ~/.config/openbox/menu.xml",  'Editar menu.xml',         $editor]},
            {item      => ["$editor ~/.config/openbox/rc.xml",    'Editar rc.xml',           $editor]},
            {item      => ['openbox --reconfigure',               'Reconfigurar Openbox', 'openbox']},
        {end_cat => undef},
 
        # Configuration files.
        {item      => ["$editor ~/.conkyrc",              'Editar conkyrc',    $editor]},
        {item      => ["$editor ~/.config/tint2/tint2rc", 'Editar tint2rc', $editor]},
        {item      => ["$editor ~/.Xdefaults",            'Editar xdefaults', $editor]},
 
    {end_cat => undef},
    {sep => undef},
 
 
    # Replace the standard Openbox's action "Exit" with "obsession" script.
    #{exit => ['Exit', 'exit']},
    {item => ['oblogout', 'exit']},
]